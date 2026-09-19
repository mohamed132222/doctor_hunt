import 'package:flutter/material.dart';
import '../../../../../core/appsize/app_size.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/appsize/media_query_extension.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/router/app_router.dart';
import '../../../../../core/themes/app_theme.dart';
import '../../../../../core/widgets/primary_button.dart';
import 'package:doctor_hunt/generated/image_assets.dart';
import '../../data/models/onboarding_item.dart';
import 'onboarding_slide.dart';

/// Onboarding body: fills the whole screen (background + decorations are
/// full-bleed, the content is `Positioned.fill`), so it never shows as
/// not-fullscreen. Slides differ only by image; the decorative shape flips
/// side on odd/even slides (animated).
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

  bool get _shapeOnRight => _currentIndex.isOdd;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) => setState(() => _currentIndex = index);

  void _next() {
    if (_isLast) {
      context.go(RoutePath.chooseRole);
      return;
    }
    _controller.nextPage(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  void _goNext() => context.go(RoutePath.chooseRole);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Soft green glow — bottom-right (bleeds off the edge).
        Align(
          alignment: Alignment.bottomRight,
          child: Transform.translate(
            offset: Offset(
              context.sizeOf(AppSize.onboardingGlowOffset),
              context.sizeOf(AppSize.onboardingGlowOffset),
            ),
            child: Image.asset(
              AppAssets.onboardingGlow,
              width: context.sizeOf(AppSize.onboardingGlowWidth),
              errorBuilder: (context, error, stackTrace) =>
                  const SizedBox.shrink(),
            ),
          ),
        ),
        // Decorative shape — top-left / top-right, animated between slides.
        AnimatedAlign(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
          alignment: _shapeOnRight ? Alignment.topRight : Alignment.topLeft,
          child: Transform.flip(
            flipX: _shapeOnRight,
            child: Image.asset(
              AppAssets.onboardingShape,
              width: context.sizeOf(AppSize.onboardingShapeWidth),
              errorBuilder: (context, error, stackTrace) =>
                  const SizedBox.shrink(),
            ),
          ),
        ),
        // Content fills the whole screen.
        Positioned.fill(
          child: Column(
            children: [
              SizedBox(height: context.sizeOf(AppSize.onboardingImageTop)),
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: widget.items.length,
                  onPageChanged: _onPageChanged,
                  itemBuilder: (context, index) =>
                      OnboardingSlide(item: widget.items[index]),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.sizeOf(AppSize.onboardingCtaPaddingH),
                ),
                child: PrimaryButton(
                  label: _isLast ? AppStrings.getStarted : AppStrings.next,
                  onPressed: _next,
                  style: context.buttonStyles.onboardingCta,
                ),
              ),
              SizedBox(height: context.sizeOf(AppSize.onboardingButtonSkipGap)),
              TextButton(
                onPressed: _goNext,
                style: TextButton.styleFrom(
                  minimumSize: Size.zero,
                  padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  AppStrings.skip,
                  style: context.textStyles.onboardingSkip,
                ),
              ),
              SizedBox(
                height:
                    MediaQuery.paddingOf(context).bottom +
                    context.sizeOf(AppSize.onboardingBottomPadding),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
