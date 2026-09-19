import 'package:doctor_hunt/apps/core/i18n/strings.g.dart';
import 'package:flutter/material.dart';

import '../../../../../core/appsize/media_query_extension.dart';
import '../../../../../core/themes/app_theme.dart';

/// White search field: the magnifier is the [InputDecoration.prefixIcon] and
/// the clear action is the [InputDecoration.suffixIcon].
///
/// The field has no height of its own — the symmetric vertical padding around
/// those icons gives the design's 54px pill and keeps the content centred.
class HomeSearchBar extends StatefulWidget {
  const HomeSearchBar({
    super.key,
    this.onChanged,
    this.initialQuery = '',
    this.autofocus = false,
    this.onSubmitted,
  });

  final ValueChanged<String>? onChanged;
  final String initialQuery;
  final bool autofocus;
  final ValueChanged<String>? onSubmitted;

  @override
  State<HomeSearchBar> createState() => _HomeSearchBarState();
}

class _HomeSearchBarState extends State<HomeSearchBar> {
  late final TextEditingController _controller = TextEditingController(
    text: widget.initialQuery,
  );
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _clear() {
    _controller.clear();
    widget.onChanged?.call('');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconColor = theme.colorScheme.onSurfaceVariant;
    final iconSize = context.iconSmall;
    final padH = context.homeSearchPaddingH;
    final gap = context.homeSearchIconGap;
    final padV = (context.homeSearchHeight - iconSize) / 2;
    const noConstraints = BoxConstraints(minWidth: 0, minHeight: 0);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _focusNode.requestFocus(),
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(context.homeSearchRadius),
          boxShadow: [context.themeColors.softShadow],
        ),
        child: TextField(
          controller: _controller,
          focusNode: _focusNode,
          onChanged: widget.onChanged,
          onSubmitted: widget.onSubmitted,
          autofocus: widget.autofocus,
          textInputAction: TextInputAction.search,
          textAlignVertical: TextAlignVertical.center,
          style: theme.textTheme.bodyMedium,
          decoration: InputDecoration(
            hintText: t.searchHint,
            isDense: true,
            isCollapsed: true,
            contentPadding: EdgeInsets.zero,
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            filled: false,
            prefixIconConstraints: noConstraints,
            prefixIcon: Padding(
              padding: EdgeInsets.only(
                left: padH,
                right: gap,
                top: padV,
                bottom: padV,
              ),
              child: Icon(Icons.search, size: iconSize, color: iconColor),
            ),
            suffixIconConstraints: noConstraints,
            suffixIcon: GestureDetector(
              onTap: _clear,
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: EdgeInsets.only(
                  left: gap,
                  right: padH,
                  top: padV,
                  bottom: padV,
                ),
                child: Icon(Icons.close, size: iconSize, color: iconColor),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
