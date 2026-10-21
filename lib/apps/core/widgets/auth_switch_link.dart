import 'package:flutter/material.dart';

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
