import 'package:doctor_hunt/apps/core/services/storage_service.dart';
import 'package:doctor_hunt/apps/features/admin/appointments/presentation/controllers/appointment_details/appointment_details_cubit.dart';
import 'package:doctor_hunt/apps/features/admin/appointments/presentation/controllers/appointments_list/appointments_list_cubit.dart';
import 'package:doctor_hunt/apps/features/admin/doctors/presentation/controllers/availability/availability_cubit.dart';
import 'package:doctor_hunt/apps/features/admin/doctors/presentation/controllers/doctor_details/doctor_details_cubit.dart';
import 'package:doctor_hunt/apps/features/admin/doctors/presentation/controllers/doctor_form/doctor_form_cubit.dart';
import 'package:doctor_hunt/apps/features/admin/doctors/presentation/controllers/doctors_list/doctors_list_cubit.dart';
import 'package:doctor_hunt/apps/features/admin/settings/presentation/controllers/admin_profile/admin_profile_cubit.dart';
import 'package:doctor_hunt/apps/features/admin/settings/presentation/controllers/change_password/change_password_cubit.dart';
import 'package:doctor_hunt/apps/features/common/admin_profile/data/repo/admin_profile_repo.dart';
import 'package:doctor_hunt/apps/features/common/admin_profile/data/repo/supabase_admin_profile_repo.dart';
import 'package:doctor_hunt/apps/features/common/appointments/data/repo/appointments_repo.dart';
import 'package:doctor_hunt/apps/features/common/appointments/data/repo/supabase_appointments_repo.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/repo/auth_repo.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/service/supabase_service.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/controllers/forget_pass/forget_pass_bloc.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/controllers/login/login_bloc.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/controllers/register/register_bloc.dart';
import 'package:doctor_hunt/apps/features/common/doctors/data/repo/doctors_repo.dart';
import 'package:doctor_hunt/apps/features/common/doctors/data/repo/supabase_doctors_repo.dart';
import 'package:doctor_hunt/apps/features/common/favorites/data/repo/favorites_repo.dart';
import 'package:doctor_hunt/apps/features/common/favorites/data/repo/supabase_favorites_repo.dart';
import 'package:doctor_hunt/apps/features/common/profile/data/repo/profile_repo.dart';
import 'package:doctor_hunt/apps/features/common/profile/presentation/controllers/current_profile/current_profile_cubit.dart';
import 'package:doctor_hunt/apps/features/common/profile/data/repo/supabase_profile_repo.dart';
import 'package:doctor_hunt/apps/features/patient/booking/presentation/controllers/booking/booking_cubit.dart';
import 'package:doctor_hunt/apps/features/patient/main/data/catalog/patient_catalog.dart';
import 'package:doctor_hunt/apps/features/patient/main/presentation/controllers/appointments_refresh/appointments_refresh_cubit.dart';
import 'package:doctor_hunt/apps/features/patient/main/presentation/controllers/favorites/favorites_cubit.dart';
import 'package:doctor_hunt/apps/features/patient/main/presentation/controllers/patient_appointments/patient_appointments_cubit.dart';
import 'package:doctor_hunt/apps/features/patient/main/presentation/controllers/patient_settings/patient_settings_cubit.dart';
import 'package:doctor_hunt/apps/features/patient/appointment/presentation/controllers/patient_appointment_details/patient_appointment_details_cubit.dart';
import 'package:doctor_hunt/apps/features/patient/profile/presentation/controllers/patient_profile/patient_profile_cubit.dart';
import 'package:doctor_hunt/apps/features/common/doctors/data/models/doctor_specialty.dart';
import 'package:doctor_hunt/apps/features/patient/specialty/presentation/controllers/specialty_doctors/specialty_doctors_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);

  getIt.registerLazySingleton<SupabaseService>(
    () => SupabaseService(getIt<SupabaseClient>()),
  );

  getIt.registerLazySingleton<StorageService>(
    () => StorageService(getIt<SupabaseClient>()),
  );

  getIt.registerLazySingleton<AuthRepo>(
    () => AuthRepo(getIt<SupabaseService>()),
  );

  getIt.registerLazySingleton<DoctorsRepo>(
    () => SupabaseDoctorsRepo(getIt<SupabaseClient>()),
  );
  getIt.registerLazySingleton<AppointmentsRepo>(
    () => SupabaseAppointmentsRepo(getIt<SupabaseClient>()),
  );
  getIt.registerLazySingleton<AdminProfileRepo>(
    () => SupabaseAdminProfileRepo(getIt<SupabaseClient>()),
  );
  getIt.registerLazySingleton<ProfileRepo>(
    () => SupabaseProfileRepo(getIt<SupabaseClient>()),
  );
  getIt.registerLazySingleton<CurrentProfileCubit>(
    () => CurrentProfileCubit(getIt<ProfileRepo>()),
  );
  getIt.registerLazySingleton<FavoritesRepo>(
    () => SupabaseFavoritesRepo(getIt<SupabaseClient>()),
  );

  getIt.registerLazySingleton<PatientCatalog>(
    () => PatientCatalog(getIt<DoctorsRepo>(), getIt<AdminProfileRepo>()),
  );

  getIt.registerFactory<ForgotPasswordBloc>(
    () => ForgotPasswordBloc(getIt<AuthRepo>()),
  );
  getIt.registerFactory<LoginBloc>(() => LoginBloc(getIt<AuthRepo>()));
  getIt.registerFactory<RegisterBloc>(() => RegisterBloc(getIt<AuthRepo>()));

  getIt.registerFactory<DoctorsListCubit>(
    () => DoctorsListCubit(getIt<DoctorsRepo>()),
  );
  getIt.registerFactory<DoctorFormCubit>(
    () => DoctorFormCubit(getIt<DoctorsRepo>(), getIt<StorageService>()),
  );
  getIt.registerFactory<DoctorDetailsCubit>(
    () => DoctorDetailsCubit(getIt<DoctorsRepo>()),
  );
  getIt.registerFactory<AvailabilityCubit>(
    () => AvailabilityCubit(getIt<DoctorsRepo>()),
  );
  getIt.registerFactory<AppointmentsListCubit>(
    () => AppointmentsListCubit(getIt<AppointmentsRepo>()),
  );
  getIt.registerFactory<AppointmentDetailsCubit>(
    () => AppointmentDetailsCubit(getIt<AppointmentsRepo>()),
  );
  getIt.registerLazySingleton<AdminProfileCubit>(
    () => AdminProfileCubit(getIt<AdminProfileRepo>(), getIt<StorageService>()),
  );
  getIt.registerFactory<ChangePasswordCubit>(
    () => ChangePasswordCubit(getIt<AuthRepo>()),
  );

  getIt.registerLazySingleton<FavoritesCubit>(
    () => FavoritesCubit(getIt<FavoritesRepo>()),
  );
  getIt.registerFactory<PatientProfileCubit>(
    () => PatientProfileCubit(getIt<ProfileRepo>(), getIt<StorageService>()),
  );
  getIt.registerFactory<PatientSettingsCubit>(
    () => PatientSettingsCubit(getIt<ProfileRepo>()),
  );
  getIt.registerLazySingleton<AppointmentsRefreshCubit>(
    AppointmentsRefreshCubit.new,
  );
  getIt.registerFactory<PatientAppointmentDetailsCubit>(
    () => PatientAppointmentDetailsCubit(getIt<AppointmentsRepo>()),
  );
  getIt.registerFactory<PatientAppointmentsCubit>(
    () => PatientAppointmentsCubit(getIt<AppointmentsRepo>()),
  );
  getIt.registerFactoryParam<SpecialtyDoctorsCubit, DoctorSpecialty, void>(
    (specialty, _) => SpecialtyDoctorsCubit(getIt<DoctorsRepo>(), specialty),
  );
  getIt.registerFactory<BookingCubit>(
    () => BookingCubit(
      getIt<DoctorsRepo>(),
      getIt<AppointmentsRepo>(),
      getIt<AuthRepo>(),
      getIt<ProfileRepo>(),
    ),
  );
}
