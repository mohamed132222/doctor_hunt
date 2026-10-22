---
description: Core philosophy — pragmatism first, SRP/DRY, accurate naming
alwaysApply: true
---

# Core philosophy & code quality

Apply these when writing, refactoring, or reviewing Dart/Flutter code.

## Pragmatism first

Ship the simplest design that solves the current need and can grow later. Do not add layers, abstractions, generics, or “future-proof” APIs until a real second use exists.

```dart
// ❌ BAD — abstraction with no second consumer
abstract class WorkoutStore { Future<List<Workout>> load(); }
class HiveWorkoutStore implements WorkoutStore { ... }

// ✅ GOOD — concrete code for the actual need
class WorkoutRepository {
  Future<List<Workout>> loadWorkouts() => _box.getWorkouts();
}
```

## Clean code (SRP & DRY)

- **SRP:** one class/function, one reason to change. Split UI, I/O, and business rules.
- **DRY:** extract a shared helper when the same logic appears twice with the same meaning. Do not force-merge similar-looking but different code.

```dart
// ❌ BAD — widget loads data, maps, and paints
class WorkoutScreen extends StatelessWidget { /* fetch + parse + UI */ }

// ✅ GOOD — screen displays; repository loads
class WorkoutScreen extends StatelessWidget { /* UI only */ }
class WorkoutRepository { Future<List<Workout>> loadWorkouts() { ... } }
```

## Naming

Names must describe role and meaning, not type or implementation noise. Prefer `loadWorkouts` over `getData`, `WorkoutCard` over `ItemWidget`, `isSessionExpired` over `flag`.

```dart
// ❌ BAD
final d = w.t;
void doIt(List x) {}

// ✅ GOOD
final durationMinutes = workout.durationMinutes;
void completeWorkout(List<SetLog> setLogs) {}
```
