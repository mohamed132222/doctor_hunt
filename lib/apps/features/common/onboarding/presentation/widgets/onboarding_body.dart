import 'package:doctor_hunt/apps/core/i18n/strings.g.dart';
import 'package:doctor_hunt/apps/core/router/app_router.dart';
import 'package:doctor_hunt/apps/core/widgets/primary_button.dart';
import 'package:doctor_hunt/apps/features/common/onboarding/data/models/onboarding_item.dart';
import 'package:doctor_hunt/generated/image_assets.dart';
import 'package:flutter/material.dart';
import 'onboarding_slide.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';

class OnboardingBody extends StatefulWidget {
  const OnboardingBody({super.key, required this.items});

  final List<OnboardingItem> items;

  @override
  State<OnboardingBody> createState() => _OnboardingBodyState();
}

class _OnboardingBodyState extends State<OnboardingBody> {
  final PageController _controller = PageController();

  ///todo used current index from controller
  int _currentIndex = 0;

  bool get _isLast => _currentIndex == widget.items.length - 1;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) => setState(() => _currentIndex = index);

  void _next() {
    if (_isLast) {
      const ChooseRoleRoute().go(context);
      return;
    }
    _controller.nextPage(
      duration: Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Align(
            alignment: Alignment.bottomRight,
            child: Transform.translate(
              offset: const Offset(0, 0),
              child: Image.asset(AppAssets.onboardingGlow),
            ),
          ),

          AnimatedAlign(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            alignment: _currentIndex == 1
                ? Alignment.topRight
                : Alignment.topLeft,
            child: Transform.flip(
              flipX: _currentIndex == 1,
              child: Image.asset(AppAssets.onboardingShape),
            ),
          ),

          Positioned.fill(
            child: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: _controller,
                      itemCount: widget.items.length,
                      onPageChanged: _onPageChanged,
                      itemBuilder: (context, index) =>
                          OnboardingSlide(item: widget.items[index]),
                    ),
                  ),
                  PrimaryButton(
                    label: _isLast ? t.getStarted : t.next,
                    onPressed: _next,
                  ),
                  TextButton(
                    onPressed: () => const ChooseRoleRoute().go(context),
                    child: Text(t.skip, style: context.regular14TextSub),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
