---
description: Do not add comments unless the user explicitly asks
alwaysApply: true
---

# No unsolicited comments

Do not add comments when writing, editing, or generating code unless the user explicitly asks for comments in that request.

## What not to add

- Explanatory `//` or `///` comments
- Section banners (`// --- Widget ---`)
- TODO/FIXME/NOTE comments
- Doc comments on classes, constructors, fields, or methods
- Commented-out code

```dart
// ❌ BAD — unsolicited comments
/// Loads workouts from local storage.
Future<List<Workout>> loadWorkouts() {
  // Fetch from Hive then map to domain models
  return _box.getWorkouts();
}

// ✅ GOOD — code only
Future<List<Workout>> loadWorkouts() {
  return _box.getWorkouts();
}
```

## Exception

Add comments only when the user asks for them (e.g. “add comments”, “document this”, “explain this line”).
