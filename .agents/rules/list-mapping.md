---
description: Render or transform model lists with .map instead of for collection elements
alwaysApply: true
---

# List mapping

When building widgets or transforming data from a list of models, use `.map(...).toList()` instead of a `for` collection element.

```dart
// ❌ BAD
Column(
  children: [
    for (final workout in workouts) WorkoutCard(workout: workout),
  ],
)

// ✅ GOOD
Column(
  children: workouts.map((workout) => WorkoutCard(workout: workout)).toList(),
)
```

- Use `.asMap().entries.map(...)` only when spacing or dividers depend on the item index.
- Map to named widgets, passing the whole model and callbacks down.
- Prefer `Column(spacing: n)` over inserting separator widgets manually.
