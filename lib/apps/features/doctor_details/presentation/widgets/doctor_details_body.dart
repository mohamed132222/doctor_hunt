import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/appsize/app_size.dart';
import '../../../../core/appsize/screen_utils.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/router/app_router.dart';
import '../../../main/data/models/doctor.dart';
import '../../data/models/doctor_details_content.dart';
import 'doctor_map_card.dart';
import 'doctor_services.dart';
import 'doctor_stats_card.dart';
import 'doctor_summary_card.dart';
import 'doctor_top_bar.dart';

/// Body of the doctor details screen: a pinned top bar with the details
/// scrolling beneath it, ending in the clinic map.
class DoctorDetailsBody extends StatelessWidget {
  const DoctorDetailsBody({super.key, required this.doctor});

  final Doctor doctor;

  void _onBook(BuildContext context) {
    context.pushNamed(
      RouteName.booking,
      pathParameters: {'doctorId': doctor.id},
    );
  }

  @override
  Widget build(BuildContext context) {
    final gutter = EdgeInsets.symmetric(
      horizontal: context.w(AppSize.homeRowPaddingH),
    );

    return Column(
      children: [
        SafeArea(
          bottom: false,
          child: DoctorTopBar(
            title: AppStrings.doctorDetailsTitle,
            onBack: () => context.pop(),
            actionTooltip: AppStrings.searchDoctors,
            onAction: () => context.goNamed(RouteName.home),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: gutter,
                  child: DoctorSummaryCard(
                    doctor: doctor,
                    onBook: () => _onBook(context),
                  ),
                ),
                SizedBox(height: context.w(AppSize.s16)),
                Padding(
                  padding: gutter,
                  child: DoctorStatsCard(stats: kDoctorStats),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: context.w(AppSize.servicesPaddingH),
                    top: context.w(AppSize.servicesPaddingTop),
                    right: context.w(AppSize.servicesPaddingH),
                  ),
                  child: const DoctorServices(points: kServicePoints),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSize.s20,
                    AppSize.s20,
                    AppSize.s20,
                    AppSize.s42,
                  ),
                  child: const DoctorMapCard(),
                ),
                SizedBox(height: context.w(AppSize.s16)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
