import 'package:doctor_hunt/apps/core/i18n/strings.g.dart';
import 'package:flutter/material.dart';

import '../../../../../core/extensions/media_query_extension.dart';
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
              onSearchSubmitted: (query) => SearchRoute(q: query).push(context),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: context.s24)),
          SliverToBoxAdapter(child: CategoryRow()),
          SliverToBoxAdapter(child: SizedBox(height: context.homeSectionGap)),
          SliverToBoxAdapter(
            child: SectionHeader(title: t.popularDoctorsTitle),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: context.homeHeaderCardGap),
          ),
          SliverToBoxAdapter(child: _PopularDoctorsRow()),
          SliverToBoxAdapter(child: SizedBox(height: context.homeSectionGap)),
          SliverToBoxAdapter(
            child: SectionHeader(title: t.featureDoctorsTitle),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: context.homeHeaderCardGap),
          ),
          SliverToBoxAdapter(child: _FeatureDoctorsRow()),
          SliverToBoxAdapter(child: SizedBox(height: context.s24)),
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
      height: context.popularRowHeight,
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(
          horizontal: context.homeRowPaddingH,
          vertical: context.homeCardRowPaddingV,
        ),
        itemCount: kPopularDoctors.length,
        separatorBuilder: (context, index) =>
            SizedBox(width: context.homeCardGap),
        itemBuilder: (context, index) {
          final doctor = kPopularDoctors[index];
          return PopularDoctorCard(
            doctor: doctor,
            onTap: () => DoctorDetailsRoute(doctorId: doctor.id).push(context),
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
        (textScale - 1).clamp(0.0, 1.0) * context.featureTextBlockHeight;

    return SizedBox(
      height: context.featureRowHeight + textExtra,
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(
          horizontal: context.homeRowPaddingH,
          vertical: context.homeCardRowPaddingV,
        ),
        itemCount: kFeatureDoctors.length,
        separatorBuilder: (context, index) =>
            SizedBox(width: context.homeCardGap),
        itemBuilder: (context, index) {
          final doctor = kFeatureDoctors[index];
          return FeatureDoctorCard(
            doctor: doctor,
            onTap: () => DoctorDetailsRoute(doctorId: doctor.id).push(context),
          );
        },
      ),
    );
  }
}
