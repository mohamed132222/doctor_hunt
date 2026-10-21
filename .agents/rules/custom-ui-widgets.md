---
description: Generate UI with custom widgets in separate files; prefer theme over one-off styling
globs: lib/feature/**/*.dart,lib/core/theme/**/*.dart,lib/core/common/**/*.dart
alwaysApply: false
---

# Custom UI widgets

When generating or changing UI, extract customized UI into `StatelessWidget` / `StatefulWidget` classes. Do not use helper methods that return `Widget`.

## Placement

- **This feature only** (one or a few screens in the same feature): `lib/feature/<feature>/ui/widgets/<name>.dart`
- **Shared across screens or features**: `lib/core/common/widgets/<name>.dart`
- Screen files compose widgets; they do not hide large UI trees in private methods

```dart
// ❌ BAD — helper method returning a widget
Widget _buildLogo() => SvgPicture.asset('assets/images/fitflow_logo.svg');

// ✅ GOOD — dedicated widget in its own file
class SplashLogo extends StatelessWidget {
  const SplashLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset('assets/images/fitflow_logo.svg');
  }
}
```

## Prefer theme over widget-local styling

Put reusable look-and-feel in `lib/core/theme/` (`AppTheme`, `AppColors`, `AppStyles`, `ThemeData` component themes) instead of repeating colors, text styles, buttons, and scaffold defaults inside widgets.

```dart
// ❌ BAD — one-off styling that belongs in theme
Text('FitFlow', style: TextStyle(fontSize: 48, fontWeight: FontWeight.w700, color: Colors.white));
Scaffold(backgroundColor: const Color(0xFF2563EB));

// ✅ GOOD — theme / shared styles
Text('FitFlow', style: AppStyles.font48Bold);
Scaffold(); // uses AppTheme.light.scaffoldBackgroundColor
```

Widgets keep layout, assets, and feature-specific composition. Colors, typography, and control themes live in theme files unless they are truly unique to one widget.
