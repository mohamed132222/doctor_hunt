import 'package:doctor_hunt/apps/core/extensions/media_query_extension.dart';
import 'package:doctor_hunt/apps/core/themes/app_colors.dart';
import 'package:doctor_hunt/apps/core/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';

Future<({double rating, String? comment})?> showRateDoctorDialog(
  BuildContext context,
) {
  return showDialog<({double rating, String? comment})>(
    context: context,
    builder: (_) => const _RateDoctorDialog(),
  );
}

class _RateDoctorDialog extends StatefulWidget {
  const _RateDoctorDialog();

  @override
  State<_RateDoctorDialog> createState() => _RateDoctorDialogState();
}

class _RateDoctorDialogState extends State<_RateDoctorDialog> {
  final TextEditingController _comment = TextEditingController();
  int _rating = 0;

  @override
  void dispose() {
    _comment.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return AlertDialog(
      backgroundColor: scheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(context.r16),
      ),
      title: Text(t.apptRateTitle, style: context.bold18Black),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var i = 1; i <= 5; i++)
                GestureDetector(
                  onTap: () => setState(() => _rating = i),
                  behavior: HitTestBehavior.opaque,
                  child: Padding(
                    padding: EdgeInsets.all(context.s4),
                    child: Icon(
                      i <= _rating
                          ? Icons.star_rounded
                          : Icons.star_border_rounded,
                      size: context.iconLarge / 3,
                      color: AppColors.warning,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: context.s16),
          TextField(
            controller: _comment,
            maxLines: 3,
            decoration: InputDecoration(hintText: t.apptReviewHint),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(t.commonCancel),
        ),
        SizedBox(
          width: context.detailsBookButtonWidth,
          child: PrimaryButton(
            label: t.apptSubmit,
            width: double.infinity,
            height: context.confirmHeight,
            radius: context.r12,
            enabled: _rating > 0,
            onPressed: () => Navigator.of(context).pop((
              rating: _rating.toDouble(),
              comment: _comment.text.trim().isEmpty
                  ? null
                  : _comment.text.trim(),
            )),
          ),
        ),
      ],
    );
  }
}
