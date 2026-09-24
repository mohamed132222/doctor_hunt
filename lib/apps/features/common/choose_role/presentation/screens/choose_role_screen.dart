import 'package:doctor_hunt/apps/core/extensions/media_query_extension.dart';
import 'package:doctor_hunt/apps/core/i18n/strings.g.dart';
import 'package:doctor_hunt/apps/core/router/app_router.dart';
import 'package:doctor_hunt/apps/core/widgets/app_background.dart';
import 'package:doctor_hunt/apps/core/widgets/primary_button.dart';
import 'package:doctor_hunt/apps/features/common/choose_role/data/models/role.dart';
import 'package:doctor_hunt/apps/features/common/choose_role/presentation/widgets/role_card.dart';
import 'package:doctor_hunt/generated/image_assets.dart';
import 'package:flutter/material.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';

class ChooseRoleScreen extends StatefulWidget {
  const ChooseRoleScreen({super.key});

  @override
  State<ChooseRoleScreen> createState() => _ChooseRoleScreenState();
}

class _ChooseRoleScreenState extends State<ChooseRoleScreen> {
  UserRole _selected = UserRole.patient;

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Image.asset(AppAssets.splashLogo, width: 70),
              const SizedBox(height: 14),
              Text(t.appName, style: context.bold24Black),
              const SizedBox(height: 60),
              Text(
                t.chooseRoleTitle,
                textAlign: TextAlign.center,
                style: context.regular28Black,
              ),
              const SizedBox(height: 10),
              Text(
                t.chooseRoleSubtitle,
                textAlign: TextAlign.center,
                style: context.regular14TextPlaceholder,
              ),
              const SizedBox(height: 32),
              ...kRoleOptions.map(
                (option) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: RoleCard(
                    option: option,
                    selected: _selected == option.role,
                    onTap: () => setState(() => _selected = option.role),
                  ),
                ),
              ),
              SizedBox(height: context.heightOf(122)),
              PrimaryButton(
                label: t.continueLabel,

                onPressed: () => LoginRoute(role: _selected).go(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
