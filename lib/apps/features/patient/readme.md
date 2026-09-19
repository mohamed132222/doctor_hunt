# `features/patient/`

Everything a **patient** can reach after signing in. Nothing here should be
imported by `admin/`.

| Folder            | What lives here                                                           |
|-------------------|---------------------------------------------------------------------------|
| `main/`           | The bottom-nav shell and its tabs: home, favourites, my bookings, chat    |
| `doctor_details/` | Doctor profile, stats, services and clinic map                            |
| `search/`         | Doctor search and results                                                 |
| `booking/`        | Date and time-slot selection                                              |
| `appointment/`    | Patient details form, date/time/reminder step, and the confirmation popup |
| `data/models/`    | Patient-facing models, e.g. `Doctor`                                      |

Shared pieces come from `../common/`. Anything that turns out to be needed by
the admin side as well should be promoted to `common/` rather than copied.
