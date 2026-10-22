import 'package:doctor_hunt/apps/core/di/injection.dart';
import 'package:doctor_hunt/generated/image_assets.dart';
import 'package:doctor_hunt/apps/core/extensions/media_query_extension.dart';
import 'package:doctor_hunt/apps/core/router/app_router.dart';
import 'package:doctor_hunt/apps/core/themes/app_colors.dart';
import 'package:doctor_hunt/apps/core/themes/app_theme.dart';
import 'package:doctor_hunt/apps/core/widgets/app_outlined_button.dart';
import 'package:doctor_hunt/apps/core/widgets/app_top_bar.dart';
import 'package:doctor_hunt/apps/core/widgets/avatar.dart';
import 'package:doctor_hunt/apps/core/widgets/confirm_dialog.dart';
import 'package:doctor_hunt/apps/core/widgets/info_tile.dart';
import 'package:doctor_hunt/apps/core/widgets/primary_button.dart';
import 'package:doctor_hunt/apps/core/widgets/rating_stars.dart';
import 'package:doctor_hunt/apps/core/widgets/status_pill.dart';
import 'package:doctor_hunt/apps/features/admin/doctors/presentation/controllers/doctor_details/doctor_details_cubit.dart';
import 'package:doctor_hunt/apps/features/common/doctors/data/models/doctor_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doctor_hunt/apps/core/widgets/app_svg_icon.dart';
import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:doctor_hunt/apps/core/widgets/skeleton.dart';

enum _DetailsAction { edit, delete }

class AdminDoctorDetailsScreen extends StatelessWidget {
  const AdminDoctorDetailsScreen({super.key, required this.doctorId});

  final String doctorId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DoctorDetailsCubit>(
      create: (_) => getIt<DoctorDetailsCubit>()..load(doctorId),
      child: _DetailsView(doctorId: doctorId),
    );
  }
}

class _DetailsView extends StatelessWidget {
  const _DetailsView({required this.doctorId});

  final String doctorId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.adminSurface,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.adminScreenPaddingH,
          ),
          child: BlocConsumer<DoctorDetailsCubit, DoctorDetailsState>(
            buildWhen: (p, c) =>
                p.status != c.status ||
                p.doctor != c.doctor ||
                p.deleted != c.deleted,
            listenWhen: (p, c) => p.deleted != c.deleted,
            listener: (context, state) {
              if (state.deleted) {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(t.adminDoctorDeleted)));
              }
            },
            builder: (context, state) {
              final cubit = context.read<DoctorDetailsCubit>();
              final doctor = state.doctor;
              return Column(
                children: [
                  AppTopBar(
                    title: t.adminDoctorDetailsTitle,
                    trailing: doctor == null
                        ? null
                        : _menu(context, cubit, doctor),
                  ),
                  Expanded(
                    child: doctor == null
                        ? const AppSkeletonDetails()
                        : _content(context, cubit, doctor),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _menu(BuildContext context, DoctorDetailsCubit cubit, Doctor doctor) {
    return PopupMenuButton<_DetailsAction>(
      icon: const Icon(Icons.more_vert),
      onSelected: (action) async {
        if (action == _DetailsAction.edit) {
          await AdminEditDoctorRoute(doctorId: doctorId).push<void>(context);
          if (context.mounted) cubit.load(doctorId);
        } else {
          final confirmed = await showConfirmDialog(
            context,
            title: t.adminDeleteDoctorConfirmTitle,
            message: t.adminDeleteDoctorConfirmBody(name: doctor.name),
            confirmLabel: t.commonDelete,
            danger: true,
          );
          if (confirmed && context.mounted) cubit.delete(doctorId);
        }
      },
      itemBuilder: (_) => [
        PopupMenuItem(
          value: _DetailsAction.edit,
          child: Text(t.adminEditDoctor),
        ),
        PopupMenuItem(
          value: _DetailsAction.delete,
          child: Text(t.adminDeleteDoctor),
        ),
      ],
    );
  }

  Widget _content(
    BuildContext context,
    DoctorDetailsCubit cubit,
    Doctor doctor,
  ) {
    final scheme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: context.s24),
          Center(child: _PhotoWithBadge(photo: doctor.photo)),
          SizedBox(height: context.s16),
          Text(
            doctor.name,
            style: context.bold28Black,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: context.s12),
          Center(
            child: StatusPill(
              label: doctor.isActive
                  ? t.adminStatusActive
                  : t.adminStatusInactive,
              variant: doctor.isActive
                  ? StatusVariant.success
                  : StatusVariant.danger,
            ),
          ),
          SizedBox(height: context.s24),
          Container(
            padding: EdgeInsets.symmetric(horizontal: context.s16),
            decoration: BoxDecoration(
              color: scheme.surface,
              borderRadius: BorderRadius.circular(context.adminCardRadius),
              boxShadow: [context.themeColors.cardShadow],
            ),
            child: Column(
              children: [
                SizedBox(height: context.s16),
                InfoTile(
                  iconWidget: AppSvgIcon(
                    AppAssets.specialityIcon,
                    size: context.iconSmall,
                  ),
                  label: t.adminSpecialtyLabel,
                  value: doctor.specialty.label,
                ),
                Divider(height: context.s24, color: scheme.outline),
                _RatingRow(rating: doctor.rating, reviews: doctor.reviewsCount),
                Divider(height: context.s24, color: scheme.outline),
                InfoTile(
                  iconWidget: AppSvgIcon(
                    AppAssets.consultationFeeIcon,
                    size: context.iconSmall,
                  ),
                  label: t.adminConsultationFee,
                  value: '\$${doctor.fee.toStringAsFixed(2)}',
                ),
                SizedBox(height: context.s16),
              ],
            ),
          ),
          SizedBox(height: context.s24),
          PrimaryButton(
            label: t.adminEditDoctor,
            width: double.infinity,
            icon: Icon(
              Icons.edit,
              color: scheme.onPrimary,
              size: context.iconSmall,
            ),
            onPressed: () async {
              await AdminEditDoctorRoute(
                doctorId: doctorId,
              ).push<void>(context);
              if (context.mounted) cubit.load(doctorId);
            },
          ),
          SizedBox(height: context.s12),
          AppOutlinedButton(
            label: t.adminManageAvailability,
            icon: Icons.event_note_outlined,
            height: context.confirmHeight,
            onPressed: () async {
              await AdminAvailabilityRoute(
                doctorId: doctorId,
              ).push<void>(context);
              if (context.mounted) cubit.load(doctorId);
            },
          ),
          SizedBox(height: context.s24),
        ],
      ),
    );
  }
}

class _PhotoWithBadge extends StatelessWidget {
  const _PhotoWithBadge({this.photo});

  final String? photo;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final size = context.adminDetailPhoto;

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: PhotoAvatar(size: size, imagePath: photo),
          ),
          Positioned(
            right: 0,
            bottom: context.s4,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: scheme.surface,
              ),
              child: AppSvgIcon(
                AppAssets.verificationIcon,
                size: context.iconSmall,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RatingRow extends StatelessWidget {
  const _RatingRow({required this.rating, required this.reviews});

  final double rating;
  final int reviews;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final box = context.infoTileIconBox;

    return Row(
      children: [
        Container(
          width: box,
          height: box,
          decoration: BoxDecoration(
            color: scheme.primary.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(context.infoTileRadius),
          ),
          child: Icon(
            Icons.star_outline_rounded,
            color: scheme.primary,
            size: context.iconSmall,
          ),
        ),
        SizedBox(width: context.s12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                t.adminRating.toUpperCase(),
                style: context.regular12TextSub.copyWith(letterSpacing: 0.5),
              ),
              SizedBox(height: context.s2),
              Row(
                children: [
                  RatingStars(rating: rating, size: context.popularStarSize),
                  SizedBox(width: context.s6),
                  Flexible(
                    child: Text(
                      '${rating.toStringAsFixed(1)} · '
                      '${t.adminReviewsCount(count: reviews)}',
                      style: context.semiBold14Black,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
