import 'package:doctor_hunt/generated/image_assets.dart';
import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/extensions/media_query_extension.dart';
import '../../../../../core/themes/app_theme.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';

class AdminBottomNav extends StatelessWidget {
  const AdminBottomNav({
    super.key,
    required this.currentIndex,
    required this.onSelect,
  });

  final int currentIndex;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    final entries = <({String svg, String label})>[
      (svg: AppAssets.navDoctorsIcon, label: t.adminDoctorsTitle),
      (svg: AppAssets.navAppointmentsIcon, label: t.adminAppointmentsTitle),
      (svg: AppAssets.navSettingsIcon, label: t.adminSettingsTitle),
    ];

    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(context.navTopRadius),
        ),
        boxShadow: [context.themeColors.softShadow],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: context.bottomNavHeight,
          child: Row(
            children: [
              for (var i = 0; i < entries.length; i++)
                Expanded(
                  child: _NavItem(
                    svg: entries[i].svg,
                    label: entries[i].label,
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
    required this.svg,
    required this.label,
    required this.active,
    required this.onTap,
  });

  final String svg;
  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = active ? scheme.primary : context.themeColors.navInactive;

    return Semantics(
      selected: active,
      button: true,
      label: label,
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              svg,
              width: context.iconSocial,
              height: context.iconSocial,
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
            ),
            SizedBox(height: context.s4),
            Text(
              label,
              style: (active ? context.semiBold12 : context.regular12).copyWith(
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
