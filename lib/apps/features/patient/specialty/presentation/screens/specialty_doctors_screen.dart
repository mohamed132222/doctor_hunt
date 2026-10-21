import 'package:doctor_hunt/apps/core/enums/app_status.dart';
import 'package:doctor_hunt/apps/core/extensions/media_query_extension.dart';
import 'package:doctor_hunt/apps/core/router/app_router.dart';
import 'package:doctor_hunt/apps/core/widgets/app_background.dart';
import 'package:doctor_hunt/apps/features/common/doctors/data/models/doctor_specialty.dart';
import 'package:doctor_hunt/apps/features/patient/doctor_details/presentation/widgets/doctor_top_bar.dart';
import 'package:doctor_hunt/apps/features/patient/specialty/presentation/controllers/specialty_doctors/specialty_doctors_cubit.dart';
import 'package:doctor_hunt/apps/core/widgets/empty_state.dart';
import 'package:doctor_hunt/apps/core/widgets/list_more_footer.dart';
import 'package:doctor_hunt/apps/features/patient/specialty/presentation/widgets/specialty_doctor_card.dart';
import 'package:doctor_hunt/generated/image_assets.dart';
import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:doctor_hunt/apps/core/widgets/skeleton.dart';

class SpecialtyDoctorsScreen extends StatelessWidget {
  const SpecialtyDoctorsScreen({super.key, required this.specialty});

  final DoctorSpecialty specialty;

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            DoctorTopBar(
              title: specialty.label,
              centerTitle: false,
              onBack: () => context.pop(),
            ),
            Expanded(
              child: BlocBuilder<SpecialtyDoctorsCubit, SpecialtyDoctorsState>(
                buildWhen: (p, c) =>
                    p.status != c.status ||
                    p.doctors != c.doctors ||
                    p.error != c.error,
                builder: (context, state) {
                  switch (state.status) {
                    case AppStatus.initial:
                    case AppStatus.loading:
                      return const AppSkeletonList();
                    case AppStatus.error:
                      return _ErrorState(
                        message: state.error ?? '',
                        onRetry: () =>
                            context.read<SpecialtyDoctorsCubit>().load(),
                      );
                    case AppStatus.success:
                      if (state.doctors.isEmpty) return const _EmptyState();
                      return ListView.separated(
                        padding: EdgeInsets.fromLTRB(
                          context.homeRowPaddingH,
                          context.s16,
                          context.homeRowPaddingH,
                          context.s24,
                        ),
                        itemCount:
                            state.doctors.length + (state.hasMore ? 1 : 0),
                        separatorBuilder: (_, _) =>
                            SizedBox(height: context.s12),
                        itemBuilder: (context, index) {
                          if (index >= state.doctors.length) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              if (context.mounted) {
                                context
                                    .read<SpecialtyDoctorsCubit>()
                                    .loadMore();
                              }
                            });
                            return const ListMoreFooter();
                          }
                          final doctor = state.doctors[index];
                          return SpecialtyDoctorCard(
                            doctor: doctor,
                            onTap: () => DoctorDetailsRoute(
                              doctorId: doctor.id,
                            ).push(context),
                          );
                        },
                      );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return EmptyState(
      title: t.noSearchResults,
      message: t.noSearchResultsHint,
      svgAsset: AppAssets.emptyDoctorsIcon,
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.s24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium,
            ),
            SizedBox(height: context.s12),
            IconButton(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
            ),
          ],
        ),
      ),
    );
  }
}
