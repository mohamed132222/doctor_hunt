import 'package:doctor_hunt/apps/core/extensions/media_query_extension.dart';
import 'package:doctor_hunt/apps/core/themes/app_colors.dart';
import 'package:doctor_hunt/apps/core/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';

class ProfileFieldCard extends StatefulWidget {
  const ProfileFieldCard({
    super.key,
    required this.label,
    required this.controller,
    this.keyboardType,
    this.inputFormatters,
    this.validator,
    this.textInputAction,
  });

  final String label;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;

  @override
  State<ProfileFieldCard> createState() => _ProfileFieldCardState();
}

class _ProfileFieldCardState extends State<ProfileFieldCard> {
  final FocusNode _focus = FocusNode();

  @override
  void dispose() {
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.s16,
        vertical: context.s12,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(context.profileFieldRadius),
        boxShadow: [context.themeColors.cardShadow],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(widget.label, style: context.semiBold12Primary),
                TextFormField(
                  controller: widget.controller,
                  focusNode: _focus,
                  keyboardType: widget.keyboardType,
                  inputFormatters: widget.inputFormatters,
                  validator: widget.validator,
                  textInputAction: widget.textInputAction,
                  style: context.regular16TextSub,
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    filled: false,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: context.s8),
          GestureDetector(
            onTap: () => _focus.requestFocus(),
            behavior: HitTestBehavior.opaque,
            child: Icon(
              Icons.edit,
              size: context.profileEditIcon,
              color: AppColors.secondaryDark,
            ),
          ),
        ],
      ),
    );
  }
}
