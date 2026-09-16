import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../generated/image_assets.dart';
import '../../../../core/appsize/app_size.dart';
import '../../../../core/appsize/screen_utils.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/themes/app_theme.dart';

/// A bottom-navigation destination: label + its SVG glyph.
class NavEntry {
  const NavEntry({required this.label, required this.svg});

  final String label;
  final String svg;
}

const List<NavEntry> kNavEntries = [
  NavEntry(label: AppStrings.tabHome, svg: AppAssets.homeIcon),
  NavEntry(label: AppStrings.tabFavorites, svg: AppAssets.heartIcon),
  NavEntry(label: AppStrings.tabBook, svg: AppAssets.bookIcon),
  NavEntry(label: AppStrings.tabChat, svg: AppAssets.messageIcon),
];

/// Custom bottom navigation: white bar with rounded top corners, icon-only
/// items, the active item in a filled primary circle.
///
/// All four glyphs are SVG art kept at their own aspect ratio (20px tall), so
/// the book reads wider than the chat exactly as in the design.
class HomeBottomNav extends StatelessWidget {
  const HomeBottomNav({
    super.key,
    required this.currentIndex,
    required this.onSelect,
  });

  final int currentIndex;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.only(bottom: MediaQuery.paddingOf(context).bottom),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(context.r(AppSize.navTopRadius)),
        ),
      ),
      child: SizedBox(
        height: context.w(AppSize.bottomNavHeight),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.w(AppSize.navPaddingH),
          ),
          child: Row(
            children: [
              for (var i = 0; i < kNavEntries.length; i++)
                Expanded(
                  child: _NavItem(
                    entry: kNavEntries[i],
                    active: i == currentIndex,
                    onTap: () => onSelect(i),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.entry,
    required this.active,
    required this.onTap,
  });

  final NavEntry entry;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final colors = context.themeColors;
    final size = context.w(AppSize.navActiveCircle);
    final iconColor = active ? scheme.onPrimary : colors.navInactive;

    return Semantics(
      label: entry.label,
      selected: active,
      button: true,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(size),
        child: Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: active ? scheme.primary : Colors.transparent,
            ),
            // Center gives the glyph loose constraints: without it the tight
            // 48x48 box would scale the SVG up to fill the circle.
            child: Center(
              child: SvgPicture.asset(
                entry.svg,
                height: context.w(AppSize.navSvgHeight),
                colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
