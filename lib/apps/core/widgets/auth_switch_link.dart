import 'package:flutter/material.dart';

/// Shared bottom link for the auth screens (login / register).
///
/// Same styling everywhere — only [prefix], [action] and [onTap] differ.
class AuthSwitchLink extends StatelessWidget {
  const AuthSwitchLink({
    super.key,
    required this.prefix,
    required this.action,
    required this.onTap,
  });

  final String prefix;
  final String action;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextButton(
      onPressed: onTap,
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(text: prefix, style: theme.textTheme.bodySmall),
            TextSpan(text: action, style: theme.textTheme.labelMedium),
          ],
        ),
      ),
    );
  }
}
