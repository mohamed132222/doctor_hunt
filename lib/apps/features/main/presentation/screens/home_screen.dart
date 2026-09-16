import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/appsize/app_size.dart';
import '../../../../core/appsize/screen_utils.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/widgets/ellipse_background.dart';
import '../../data/models/doctor.dart';
import '../widgets/category_row.dart';
import '../widgets/feature_doctor_card.dart';
import '../widgets/home_header.dart';
import '../widgets/popular_doctor_card.dart';
import '../widgets/section_header.dart';

/// Home screen â€” a [CustomScrollView] composed of independent sections.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return EllipseBackground(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: HomeHeader(
              onSearchSubmitted: (query) => context.pushNamed(
                RouteName.search,
                queryParameters: {'q': query},
              ),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: context.h(AppSize.s24))),
          const SliverToBoxAdapter(child: CategoryRow()),
          SliverToBoxAdapter(
            child: SizedBox(height: context.h(AppSize.homeSectionGap)),
          ),
          SliverToBoxAdapter(
            child: SectionHeader(title: AppStrings.popularDoctorsTitle),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: context.h(AppSize.homeHeaderCardGap)),
          ),
          const SliverToBoxAdapter(child: _PopularDoctorsRow()),
          SliverToBoxAdapter(
            child: SizedBox(height: context.h(AppSize.homeSectionGap)),
          ),
          SliverToBoxAdapter(
            child: SectionHeader(title: AppStrings.featureDoctorsTitle),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: context.h(AppSize.homeHeaderCardGap)),
          ),
          const SliverToBoxAdapter(child: _FeatureDoctorsRow()),
          SliverToBoxAdapter(child: SizedBox(height: context.h(AppSize.s24))),
        ],
      ),
    );
  }
}

/// Horizontal list of [PopularDoctorCard]s.
class _PopularDoctorsRow extends StatelessWidget {
  const _PopularDoctorsRow();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.w(AppSize.popularRowHeight),
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(
          horizontal: context.w(AppSize.homeRowPaddingH),
          vertical: context.w(AppSize.homeCardRowPaddingV),
        ),
        itemCount: kPopularDoctors.length,
        separatorBuilder: (context, index) =>
            SizedBox(width: context.w(AppSize.homeCardGap)),
        itemBuilder: (context, index) {
          final doctor = kPopularDoctors[index];
          return PopularDoctorCard(
            doctor: doctor,
            onTap: () => context.pushNamed(
              RouteName.doctorDetails,
              pathParameters: {'doctorId': doctor.id},
            ),
          );
        },
      ),
    );
  }
}

/// Horizontal list of [FeatureDoctorCard]s.
class _FeatureDoctorsRow extends StatelessWidget {
  const _FeatureDoctorsRow();

  @override
  Widget build(BuildContext context) {
    // Match the feature cards' text-driven height so nothing is clipped.
    final textScale = MediaQuery.textScalerOf(context).scale(1);
    final textExtra =
        (textScale - 1).clamp(0.0, 1.0) *
        context.w(AppSize.featureTextBlockHeight);

    return SizedBox(
      height: context.w(AppSize.featureRowHeight) + textExtra,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(
          horizontal: context.w(AppSize.homeRowPaddingH),
          vertical: context.w(AppSize.homeCardRowPaddingV),
        ),
        itemCount: kFeatureDoctors.length,
        separatorBuilder: (context, index) =>
            SizedBox(width: context.w(AppSize.homeCardGap)),
        itemBuilder: (context, index) {
          final doctor = kFeatureDoctors[index];
          return FeatureDoctorCard(
            doctor: doctor,
            onTap: () => context.pushNamed(
              RouteName.doctorDetails,
              pathParameters: {'doctorId': doctor.id},
            ),
          );
        },
      ),
    );
  }
}
