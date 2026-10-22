import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:doctor_hunt/generated/image_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/extensions/media_query_extension.dart';
import '../../../../../core/themes/app_theme.dart';

class NavEntry {
  NavEntry({required this.label, this.svg, this.icon})
    : assert(svg != null || icon != null, 'provide an svg or an icon');

  final String label;
  final String? svg;
  final IconData? icon;
}

List<NavEntry> kNavEntries = [
  NavEntry(label: t.tabHome, svg: AppAssets.homeIcon),
  NavEntry(label: t.tabFavorites, svg: AppAssets.heartIcon),
  NavEntry(label: t.tabBook, svg: AppAssets.bookIcon),
  NavEntry(label: t.drawerSettings, icon: Icons.settings_outlined),
];

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
          top: Radius.circular(context.navTopRadius),
        ),
      ),
      child: SizedBox(
        height: context.bottomNavHeight,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.navPaddingH),
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
    final size = context.navActiveCircle;
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
            child: Center(
              child: entry.icon != null
                  ? Icon(
                      entry.icon,
                      size: context.navSvgHeight,
                      color: iconColor,
                    )
                  : SvgPicture.asset(
                      entry.svg!,
                      height: context.navSvgHeight,
                      colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
