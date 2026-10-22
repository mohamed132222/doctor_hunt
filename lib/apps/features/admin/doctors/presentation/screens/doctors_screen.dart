import 'package:doctor_hunt/apps/core/di/injection.dart';
import 'package:doctor_hunt/apps/core/enums/app_status.dart';
import 'package:doctor_hunt/apps/core/router/app_router.dart';
import 'package:doctor_hunt/apps/core/widgets/empty_state.dart';
import 'package:doctor_hunt/apps/core/widgets/stat_card.dart';
import 'package:doctor_hunt/apps/features/admin/doctors/presentation/controllers/doctors_list/doctors_list_cubit.dart';
import 'package:doctor_hunt/apps/features/admin/doctors/presentation/widgets/admin_doctor_card.dart';
import 'package:doctor_hunt/apps/features/admin/doctors/presentation/widgets/specialty_filter_bar.dart';
import 'package:doctor_hunt/apps/features/admin/main/presentation/widgets/admin_header.dart';
import 'package:doctor_hunt/apps/features/patient/main/presentation/widgets/home_search_bar.dart';
import 'package:doctor_hunt/apps/core/extensions/media_query_extension.dart';
import 'package:doctor_hunt/generated/image_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:doctor_hunt/apps/core/widgets/skeleton.dart';

class DoctorsScreen extends StatelessWidget {
  const DoctorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DoctorsListCubit>(
      create: (_) => getIt<DoctorsListCubit>()..load(),
      child: const _DoctorsView(),
    );
  }
}

class _DoctorsView extends StatelessWidget {
  const _DoctorsView();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DoctorsListCubit>();

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.adminScreenPaddingH),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: context.s8),
                AdminHeader(
                  title: t.adminDoctorsTitle,
                  enableAvatarUpload: true,
                ),
                SizedBox(height: context.s20),
                Expanded(
                  child: BlocBuilder<DoctorsListCubit, DoctorsListState>(
                    buildWhen: (p, c) =>
                        p.status != c.status ||
                        p.doctors != c.doctors ||
                        p.counters != c.counters ||
                        p.query != c.query ||
                        p.specialty != c.specialty,
                    builder: (context, state) => _Body(state: state),
                  ),
                ),
              ],
            ),
            Positioned(
              right: 0,
              bottom: context.s20,
              child: _AddDoctorButton(
                onTap: () async {
                  await const AdminCreateDoctorRoute().push<void>(context);
                  if (context.mounted) cubit.load();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.state});

  final DoctorsListState state;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DoctorsListCubit>();
    final total = state.counters?.total ?? 0;
    final active = state.counters?.active ?? 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: StatCard(label: t.adminActiveDoctors, value: '$active'),
            ),
            SizedBox(width: context.s16),
            Expanded(
              child: StatCard(label: t.adminTotalDoctors, value: '$total'),
            ),
          ],
        ),
        SizedBox(height: context.s16),
        HomeSearchBar(hint: t.adminSearchDoctorsHint, onChanged: cubit.search),
        if (total > 0) ...[
          SizedBox(height: context.s16),
          SpecialtyFilterBar(
            counts: state.specialtyCounts,
            total: total,
            selected: state.specialty,
            onSelect: cubit.selectSpecialty,
          ),
        ],
        SizedBox(height: context.s16),
        Expanded(child: _content(context, total)),
      ],
    );
  }

  Widget _content(BuildContext context, int total) {
    if (state.status == AppStatus.loading && state.doctors.isEmpty) {
      return const AppSkeletonList();
    }
    if (total == 0) {
      return EmptyState(
        svgAsset: AppAssets.emptyDoctorsIcon,
        title: t.adminNoDoctorsTitle,
        message: t.adminNoDoctorsBody,
      );
    }
    if (state.doctors.isEmpty) {
      return EmptyState(
        icon: Icons.search_off_rounded,
        title: t.noSearchResults,
        message: t.noSearchResultsHint,
      );
    }
    return ListView.separated(
      padding: EdgeInsets.only(top: context.s4, bottom: context.s48 * 2),
      itemCount: state.doctors.length,
      separatorBuilder: (_, _) => SizedBox(height: context.s16),
      itemBuilder: (context, index) {
        final doctor = state.doctors[index];
        return AdminDoctorCard(
          doctor: doctor,
          onTap: () async {
            await AdminDoctorDetailsRoute(
              doctorId: doctor.id,
            ).push<void>(context);
            if (context.mounted) context.read<DoctorsListCubit>().load();
          },
        );
      },
    );
  }
}

class _AddDoctorButton extends StatelessWidget {
  const _AddDoctorButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Material(
      color: scheme.primary,
      borderRadius: BorderRadius.circular(context.adminFabRadius),
      clipBehavior: Clip.antiAlias,
      elevation: 3,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: context.adminFabHeight,
          padding: EdgeInsets.symmetric(horizontal: context.s20),
          alignment: Alignment.center,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.add,
                color: scheme.onPrimary,
                size: context.iconSocial,
              ),
              SizedBox(width: context.s8),
              Text(
                t.adminAddDoctor,
                style: context.semiBold16.copyWith(color: scheme.onPrimary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
