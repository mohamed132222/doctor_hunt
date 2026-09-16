import 'package:flutter/material.dart';

import '../../../../core/appsize/app_size.dart';
import '../../../../core/appsize/screen_utils.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/themes/app_theme.dart';
import 'home_search_bar.dart';

/// Teal→green gradient header: greeting, title, avatar and the search bar.
///
/// The gradient ends at the search bar's vertical centre, so the bar straddles
/// the header's bottom edge, exactly as in the design.
class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key, this.onSearchChanged, this.onSearchSubmitted});

  final ValueChanged<String>? onSearchChanged;
  final ValueChanged<String>? onSearchSubmitted;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.themeColors;
    final safeTop = MediaQuery.paddingOf(context).top;
    final searchHeight = context.w(AppSize.homeSearchHeight);

    // Fixed-aspect geometry — use the width scale throughout so the header's
    // parts stay proportional (and in step with the card rows).
    final gradientHeight =
        safeTop +
        context.w(AppSize.homeHeaderTopGap) +
        context.w(AppSize.homeAvatarSize) +
        context.w(AppSize.homeHeaderTitleGap) +
        searchHeight / 2;

    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: gradientHeight,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [colors.headerGradientStart, colors.headerGradientEnd],
              ),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(context.r(AppSize.homeHeaderRadius)),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(
            context.w(AppSize.homeHeaderPaddingH),
            safeTop + context.w(AppSize.homeHeaderTopGap),
            context.w(AppSize.homeHeaderPaddingH),
            0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.homeGreeting,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onPrimary,
                          ),
                        ),
                        SizedBox(height: context.w(AppSize.s4)),
                        Text(
                          AppStrings.homeTitle,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            color: theme.colorScheme.onPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: context.w(AppSize.s16)),
                  _Avatar(size: context.w(AppSize.homeAvatarSize)),
                ],
              ),
              SizedBox(height: context.w(AppSize.homeHeaderTitleGap)),
              HomeSearchBar(
                onChanged: onSearchChanged,
                onSubmitted: onSearchSubmitted,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: scheme.onPrimary.withValues(alpha: 0.22),
      ),
      child: Icon(Icons.person, color: scheme.onPrimary, size: size * 0.55),
    );
  }
}
