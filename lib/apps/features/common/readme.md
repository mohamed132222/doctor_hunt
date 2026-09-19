# `features/common/`

Screens and models shared by **both** roles (`patient` and `admin`).

| Folder        | What lives here                                                                                  |
|---------------|--------------------------------------------------------------------------------------------------|
| `auth/`       | Choose role, login, register, and the auth sheets (forgot password, verify code, reset password) |
| `onboarding/` | The 3-slide onboarding flow                                                                      |
| `splash/`     | The launch screen                                                                                |

Rule of thumb: if a patient-only and an admin-only screen would both need it,
it belongs here rather than being duplicated into both role folders.
