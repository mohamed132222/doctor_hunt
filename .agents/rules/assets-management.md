---
description: Type-safe Flutter assets via code generation; never use raw asset path strings
alwaysApply: true
---

# Assets management

## Type-safe assets

This project uses **code generation** for assets. Before adding or referencing an asset, inspect the project (`pubspec.yaml`, `dev_dependencies`, generated output such as `lib/gen/`) to identify the existing generator (e.g. `flutter_gen`).

Do not assume a package. Use whatever generator is already configured.

## Follow the generated API

Always use generated classes. Never hardcode asset path strings.

```dart
// ❌ BAD
Image.asset('assets/images/logo.png');
SvgPicture.asset('assets/images/fitflow_logo.svg');

// ✅ GOOD — flutter_gen-style (adjust to the project's generated API)
Image.asset(Assets.images.logo.path);
SvgPicture.asset(Assets.images.fitflowLogo.path);
```

After adding files under `assets/`, register them in `pubspec.yaml` if needed, then run the project's asset generator so new members exist before you reference them.

## Chosen generator

`flutter_gen_runner ^5.15.0` with `build_runner ^2.15.1` (build_runner 2.17.x is incompatible with flutter_gen_runner 5.15.0).

Config in `pubspec.yaml`:

```yaml
flutter_gen:
  output: lib/gen/
  line_length: 80
  integrations:
    image: true
    flutter_svg: true
```

Generate with:

```bash
dart run build_runner build
```

## Missing generator protocol

If no asset generator is found in the project:

1. **Stop.** Do not add assets with raw strings and do not pick a generator on your own.
2. **Ask the user** which generator they prefer (e.g. `flutter_gen` / `flutter_gen_runner`).
3. After they answer, **append** the chosen package name and how to run it under **Chosen generator** in this file, then use that package going forward.
