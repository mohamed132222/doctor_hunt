import 'package:flutter/material.dart';
import '../../../../../core/appsize/app_size.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/appsize/media_query_extension.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/router/app_router.dart';
import '../../../../../core/widgets/app_background.dart';
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
    return AppBackground(
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
          SliverToBoxAdapter(
            child: SizedBox(height: context.paddingOf(AppSize.s24)),
          ),
          const SliverToBoxAdapter(child: CategoryRow()),
          SliverToBoxAdapter(
            child: SizedBox(height: context.paddingOf(AppSize.homeSectionGap)),
          ),
          SliverToBoxAdapter(
            child: SectionHeader(title: AppStrings.popularDoctorsTitle),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: context.paddingOf(AppSize.homeHeaderCardGap),
            ),
          ),
          const SliverToBoxAdapter(child: _PopularDoctorsRow()),
          SliverToBoxAdapter(
            child: SizedBox(height: context.paddingOf(AppSize.homeSectionGap)),
          ),
          SliverToBoxAdapter(
            child: SectionHeader(title: AppStrings.featureDoctorsTitle),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: context.paddingOf(AppSize.homeHeaderCardGap),
            ),
          ),
          const SliverToBoxAdapter(child: _FeatureDoctorsRow()),
          SliverToBoxAdapter(
            child: SizedBox(height: context.paddingOf(AppSize.s24)),
          ),
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
      height: context.sizeOf(AppSize.popularRowHeight),
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(
          horizontal: context.paddingOf(AppSize.homeRowPaddingH),
          vertical: context.paddingOf(AppSize.homeCardRowPaddingV),
        ),
        itemCount: kPopularDoctors.length,
        separatorBuilder: (context, index) =>
            SizedBox(width: context.paddingOf(AppSize.homeCardGap)),
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
        context.sizeOf(AppSize.featureTextBlockHeight);

    return SizedBox(
      height: context.sizeOf(AppSize.featureRowHeight) + textExtra,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(
          horizontal: context.paddingOf(AppSize.homeRowPaddingH),
          vertical: context.paddingOf(AppSize.homeCardRowPaddingV),
        ),
        itemCount: kFeatureDoctors.length,
        separatorBuilder: (context, index) =>
            SizedBox(width: context.paddingOf(AppSize.homeCardGap)),
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
