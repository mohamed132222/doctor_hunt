import 'home_search_bar.dart';
import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import '../../../../../core/extensions/media_query_extension.dart';
import '../../../../../core/themes/app_theme.dart';
import 'home_header_avatar.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
    this.photo,
    this.onSearchChanged,
    this.onSearchSubmitted,
  });

  final String? photo;
  final ValueChanged<String>? onSearchChanged;
  final ValueChanged<String>? onSearchSubmitted;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.themeColors;
    final safeTop = MediaQuery.paddingOf(context).top;
    final searchHeight = context.homeSearchHeight;

    final gradientHeight =
        safeTop +
        context.homeHeaderTopGap +
        context.homeAvatarSize +
        context.homeHeaderTitleGap +
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
                bottom: Radius.circular(context.homeHeaderRadius),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(
            context.homeHeaderPaddingH,
            safeTop + context.homeHeaderTopGap,
            context.homeHeaderPaddingH,
            0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  _MenuButton(size: context.homeMenuIcon),
                  SizedBox(width: context.s12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          t.homeGreeting,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onPrimary,
                          ),
                        ),
                        SizedBox(height: context.s4),
                        Text(
                          t.homeTitle,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            color: theme.colorScheme.onPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: context.s16),
                  HomeHeaderAvatar(size: context.homeAvatarSize, photo: photo),
                ],
              ),
              SizedBox(height: context.homeHeaderTitleGap),
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

class _MenuButton extends StatelessWidget {
  const _MenuButton({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Semantics(
      button: true,
      label: t.drawerOpenMenu,
      child: InkResponse(
        onTap: () => ZoomDrawer.of(context)?.toggle(),
        radius: size,
        child: Icon(Icons.menu, color: scheme.onPrimary, size: size),
      ),
    );
  }
}
