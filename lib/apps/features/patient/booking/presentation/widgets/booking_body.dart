import 'package:doctor_hunt/apps/features/patient/booking/presentation/widgets/date_card.dart';
import 'package:doctor_hunt/apps/core/themes/app_theme.dart';
import 'package:doctor_hunt/apps/features/patient/main/data/catalog/patient_catalog.dart';
import 'package:doctor_hunt/apps/features/patient/main/presentation/widgets/doctor_photo.dart';
import 'package:doctor_hunt/apps/core/widgets/rating_stars.dart';
import 'package:doctor_hunt/apps/features/patient/booking/presentation/widgets/slot_button.dart';
import 'package:doctor_hunt/apps/core/di/injection.dart';
import 'package:doctor_hunt/apps/core/enums/app_status.dart';
import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/appsize/app_size.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/extensions/media_query_extension.dart';
import '../../../../../core/router/app_router.dart';
import '../../../../../core/widgets/primary_button.dart';
import '../../../appointment/presentation/widgets/appointment_confirmed_dialog.dart';
import '../../../doctor_details/presentation/widgets/doctor_top_bar.dart';
import '../../../main/data/models/doctor_model.dart';
import '../../../main/presentation/controllers/appointments_refresh/appointments_refresh_cubit.dart';
import '../controllers/booking/booking_cubit.dart';
import '../../data/models/booking_day_model.dart';
import 'package:doctor_hunt/generated/image_assets.dart';
import 'package:doctor_hunt/apps/core/widgets/skeleton.dart';

class BookingBody extends StatelessWidget {
  const BookingBody({super.key, required this.doctor});

  final Doctor doctor;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookingCubit, BookingState>(
      listenWhen: (p, c) => p.booked != c.booked || p.error != c.error,
      buildWhen: (p, c) =>
          p.status != c.status ||
          p.doctor != c.doctor ||
          p.days != c.days ||
          p.selectedDay != c.selectedDay ||
          p.selectedSlot != c.selectedSlot ||
          p.isConfirming != c.isConfirming,
      listener: (context, state) async {
        if (state.error != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.error!)));
        }
        final booked = state.booked;
        if (booked != null) {
          final done = await showAppointmentConfirmedDialog(
            context,
            doctorName: booked.doctorName,
            date: AppStrings.monthDay(booked.dateTime),
            time: AppStrings.clockTime(booked.dateTime),
          );
          if (done == true && context.mounted) {
            getIt<AppointmentsRefreshCubit>().ping();
            const BookRoute().go(context);
          }
        }
      },
      builder: (context, state) {
        return SafeArea(
          bottom: false,
          child: Column(
            children: [
              DoctorTopBar(
                title: AppStrings.selectTimeTitle,
                centerTitle: false,
              ),
              Expanded(
                child: state.status == AppStatus.loading
                    ? const AppSkeletonDetails()
                    : _Content(doctor: doctor, state: state),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _BookingDateStrip extends StatelessWidget {
  const _BookingDateStrip({
    super.key,
    required this.days,
    required this.selectedIndex,
    required this.onSelect,
  });

  final List<BookingDay> days;
  final int selectedIndex;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    final textScale = MediaQuery.textScalerOf(context).scale(1);
    final textExtra =
        (textScale - 1).clamp(0.0, 1.0) * context.bookingDateTextBlock;

    return SizedBox(
      height: context.bookingDateHeight + context.s16 + textExtra,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(vertical: context.s8),
        itemCount: days.length,
        separatorBuilder: (context, index) => SizedBox(width: context.s12),
        itemBuilder: (context, index) => DateCard(
          day: days[index],
          label: AppStrings.dateLabel(
            days[index].date,
            isToday: index == 0,
            isTomorrow: index == 1,
          ),
          selected: index == selectedIndex,
          onTap: () => onSelect(index),
        ),
      ),
    );
  }
}

class _BookingDoctorCard extends StatefulWidget {
  const _BookingDoctorCard({super.key, required this.doctor});

  final Doctor doctor;

  @override
  State<_BookingDoctorCard> createState() => _BookingDoctorCardState();
}

class _BookingDoctorCardState extends State<_BookingDoctorCard> {
  late bool _favorite = widget.doctor.isFavorite;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final colors = context.themeColors;
    final doctor = widget.doctor;
    final radius = BorderRadius.circular(context.bookingCardRadius);
    final photo = context.bookingCardPhoto;
    final clinic = getIt<PatientCatalog>().clinicLocation;
    final clinicText = clinic.isNotEmpty ? clinic : t.clinicFallback;

    return Container(
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: radius,
        boxShadow: [colors.homeCardShadow],
      ),
      padding: EdgeInsets.all(context.s12),
      child: Row(
        children: [
          Hero(
            tag: doctor.photoHeroTag,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(context.bookingDateRadius),
              child: SizedBox(
                width: photo,
                height: photo,
                child: DoctorPhoto(doctor: doctor, iconSize: context.s24),
              ),
            ),
          ),
          SizedBox(width: context.s12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doctor.name,
                  style: theme.textTheme.titleMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: context.s2),
                Text(
                  clinicText,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontSize: AppSize.s12,
                    color: scheme.onSurfaceVariant,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: context.s6),
                RatingStars(rating: doctor.rating, size: context.s12),
              ],
            ),
          ),
          SizedBox(width: context.s8),
          GestureDetector(
            onTap: () => setState(() => _favorite = !_favorite),
            behavior: HitTestBehavior.opaque,
            child: Icon(
              _favorite ? Icons.favorite : Icons.favorite_border,
              size: context.detailsHeartSize,
              color: _favorite ? scheme.error : colors.favoriteOutline,
            ),
          ),
        ],
      ),
    );
  }
}

class _BookingEmptyState extends StatelessWidget {
  const _BookingEmptyState({
    super.key,
    required this.dayLabel,
    required this.nextAvailabilityLabel,
    this.onNextAvailability,
    this.onContactClinic,
  });

  final String dayLabel;
  final String? nextAvailabilityLabel;
  final VoidCallback? onNextAvailability;
  final VoidCallback? onContactClinic;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          dayLabel,
          textAlign: TextAlign.center,
          style: theme.textTheme.titleMedium,
        ),
        SizedBox(height: context.s16),
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 260),
            child: AspectRatio(
              aspectRatio: 550 / 505,
              child: Image.asset(
                AppAssets.bookingNoSlotsImage,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        SizedBox(height: context.s12),
        Text(
          t.noSlotsAvailable,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        if (nextAvailabilityLabel != null) ...[
          SizedBox(height: context.s20),
          _BookingActionButton(
            label: nextAvailabilityLabel!,
            filled: true,
            onTap: onNextAvailability,
          ),
        ],
        SizedBox(height: context.s16),
        _BookingActionButton(
          label: t.contactClinic,
          filled: false,
          onTap: onContactClinic,
        ),
      ],
    );
  }
}

class _BookingActionButton extends StatelessWidget {
  const _BookingActionButton({
    required this.label,
    required this.filled,
    this.onTap,
  });

  final String label;
  final bool filled;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final radius = BorderRadius.circular(context.bookingActionRadius);
    final shape = RoundedRectangleBorder(
      borderRadius: radius,
      side: filled
          ? BorderSide.none
          : BorderSide(color: scheme.primary, width: AppSize.borderThin),
    );

    return SizedBox(
      height: context.bookingActionHeight,
      child: Material(
        color: filled ? scheme.primary : scheme.surface,
        shape: shape,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Center(
            child: Text(
              label,
              style: theme.textTheme.labelLarge?.copyWith(
                fontSize: AppSize.s16,
                color: filled ? scheme.onPrimary : scheme.primary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}

class _BookingSlotGrid extends StatelessWidget {
  const _BookingSlotGrid({
    super.key,
    required this.period,
    required this.slots,
    this.selectedSlots = const {},
    this.onSelect,
  });

  final String period;
  final List<TimeSlot> slots;
  final Set<TimeSlot> selectedSlots;
  final ValueChanged<TimeSlot>? onSelect;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (slots.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.periodSlots(period, slots.length),
          style: theme.textTheme.titleSmall?.copyWith(fontSize: AppSize.s14),
        ),
        SizedBox(height: context.s8),
        LayoutBuilder(
          builder: (context, constraints) {
            final gap = context.s8;
            final columnWidth = (constraints.maxWidth - gap * 3) / 4;
            return Wrap(
              spacing: gap,
              runSpacing: gap,
              children: [
                for (final slot in slots)
                  SizedBox(
                    width: columnWidth,
                    child: SlotButton(
                      slot: slot,
                      selected: selectedSlots.contains(slot),
                      onTap: () => onSelect?.call(slot),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({required this.doctor, required this.state});

  final Doctor doctor;
  final BookingState state;

  String _dayLabel(int index, DateTime date) =>
      AppStrings.dateLabel(date, isToday: index == 0, isTomorrow: index == 1);

  int? _nextDayWithSlots() {
    for (var i = state.selectedDay + 1; i < state.days.length; i++) {
      if (state.days[i].hasSlots) return i;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final gutter = EdgeInsets.symmetric(horizontal: context.homeRowPaddingH);
    final cubit = context.read<BookingCubit>();
    final day = state.day;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: gutter,
            child: _BookingDoctorCard(doctor: doctor),
          ),
          SizedBox(height: context.s16),
          Padding(
            padding: gutter,
            child: _BookingDateStrip(
              days: state.days,
              selectedIndex: state.selectedDay,
              onSelect: cubit.selectDay,
            ),
          ),
          SizedBox(height: context.s12),
          Padding(
            padding: gutter,
            child: day == null
                ? const SizedBox.shrink()
                : (day.hasSlots
                      ? _Slots(state: state, day: day, cubit: cubit)
                      : _empty(context, cubit)),
          ),
          SizedBox(height: context.s24),
        ],
      ),
    );
  }

  Widget _empty(BuildContext context, BookingCubit cubit) {
    final next = _nextDayWithSlots();
    return _BookingEmptyState(
      dayLabel: _dayLabel(
        state.selectedDay,
        state.days[state.selectedDay].date,
      ),
      nextAvailabilityLabel: next == null
          ? null
          : t.nextAvailabilityOn(
              day: AppStrings.dateLabel(state.days[next].date),
            ),
      onNextAvailability: next == null ? null : () => cubit.selectDay(next),
      onContactClinic: () => ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(t.clinicFallback))),
    );
  }
}

class _Slots extends StatelessWidget {
  const _Slots({required this.state, required this.day, required this.cubit});

  final BookingState state;
  final BookingDay day;
  final BookingCubit cubit;

  @override
  Widget build(BuildContext context) {
    final selected = <TimeSlot>{
      if (state.selectedSlot != null) state.selectedSlot!,
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          AppStrings.dateLabel(
            day.date,
            isToday: state.selectedDay == 0,
            isTomorrow: state.selectedDay == 1,
          ),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(height: context.s16),
        _BookingSlotGrid(
          period: t.morningPeriod,
          slots: day.morning,
          selectedSlots: selected,
          onSelect: cubit.selectSlot,
        ),
        if (day.morning.isNotEmpty) SizedBox(height: context.s16),
        _BookingSlotGrid(
          period: t.afternoonPeriod,
          slots: day.afternoon,
          selectedSlots: selected,
          onSelect: cubit.selectSlot,
        ),
        if (day.afternoon.isNotEmpty) SizedBox(height: context.s16),
        _BookingSlotGrid(
          period: t.eveningPeriod,
          slots: day.evening,
          selectedSlots: selected,
          onSelect: cubit.selectSlot,
        ),
        if (state.selectedSlot != null) ...[
          SizedBox(height: context.s20),
          PrimaryButton(
            label: t.confirmButton,
            width: double.infinity,
            height: AppSize.bookingActionHeight,
            radius: AppSize.bookingActionRadius,
            isLoading: state.isConfirming,
            onPressed: cubit.confirm,
          ),
        ],
      ],
    );
  }
}
