# `features/admin/`

Everything only an **admin** can reach. Currently empty — the role exists in
`common/auth/data/models/role.dart` and the routing shell is ready for it.

Suggested layout when the first admin screens land, mirroring `patient/`:

```
admin/
  dashboard/     overview metrics
  doctors/       create / edit / approve doctors
  patients/      patient records
  appointments/  schedule management
  data/models/   admin-only models
```

Anything both roles need (auth, settings, shared widgets) belongs in
`../common/`, not here.
