import 'package:doctor_hunt/apps/core/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/extensions/media_query_extension.dart';
import '../../../../../core/router/app_router.dart';
import '../../../../../core/widgets/app_background.dart';
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
    final gutter = EdgeInsets.symmetric(horizontal: context.homeRowPaddingH);

    return AppBackground(
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            DoctorTopBar(
              title: t.findDoctorsTitle,
              centerTitle: false,
              onBack: () => context.pop(),
            ),
            Padding(
              padding: gutter,
              child: HomeSearchBar(
                initialQuery: widget.initialQuery,
                autofocus: widget.initialQuery.isEmpty,
                onChanged: _onQueryChanged,
              ),
            ),
            SizedBox(height: context.s16),
            Expanded(
              child: _results.isEmpty
                  ? _NoResults()
                  : ListView.separated(
                      padding: EdgeInsets.fromLTRB(
                        context.homeRowPaddingH,
                        0,
                        context.homeRowPaddingH,
                        context.s24,
                      ),
                      itemCount: _results.length,
                      separatorBuilder: (context, index) =>
                          SizedBox(height: context.s16),
                      itemBuilder: (context, index) {
                        final doctor = _results[index];
                        return SearchDoctorCard(
                          doctor: doctor,
                          onTap: () => DoctorDetailsRoute(
                            doctorId: doctor.id,
                          ).push(context),
                          onBook: () =>
                              BookingRoute(doctorId: doctor.id).push(context),
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
        padding: EdgeInsets.symmetric(horizontal: context.s32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.search_off_rounded,
              size: context.iconLarge * 0.5,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            SizedBox(height: context.s12),
            Text(
              t.noSearchResults,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium,
            ),
            SizedBox(height: context.s4),
            Text(
              t.noSearchResultsHint,
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
