-- Doctor Hunt — Supabase schema (full snapshot of the live database).
-- Run this in the Supabase project's SQL editor (SQL → New query → Run).
-- Idempotent: safe to re-run. Reflects migrations 20261001170135 →
-- 20261001221608 (admin data, RLS hardening, patient access, user model,
-- doctor location, images bucket, reviews, patient relations).
--
-- Role model
--   • auth.users             — Supabase-managed credentials.
--   • public.users           — one profile row per auth user (patient | admin),
--                              auto-created by the on_auth_user_created trigger.
--   • public.admin_users     — trusted admin authority (never user_metadata,
--                              which users can edit). is_admin() reads this.
--   • public.patient_users   — trusted patient authority. is_patient() reads it.
-- Patients (or anonymous) read only active doctors and the clinic profile;
-- authenticated patients read/insert their own appointments.

create extension if not exists "pgcrypto";

-- ── Tables ──────────────────────────────────────────────────────────────────

-- Profile row mirrored from auth.users (constraint names kept as profiles_*
-- from before the rename to `users`).
create table if not exists public.users (
  id         uuid primary key references auth.users(id) on delete cascade,
  name       text not null,
  email      text not null,
  role       text not null check (role in ('patient', 'admin')),
  phone      text,
  photo      text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- Trusted authority tables (RLS on, no policies: only definer functions +
-- the service role read them).
create table if not exists public.patient_users (
  user_id    uuid primary key references auth.users(id) on delete cascade,
  created_at timestamptz not null default now()
);

create table if not exists public.admin_users (
  user_id    uuid primary key references auth.users(id) on delete cascade,
  created_at timestamptz not null default now()
);

create table if not exists public.doctors (
  id             uuid primary key default gen_random_uuid(),
  name           text not null,
  specialty      text not null check (
                   specialty in (
                     'dentist', 'cardiologist',
                     'ophthalmologist', 'gastroenterologist'
                   )
                 ),
  fee            numeric not null default 0,
  photo          text,
  rating         numeric not null default 0,
  reviews_count  integer not null default 0,
  is_active      boolean not null default true,
  availability   jsonb not null default
                 '{"workingDays":[1,2,3,4,5],"startMinute":540,"endMinute":1020,"slotMinutes":30}'::jsonb,
  latitude       double precision,
  longitude      double precision,
  location_label text,
  created_at     timestamptz not null default now()
);

create table if not exists public.appointments (
  id             uuid primary key default gen_random_uuid(),
  doctor_id      uuid references public.doctors(id) on delete set null,
  doctor_name    text not null,
  specialty      text not null,
  doctor_photo   text,
  patient_id     uuid references public.users(id) on delete set null,
  patient_name   text not null,
  patient_email  text not null,
  patient_photo  text,
  date_time      timestamptz not null,
  fee            numeric not null default 0,
  status         text not null default 'upcoming' check (
                   status in ('upcoming', 'completed', 'cancelled')
                 ),
  rating         numeric,
  review_comment text,
  reviewed_at    timestamptz,
  created_at     timestamptz not null default now()
);

create table if not exists public.admin_profile (
  id              uuid primary key default gen_random_uuid(),
  name            text not null,
  email           text not null,
  clinic_location text not null,
  photo           text
);

-- A patient's favourite doctors (composite PK prevents duplicates).
create table if not exists public.favourites (
  patient_id uuid not null references auth.users(id) on delete cascade,
  doctor_id  uuid not null references public.doctors(id) on delete cascade,
  created_at timestamptz not null default now(),
  primary key (patient_id, doctor_id)
);

-- ── Indexes ───────────────────────────────────────────────────────────────
create index if not exists doctors_specialty_idx     on public.doctors (specialty);
create index if not exists doctors_active_idx        on public.doctors (is_active);
create index if not exists appointments_status_idx   on public.appointments (status);
create index if not exists appointments_doctor_id_idx  on public.appointments (doctor_id);
create index if not exists appointments_patient_id_idx on public.appointments (patient_id);
create index if not exists favourites_patient_idx      on public.favourites (patient_id);

-- ── Functions ───────────────────────────────────────────────────────────────

-- ── Authority helpers (SECURITY DEFINER, locked search_path) ─────────────────
create or replace function public.is_admin()
returns boolean language sql security definer set search_path = '' as $$
  select exists (
    select 1 from public.admin_users au where au.user_id = auth.uid()
  );
$$;
revoke all on function public.is_admin() from public;
revoke execute on function public.is_admin() from anon;
grant execute on function public.is_admin() to authenticated;

create or replace function public.is_patient()
returns boolean language sql security definer set search_path = '' as $$
  select exists (
    select 1 from public.patient_users pu where pu.user_id = auth.uid()
  );
$$;
revoke all on function public.is_patient() from public;
revoke execute on function public.is_patient() from anon;
grant execute on function public.is_patient() to authenticated;

-- email_exists: used at sign-up (pre-auth) to check a duplicate email, so it is
-- intentionally callable by anon. search_path is locked and the body fully
-- schema-qualifies auth.users. NOTE: exposing it to anon permits email
-- enumeration — accepted here for the sign-up UX; revoke anon if that changes.
create or replace function public.email_exists(p_email text)
returns boolean language sql security definer set search_path = '' as $$
  select exists (
    select 1 from auth.users where lower(email) = lower(p_email)
  );
$$;

-- Public reviews for a doctor (completed appointments that carry a rating).
create or replace function public.doctor_reviews(p_doctor_id uuid)
returns table(patient_name text, rating numeric, review_comment text, created_at timestamptz)
language sql security definer set search_path = '' as $$
  select patient_name, rating, review_comment, created_at
  from public.appointments
  where doctor_id = p_doctor_id and rating is not null
  order by reviewed_at desc nulls last, created_at desc;
$$;
grant execute on function public.doctor_reviews(uuid) to authenticated;

-- A patient rates their own completed appointment; the doctor's aggregate
-- (rating + reviews_count) is recomputed from real reviews.
create or replace function public.submit_review(p_appointment_id uuid, p_rating numeric, p_comment text)
returns void language plpgsql security definer set search_path = '' as $$
declare
  v_email text := auth.jwt() ->> 'email';
  v_doctor uuid;
begin
  if p_rating is null or p_rating < 1 or p_rating > 5 then
    raise exception 'Rating must be between 1 and 5';
  end if;

  update public.appointments
     set rating = p_rating,
         review_comment = nullif(btrim(coalesce(p_comment, '')), ''),
         reviewed_at = now()
   where id = p_appointment_id
     and patient_email = v_email
     and status = 'completed'
  returning doctor_id into v_doctor;

  if v_doctor is null then
    raise exception 'Appointment not found, not yours, or not completed';
  end if;

  update public.doctors d
     set rating = sub.avg_rating,
         reviews_count = sub.cnt
    from (
      select round(avg(rating)::numeric, 2) as avg_rating, count(*)::int as cnt
      from public.appointments
      where doctor_id = v_doctor and rating is not null
    ) sub
   where d.id = v_doctor and sub.cnt > 0;
end;
$$;
grant execute on function public.submit_review(uuid, numeric, text) to authenticated;

-- On new auth user: create the profile row and, for patients, the authority
-- row. Execute is restricted to the trigger owner (postgres/service_role).
create or replace function public.handle_new_user()
returns trigger language plpgsql security definer set search_path = '' as $$
declare
  v_role text := case
    when (new.raw_user_meta_data ->> 'role') = 'admin' then 'admin' else 'patient'
  end;
begin
  insert into public.users (id, name, email, role)
  values (new.id, coalesce(new.raw_user_meta_data ->> 'name', ''), new.email, v_role)
  on conflict (id) do nothing;

  if v_role = 'patient' then
    insert into public.patient_users (user_id) values (new.id)
    on conflict (user_id) do nothing;
  end if;
  return new;
end;
$$;
revoke execute on function public.handle_new_user() from public, anon, authenticated;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_user();

-- ── Seed ──────────────────────────────────────────────────────────────────
insert into public.admin_profile (name, email, clinic_location)
select 'Ahmed Khaled', 'admin@doctorhunt.com', 'Central Clinic · 24 Garden Avenue'
where not exists (select 1 from public.admin_profile);

insert into public.doctors (name, specialty, fee, photo, rating, reviews_count, is_active)
select * from (values
  ('Dr. Fillerup Grab',  'dentist',            30, 'assets/images/home/moc1.png',  4.8, 124, true),
  ('Dr. Addison Smith',  'cardiologist',       28, 'assets/images/home/moc1.png',  4.6,  98, true),
  ('Dr. Bennett Mccoy',  'ophthalmologist',    26, 'assets/images/home/mock2.png', 4.5,  76, true),
  ('Dr. Shruti Kedia',   'dentist',            24, 'assets/images/home/moc1.png',  4.9, 143, true),
  ('Dr. Crownover',      'gastroenterologist', 19, 'assets/images/home/mock2.png', 4.4,  52, true),
  ('Dr. Watamaniuk',     'cardiologist',       21, 'assets/images/home/mock2.png', 4.2,  31, false)
) as seed(name, specialty, fee, photo, rating, reviews_count, is_active)
where not exists (select 1 from public.doctors);

insert into public.appointments
  (doctor_name, specialty, doctor_photo, patient_name, patient_email,
   date_time, fee, status, rating, review_comment)
select * from (values
  ('Dr. Addison Smith', 'cardiologist', 'assets/images/home/moc1.png',
    'Maya Patel', 'maya.patel@example.com',
    timestamptz '2026-10-02 10:30', 28, 'upcoming', null::numeric, null::text),
  ('Dr. Shruti Kedia', 'dentist', 'assets/images/home/mock2.png',
    'James Wilson', 'james.wilson@example.com',
    timestamptz '2026-10-08 14:00', 32, 'upcoming', null, null),
  ('Dr. Fillerup Grab', 'dentist', 'assets/images/home/moc1.png',
    'Olivia Martin', 'olivia.martin@example.com',
    timestamptz '2026-09-21 09:00', 30, 'completed', 4.8,
    'Very professional and kind.'),
  ('Dr. Crownover', 'gastroenterologist', 'assets/images/home/mock2.png',
    'Ethan Brooks', 'ethan.brooks@example.com',
    timestamptz '2026-08-18 15:30', 26, 'cancelled', null, null)
) as seed(doctor_name, specialty, doctor_photo, patient_name, patient_email,
          date_time, fee, status, rating, review_comment)
where not exists (select 1 from public.appointments);

-- @@POLICIES@@
-- ── Row-level security ───────────────────────────────────────────────────────
alter table public.users          enable row level security;
alter table public.patient_users  enable row level security;
alter table public.admin_users    enable row level security;
alter table public.doctors        enable row level security;
alter table public.appointments   enable row level security;
alter table public.admin_profile  enable row level security;
alter table public.favourites     enable row level security;
-- patient_users / admin_users: RLS on, no policies (definer functions + the
-- service role only).

-- users: one SELECT policy (own profile OR admin); update is own-only.
drop policy if exists users_select on public.users;
create policy users_select on public.users
  for select to authenticated
  using ((select auth.uid()) = id or (select public.is_admin()));
drop policy if exists users_update on public.users;
create policy users_update on public.users
  for update to authenticated
  using ((select auth.uid()) = id) with check ((select auth.uid()) = id);

-- doctors: one SELECT policy per role. anon's never calls is_admin() (anon lacks
-- EXECUTE on it); authenticated sees active rows OR, for admins, everything.
drop policy if exists doctors_select_public on public.doctors;
create policy doctors_select_public on public.doctors
  for select to anon using (is_active = true);
drop policy if exists doctors_select_authenticated on public.doctors;
create policy doctors_select_authenticated on public.doctors
  for select to authenticated using (is_active = true or (select public.is_admin()));
drop policy if exists doctors_insert on public.doctors;
create policy doctors_insert on public.doctors
  for insert to authenticated with check ((select public.is_admin()));
drop policy if exists doctors_update on public.doctors;
create policy doctors_update on public.doctors
  for update to authenticated using ((select public.is_admin())) with check ((select public.is_admin()));
drop policy if exists doctors_delete on public.doctors;
create policy doctors_delete on public.doctors
  for delete to authenticated using ((select public.is_admin()));

-- appointments: one policy per action. SELECT/INSERT allow admins OR the owning
-- patient (patient_email = JWT email); UPDATE/DELETE are admin-only. Function
-- calls wrapped in (select ...) so they run once per statement, not per row.
drop policy if exists appointments_select on public.appointments;
create policy appointments_select on public.appointments
  for select to authenticated
  using ((select public.is_admin()) or patient_email = ((select auth.jwt()) ->> 'email'));
drop policy if exists appointments_insert on public.appointments;
create policy appointments_insert on public.appointments
  for insert to authenticated
  with check ((select public.is_admin()) or patient_email = ((select auth.jwt()) ->> 'email'));
drop policy if exists appointments_update on public.appointments;
create policy appointments_update on public.appointments
  for update to authenticated using ((select public.is_admin())) with check ((select public.is_admin()));
drop policy if exists appointments_delete on public.appointments;
create policy appointments_delete on public.appointments
  for delete to authenticated using ((select public.is_admin()));

-- admin_profile: readable by all (clinic location is shown to patients too),
-- editable only by an admin.
drop policy if exists admin_profile_select on public.admin_profile;
create policy admin_profile_select on public.admin_profile
  for select to anon, authenticated using (true);
drop policy if exists admin_profile_update on public.admin_profile;
create policy admin_profile_update on public.admin_profile
  for update to authenticated using ((select public.is_admin())) with check ((select public.is_admin()));

-- Grant admin to a user (and set user_metadata.role='admin' so the APP routes
-- them to the admin UI — UX only, not a security boundary):
--   insert into public.admin_users (user_id) values ('<auth-user-uuid>');

-- favourites: a patient reads/creates/deletes only their own rows.
drop policy if exists favourites_select on public.favourites;
create policy favourites_select on public.favourites
  for select to authenticated using (patient_id = (select auth.uid()));
drop policy if exists favourites_insert on public.favourites;
create policy favourites_insert on public.favourites
  for insert to authenticated with check (patient_id = (select auth.uid()));
drop policy if exists favourites_delete on public.favourites;
create policy favourites_delete on public.favourites
  for delete to authenticated using (patient_id = (select auth.uid()));

-- ── Storage: public `images` bucket (avatars/ + doctors/) ───────────────────
insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values ('images', 'images', true, 5242880,
        array['image/jpeg', 'image/png', 'image/webp'])
on conflict (id) do update
  set public = excluded.public,
      file_size_limit = excluded.file_size_limit,
      allowed_mime_types = excluded.allowed_mime_types;

drop policy if exists "images public read" on storage.objects;
create policy "images public read" on storage.objects
  for select to anon, authenticated using (bucket_id = 'images');

-- Patients may upload to avatars/; only admins may upload to doctors/.
drop policy if exists "images insert" on storage.objects;
create policy "images insert" on storage.objects
  for insert to authenticated with check (
    bucket_id = 'images' and (
      (storage.foldername(name))[1] = 'avatars'
      or ((storage.foldername(name))[1] = 'doctors' and public.is_admin())
    )
  );

drop policy if exists "images admin update" on storage.objects;
create policy "images admin update" on storage.objects
  for update to authenticated
  using (bucket_id = 'images' and public.is_admin())
  with check (bucket_id = 'images' and public.is_admin());

drop policy if exists "images admin delete" on storage.objects;
create policy "images admin delete" on storage.objects
  for delete to authenticated using (bucket_id = 'images' and public.is_admin());

-- ── Infra guardrail (present in the live DB) ────────────────────────────────
-- An event trigger that auto-enables RLS on every new table created in the
-- `public` schema. Added out-of-band; recreating it needs superuser rights, so
-- it is left here for reference only (uncomment to reproduce on a fresh clone).
--
-- create or replace function public.rls_auto_enable()
--   returns event_trigger language plpgsql security definer
--   set search_path = 'pg_catalog' as $$
-- declare cmd record;
-- begin
--   for cmd in
--     select * from pg_event_trigger_ddl_commands()
--     where command_tag in ('CREATE TABLE','CREATE TABLE AS','SELECT INTO')
--       and object_type in ('table','partitioned table')
--   loop
--     if cmd.schema_name = 'public' then
--       execute format('alter table if exists %s enable row level security', cmd.object_identity);
--     end if;
--   end loop;
-- end;
-- $$;
-- create event trigger ensure_rls on ddl_command_end execute function public.rls_auto_enable();
-- revoke all on function public.rls_auto_enable() from public, anon, authenticated;

