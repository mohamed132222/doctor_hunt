import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:flutter/material.dart';

import '../../../../../core/extensions/media_query_extension.dart';
import '../../../../../core/themes/app_theme.dart';

class PlaceholderTab extends StatelessWidget {
  const PlaceholderTab({super.key, required this.title, required this.icon});

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: context.placeholderIcon,
              color: context.colorScheme.outlineVariant,
            ),
            SizedBox(height: context.s16),
            Text(
              t.tabPlaceholder(title: title),
              style: theme.textTheme.bodyLarge?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
