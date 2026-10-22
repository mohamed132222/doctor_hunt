import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/di/injection.dart';
import '../../../../../core/extensions/media_query_extension.dart';
import '../../../../../core/router/app_router.dart';
import '../../../../../core/widgets/app_background.dart';
import '../../data/catalog/patient_catalog.dart';
import 'package:doctor_hunt/apps/features/common/profile/data/models/user_profile_model.dart';
import 'package:doctor_hunt/apps/features/common/profile/presentation/controllers/current_profile/current_profile_cubit.dart';

import '../../data/models/doctor_model.dart';
import '../widgets/category_row.dart';
import '../widgets/feature_doctor_card.dart';
import '../widgets/home_header.dart';
import '../widgets/popular_doctor_card.dart';
import '../widgets/section_header.dart';
import 'package:doctor_hunt/apps/core/widgets/skeleton.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final Future<void> _load = getIt<PatientCatalog>().ensureLoaded();

  @override
  void initState() {
    super.initState();
    getIt<CurrentProfileCubit>().load();
  }

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: FutureBuilder<void>(
        future: _load,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const AppSkeletonList();
          }
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: BlocProvider<CurrentProfileCubit>.value(
                  value: getIt<CurrentProfileCubit>(),
                  child:
                      BlocSelector<CurrentProfileCubit, UserProfile?, String?>(
                        selector: (profile) => profile?.photo,
                        builder: (context, photo) => HomeHeader(
                          photo: photo,
                          onSearchSubmitted: (query) =>
                              SearchRoute(q: query).push(context),
                        ),
                      ),
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: context.s24)),
              SliverToBoxAdapter(
                child: CategoryRow(
                  onSelect: (category) => SpecialtyDoctorsRoute(
                    specialty: category.specialty.wireValue,
                  ).push(context),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(height: context.homeSectionGap),
              ),
              SliverToBoxAdapter(
                child: SectionHeader(title: t.popularDoctorsTitle),
              ),
              SliverToBoxAdapter(
                child: SizedBox(height: context.homeHeaderCardGap),
              ),
              SliverToBoxAdapter(child: _PopularDoctorsRow()),
              SliverToBoxAdapter(
                child: SizedBox(height: context.homeSectionGap),
              ),
              SliverToBoxAdapter(
                child: SectionHeader(title: t.featureDoctorsTitle),
              ),
              SliverToBoxAdapter(
                child: SizedBox(height: context.homeHeaderCardGap),
              ),
              SliverToBoxAdapter(child: _FeatureDoctorsRow()),
              SliverToBoxAdapter(child: SizedBox(height: context.s24)),
            ],
          );
        },
      ),
    );
  }
}

class _PopularDoctorsRow extends StatelessWidget {
  const _PopularDoctorsRow();

  @override
  Widget build(BuildContext context) {
    final doctors = kPopularDoctors;
    return SizedBox(
      height: context.popularRowHeight,
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(
          horizontal: context.homeRowPaddingH,
          vertical: context.homeCardRowPaddingV,
        ),
        itemCount: doctors.length,
        separatorBuilder: (context, index) =>
            SizedBox(width: context.homeCardGap),
        itemBuilder: (context, index) {
          final doctor = doctors[index];
          return PopularDoctorCard(
            doctor: doctor,
            onTap: () => DoctorDetailsRoute(doctorId: doctor.id).push(context),
          );
        },
      ),
    );
  }
}

class _FeatureDoctorsRow extends StatelessWidget {
  const _FeatureDoctorsRow();

  @override
  Widget build(BuildContext context) {
    final textScale = MediaQuery.textScalerOf(context).scale(1);
    final textExtra =
        (textScale - 1).clamp(0.0, 1.0) * context.featureTextBlockHeight;
    final doctors = kFeatureDoctors;

    return SizedBox(
      height: context.featureRowHeight + textExtra,
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(
          horizontal: context.homeRowPaddingH,
          vertical: context.homeCardRowPaddingV,
        ),
        itemCount: doctors.length,
        separatorBuilder: (context, index) =>
            SizedBox(width: context.homeCardGap),
        itemBuilder: (context, index) {
          final doctor = doctors[index];
          return FeatureDoctorCard(
            doctor: doctor,
            onTap: () => DoctorDetailsRoute(doctorId: doctor.id).push(context),
          );
        },
      ),
    );
  }
}
