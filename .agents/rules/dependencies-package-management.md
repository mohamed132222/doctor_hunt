---
description: Look up latest stable pub.dev versions; use modern Flutter/Dart APIs
alwaysApply: true
---

# Dependencies & package management

## Dynamic version retrieval (no hallucinations)

Never assume or guess a package version. Before telling the user to add a package to `pubspec.yaml`, look up the **latest stable** version (pub.dev or equivalent live search) and use that number.

```yaml
# ❌ BAD — guessed / remembered version
dependencies:
  riverpod: ^2.4.0

# ✅ GOOD — version confirmed from pub.dev in this session
dependencies:
  riverpod: ^3.0.3
```

- Do not copy versions from memory, old snippets, or other projects.
- Prefer the latest **stable** release (not pre-release) unless the user asks otherwise.
- After lookup, cite the version you found when adding or updating the dependency.

## Modern Flutter / Dart syntax

Assume a current Flutter/Dart SDK. Use current APIs and avoid deprecated methods from older package or SDK versions.

```dart
# ❌ BAD — outdated / deprecated
withOpacity(0.5)
RaisedButton(onPressed: onTap, child: child)

# ✅ GOOD — current APIs
withValues(alpha: 0.5)
FilledButton(onPressed: onTap, child: child)
```

When a package is added, match examples and constructors to **that** latest major — not APIs from a previous major.
