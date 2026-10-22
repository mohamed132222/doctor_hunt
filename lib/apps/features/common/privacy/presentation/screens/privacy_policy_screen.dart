import 'package:doctor_hunt/apps/core/extensions/media_query_extension.dart';
import 'package:doctor_hunt/apps/core/themes/app_colors.dart';
import 'package:doctor_hunt/apps/core/widgets/app_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bullets = <String>[
      t.privacyPolicyBullet1,
      t.privacyPolicyBullet2,
      t.privacyPolicyBullet3,
      t.privacyPolicyBullet4,
    ];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.gradientIce, AppColors.gradientMint],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.s24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: context.s8),
                AppTopBar(title: t.privacyPolicyTitle),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.only(bottom: context.s32),
                    children: [
                      SizedBox(height: context.s16),
                      Text(
                        t.privacyPolicyHeading,
                        style: context.bold22.copyWith(
                          color: AppColors.textTitle,
                        ),
                      ),
                      SizedBox(height: context.s16),
                      Text(
                        t.privacyPolicyIntro,
                        style: context.regular16TextSub.copyWith(height: 1.6),
                      ),
                      SizedBox(height: context.s20),
                      for (final bullet in bullets) ...[
                        _Bullet(text: bullet),
                        SizedBox(height: context.s16),
                      ],
                      SizedBox(height: context.s4),
                      Text(
                        t.privacyPolicyOutro,
                        style: context.regular16TextSub.copyWith(height: 1.6),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Bullet extends StatelessWidget {
  const _Bullet({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: context.s8),
          width: context.s8,
          height: context.s8,
          decoration: const BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: context.s12),
        Expanded(
          child: Text(
            text,
            style: context.regular16TextSub.copyWith(height: 1.5),
          ),
        ),
      ],
    );
  }
}
