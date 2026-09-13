import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../appsize/app_size.dart';
import '../appsize/screen_utils.dart';
import '../themes/app_theme.dart';

/// Rounded modal sheet with the grey drag handle, a left-aligned title /
/// subtitle and keyboard-safe padding. All colors & typography come from the
/// theme.
class AppSheet extends StatelessWidget {
  const AppSheet({
    super.key,
    required this.title,
    this.subtitle,
    required this.child,
  });

  final String title;
  final String? subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Push the content above the keyboard, and always clear the bottom inset.
    final bottomInset = math.max(
      MediaQuery.viewInsetsOf(context).bottom,
      MediaQuery.paddingOf(context).bottom +
          context.h(AppSize.sheetBottomPadding),
    );

    return Padding(
      padding: EdgeInsets.only(
        left: context.w(AppSize.sheetPaddingH),
        right: context.w(AppSize.sheetPaddingH),
        top: context.h(AppSize.sheetTopPadding),
        bottom: bottomInset,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: context.w(AppSize.sheetHandleWidth),
                height: context.h(AppSize.sheetHandleHeight),
                decoration: BoxDecoration(
                  color: context.themeColors.sheetHandle,
                  borderRadius: BorderRadius.circular(AppSize.r4),
                ),
              ),
            ),
            SizedBox(height: context.h(AppSize.sheetHandleTitleGap)),
            Text(title, style: theme.textTheme.headlineMedium),
            if (subtitle != null) ...[
              SizedBox(height: context.h(AppSize.sheetTitleSubtitleGap)),
              Text(subtitle!, style: context.textStyles.authSubtitle),
            ],
            SizedBox(height: context.h(AppSize.sheetSubtitleContentGap)),
            child,
          ],
        ),
      ),
    );
  }
}

/// Opens [builder] as a modal sheet that only dismisses on a swipe-down —
/// tapping the scrim does nothing. Used by every auth popup for consistency.
Future<T?> showAppSheet<T>(BuildContext context, WidgetBuilder builder) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    isDismissible: false,
    enableDrag: true,
    useSafeArea: true,
    backgroundColor: context.colorScheme.surface,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(context.r(AppSize.r24)),
      ),
    ),
    builder: builder,
  );
}
