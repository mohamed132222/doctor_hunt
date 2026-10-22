---
description: Pass whole models into widgets, prefer const, extract named widgets into their own files
alwaysApply: true
---

# Widget structure & data passing

## Object-level data passing

When a widget needs multiple fields from one model, pass the model — not unpacked primitives.

```dart
// ❌ BAD
class UserCard extends StatelessWidget {
  const UserCard({super.key, required this.name, required this.age});
  final String name;
  final int age;
}

// ✅ GOOD
class UserCard extends StatelessWidget {
  const UserCard({super.key, required this.user});
  final User user;
}
```

## Strict `const` usage

Use `const` constructors whenever the widget can be const (constructor, children, and arguments).

```dart
// ❌ BAD
padding: EdgeInsets.all(16),
child: Text('Ready'),

// ✅ GOOD
padding: const EdgeInsets.all(16),
child: const Text('Ready'),
```

## Semantic extraction

If a tree is large, has many declarations, or represents a distinct UI idea, extract a named `StatelessWidget`. Keep files small and reusable.

```dart
// ❌ BAD — anonymous blob in the parent build
Column(children: [avatar, name, stats, actions])

// ✅ GOOD
const ProfileHeader(user: user)
```

## No cluttered private widgets

Do not keep `_MyHelperWidget` (or other private widgets) at the bottom of the same file as the main UI. Put each extracted widget in its own file (`lib/feature/<feature>/ui/widgets/` or `lib/core/common/widgets/`).
