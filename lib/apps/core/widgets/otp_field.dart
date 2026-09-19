import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../appsize/media_query_extension.dart';

/// A row of digit boxes for OTP / verification codes.
///
/// Auto-advances focus to the next box on input and back on delete.
/// Reports the full code via [onCompleted].
class OtpField extends StatefulWidget {
  const OtpField({super.key, this.length = 4, required this.onCompleted});

  final int length;
  final ValueChanged<String> onCompleted;

  @override
  State<OtpField> createState() => _OtpFieldState();
}

class _OtpFieldState extends State<OtpField> {
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(widget.length, (_) => TextEditingController());
    _focusNodes = List.generate(widget.length, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _onChanged(int index, String value) {
    if (value.isNotEmpty && index < widget.length - 1) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
    final code = _controllers.map((c) => c.text).join();
    if (code.length == widget.length) {
      widget.onCompleted(code);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final boxSize = context.otpBoxSize;
    final gap = context.otpGap;
    final radius = BorderRadius.circular(context.otpRadius);

    InputBorder border(Color color, double width) => OutlineInputBorder(
      borderRadius: radius,
      borderSide: BorderSide(color: color, width: width),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var index = 0; index < widget.length; index++) ...[
          if (index > 0) SizedBox(width: gap),
          SizedBox(
            width: boxSize,
            height: boxSize,
            child: TextField(
              controller: _controllers[index],
              focusNode: _focusNodes[index],
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              maxLength: 1,
              style: theme.textTheme.headlineSmall?.copyWith(
                color: theme.colorScheme.primary,
              ),
              decoration: InputDecoration(
                counterText: '',
                contentPadding: EdgeInsets.zero,
                enabledBorder: border(theme.colorScheme.outline, 1),
                focusedBorder: border(theme.colorScheme.primary, 2),
              ),
              onChanged: (v) => _onChanged(index, v),
            ),
          ),
        ],
      ],
    );
  }
}
