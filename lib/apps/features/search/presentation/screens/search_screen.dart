import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/appsize/app_size.dart';
import '../../../../core/appsize/screen_utils.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/widgets/ellipse_background.dart';
import '../../../doctor_details/presentation/widgets/doctor_top_bar.dart';
import '../../../main/data/models/doctor.dart';
import '../../../main/presentation/widgets/home_search_bar.dart';
import '../widgets/search_doctor_card.dart';

/// Doctor search results. Filtering is local mock data for now — swap
/// [searchDoctors] for a repository call and this screen is unchanged.
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, this.initialQuery = ''});

  final String initialQuery;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late List<Doctor> _results = searchDoctors(widget.initialQuery);

  void _onQueryChanged(String value) {
    setState(() => _results = searchDoctors(value));
  }

  @override
  Widget build(BuildContext context) {
    final gutter = EdgeInsets.symmetric(
      horizontal: context.w(AppSize.homeRowPaddingH),
    );

    return Scaffold(
      body: EllipseBackground(
        child: Column(
          children: [
            SafeArea(
              bottom: false,
              child: DoctorTopBar(
                title: AppStrings.findDoctorsTitle,
                centerTitle: false,
                onBack: () => context.pop(),
              ),
            ),
            Padding(
              padding: gutter,
              child: HomeSearchBar(
                initialQuery: widget.initialQuery,
                autofocus: widget.initialQuery.isEmpty,
                onChanged: _onQueryChanged,
              ),
            ),
            SizedBox(height: context.w(AppSize.s16)),
            Expanded(
              child: _results.isEmpty
                  ? const _NoResults()
                  : ListView.separated(
                      padding: EdgeInsets.fromLTRB(
                        context.w(AppSize.homeRowPaddingH),
                        0,
                        context.w(AppSize.homeRowPaddingH),
                        context.w(AppSize.s24),
                      ),
                      itemCount: _results.length,
                      separatorBuilder: (context, index) =>
                          SizedBox(height: context.w(AppSize.s16)),
                      itemBuilder: (context, index) {
                        final doctor = _results[index];
                        return SearchDoctorCard(
                          doctor: doctor,
                          onTap: () => context.pushNamed(
                            RouteName.doctorDetails,
                            pathParameters: {'doctorId': doctor.id},
                          ),
                          onBook: () => context.pushNamed(
                            RouteName.booking,
                            pathParameters: {'doctorId': doctor.id},
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NoResults extends StatelessWidget {
  const _NoResults();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.w(AppSize.s32)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.search_off_rounded,
              size: context.w(AppSize.iconLarge) * 0.5,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            SizedBox(height: context.w(AppSize.s12)),
            Text(
              AppStrings.noSearchResults,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium,
            ),
            SizedBox(height: context.w(AppSize.s4)),
            Text(
              AppStrings.noSearchResultsHint,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
