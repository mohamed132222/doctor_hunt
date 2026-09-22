import 'package:doctor_hunt/apps/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

/// Reusable bottom-sheet container.
///
/// Responsibilities:
/// - Sheet shape
/// - Drag handle
/// - Safe area
/// - Keyboard handling
/// - Scrolling
///
/// This widget contains no feature-specific logic.
class AppSheet extends StatelessWidget {
  const AppSheet({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return AnimatedPadding(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      padding: EdgeInsets.only(bottom: bottomInset),
      child: SafeArea(
        top: false,
        minimum: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 10,
          bottom: 60,
        ),
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [_SheetHandle(), const SizedBox(height: 60), child],
          ),
        ),
      ),
    );
  }
}

class _SheetHandle extends StatelessWidget {
  const _SheetHandle();

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: 5,
      color: AppColors.geryLight,
      indent: 120,
      endIndent: 120,
      radius: BorderRadius.circular(6),
    );
  }
}

/// Opens a reusable application bottom sheet.
///
/// Feature-specific navigation and state should live outside
/// this widget.
Future<T?> showAppSheet<T>(BuildContext context, WidgetBuilder builder) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    isDismissible: false,
    enableDrag: true,
    backgroundColor: AppColors.white,
    shape: RoundedRectangleBorder(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: builder,
  );
}
