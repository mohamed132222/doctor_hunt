---
description: Prefer onChanged/onSubmitted state over TextEditingController; dispose controllers when required
alwaysApply: true
---

# Forms & input handling

## State over controllers

Manage text with a simple field updated in `onChanged` or `onSubmitted`. Do not add a `TextEditingController` for ordinary typing.

```dart
// ❌ BAD — controller with no programmatic text control
final emailController = TextEditingController();
TextField(controller: emailController)

// ✅ GOOD — field state
String email = '';
TextField(
  onChanged: (value) => setState(() => email = value),
)
```

## Strict controller limitation

Do not generate a `TextEditingController` unless the field must be changed programmatically (set, clear, select, or listen from code). If a controller is required, create it in `initState` (or as a late field) and dispose it in `dispose()`.

```dart
// ❌ BAD — controller never disposed
class SearchBox extends StatefulWidget { /* ... */ }
class _SearchBoxState extends State<SearchBox> {
  final controller = TextEditingController();
  // missing dispose()
}

// ✅ GOOD — only when you set/clear/select text from code
class SearchBox extends StatefulWidget { /* ... */ }
class _SearchBoxState extends State<SearchBox> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
```
