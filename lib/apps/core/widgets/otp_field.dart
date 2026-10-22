import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../extensions/media_query_extension.dart';

class OtpField extends StatelessWidget {
  const OtpField({super.key, this.length = 6, required this.onCompleted});

  final int length;
  final ValueChanged<String> onCompleted;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final radius = BorderRadius.circular(context.otpRadius);

    final available = MediaQuery.sizeOf(context).width - 48;
    final pinSize = (available / length - context.otpGap).clamp(40.0, 56.0);

    final defaultPinTheme = PinTheme(
      width: pinSize,
      height: pinSize,
      textStyle: theme.textTheme.headlineSmall?.copyWith(
        color: theme.colorScheme.primary,
      ),
      decoration: BoxDecoration(
        borderRadius: radius,
        border: Border.all(color: theme.colorScheme.outline),
      ),
    );

    return Pinput(
      length: length,
      defaultPinTheme: defaultPinTheme,
      separatorBuilder: (index) => SizedBox(width: context.otpGap),
      focusedPinTheme: defaultPinTheme.copyWith(
        decoration: defaultPinTheme.decoration!.copyWith(
          border: Border.all(color: theme.colorScheme.primary, width: 2),
        ),
      ),
      mainAxisAlignment: MainAxisAlignment.center,
      onCompleted: onCompleted,
    );
  }
}
