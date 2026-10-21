import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:doctor_hunt/apps/core/router/app_router.dart';
import 'package:doctor_hunt/apps/core/widgets/primary_button.dart';
import 'package:doctor_hunt/apps/features/common/onboarding/data/models/onboarding_item_model.dart';
import 'package:doctor_hunt/generated/image_assets.dart';
import 'package:flutter/material.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:doctor_hunt/apps/core/extensions/media_query_extension.dart';

class OnboardingBody extends StatefulWidget {
  const OnboardingBody({super.key, required this.items});

  final List<OnboardingItem> items;

  @override
  State<OnboardingBody> createState() => _OnboardingBodyState();
}

class _OnboardingBodyState extends State<OnboardingBody> {
  final PageController _controller = PageController();

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
                          _OnboardingSlide(item: widget.items[index]),
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

class _OnboardingSlide extends StatelessWidget {
  const _OnboardingSlide({super.key, required this.item});

  final OnboardingItem item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 42),
      child: Column(
        children: [
          Flexible(
            child: AspectRatio(
              aspectRatio: 1,
              child: ClipOval(
                child: Image.asset(item.image, fit: BoxFit.cover),
              ),
            ),
          ),
          SizedBox(height: context.paddingOf(60)),
          Text(
            item.title,
            textAlign: TextAlign.center,
            style: context.medium28.textTitle,
          ),
          const SizedBox(height: 14),
          Text(
            item.subtitle,
            textAlign: TextAlign.center,
            style: context.regular14.textSub,
          ),
        ],
      ),
    );
  }
}
