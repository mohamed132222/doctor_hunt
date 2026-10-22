import 'package:doctor_hunt/apps/core/di/injection.dart';
import 'package:flutter/foundation.dart';
import 'package:doctor_hunt/apps/core/appsize/app_size.dart';
import 'package:doctor_hunt/apps/core/extensions/media_query_extension.dart';
import 'package:doctor_hunt/apps/core/themes/app_colors.dart';
import 'package:doctor_hunt/apps/core/themes/app_theme.dart';
import 'package:doctor_hunt/apps/core/router/app_router.dart';
import 'package:doctor_hunt/apps/features/patient/main/data/catalog/patient_catalog.dart';
import 'package:doctor_hunt/apps/features/patient/main/data/models/doctor_model.dart';
import 'package:doctor_hunt/apps/features/patient/main/presentation/controllers/favorites/favorites_cubit.dart';
import 'package:doctor_hunt/apps/features/patient/main/presentation/widgets/favorite_doctor_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:doctor_hunt/apps/core/widgets/skeleton.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  late final Future<void> _catalog = getIt<PatientCatalog>().ensureLoaded();

  @override
  void initState() {
    super.initState();
    context.read<FavoritesCubit>().ensureLoaded();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Doctor> _resolve(Set<String> ids) {
    final needle = _query.trim().toLowerCase();
    return [
      for (final doctor in kAllDoctors)
        if (ids.contains(doctor.id) &&
            (needle.isEmpty ||
                doctor.name.toLowerCase().contains(needle) ||
                doctor.specialty.toLowerCase().contains(needle)))
          doctor,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.gradientIce, AppColors.gradientMint],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.s24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: context.s8),
              Text(t.favoriteDoctorsTitle, style: context.bold24Black),
              SizedBox(height: context.s16),
              _SearchField(
                controller: _searchController,
                onChanged: (v) => setState(() => _query = v),
                onClear: () {
                  _searchController.clear();
                  setState(() => _query = '');
                },
              ),
              SizedBox(height: context.s16),
              Expanded(
                child: FutureBuilder<void>(
                  future: _catalog,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return const AppSkeletonList();
                    }
                    return BlocBuilder<FavoritesCubit, FavoritesState>(
                      buildWhen: (p, c) => !setEquals(p.ids, c.ids),
                      builder: (context, state) {
                        final doctors = _resolve(state.ids);
                        if (doctors.isEmpty) return const _EmptyFavorites();
                        return _Grid(
                          doctors: doctors,
                          onToggle: (id) =>
                              context.read<FavoritesCubit>().toggle(id),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Grid extends StatelessWidget {
  const _Grid({required this.doctors, required this.onToggle});

  final List<Doctor> doctors;
  final ValueChanged<String> onToggle;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.only(top: context.s4, bottom: context.s16),
      itemCount: doctors.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: context.s16,
        crossAxisSpacing: context.s16,
        childAspectRatio: AppSize.favoriteGridAspect,
      ),
      itemBuilder: (context, index) {
        final doctor = doctors[index];
        return FavoriteDoctorCard(
          doctor: doctor,
          isFavorite: true,
          onToggle: () => onToggle(doctor.id),
          onTap: () => DoctorDetailsRoute(doctorId: doctor.id).push(context),
        );
      },
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({
    required this.controller,
    required this.onChanged,
    required this.onClear,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(context.r12),
        boxShadow: [context.themeColors.cardShadow],
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: t.searchHintFull,
          prefixIcon: Icon(Icons.search, color: scheme.onSurfaceVariant),
          suffixIcon: controller.text.isEmpty
              ? null
              : IconButton(
                  icon: Icon(Icons.close, color: scheme.onSurfaceVariant),
                  onPressed: onClear,
                ),
          filled: true,
          fillColor: scheme.surface,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(context.r12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(context.r12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

class _EmptyFavorites extends StatelessWidget {
  const _EmptyFavorites();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.favorite_border,
            size: context.iconLarge,
            color: context.themeColors.favoriteOutline,
          ),
          SizedBox(height: context.s16),
          Text(t.favoritesEmptyTitle, style: context.bold18Black),
          SizedBox(height: context.s8),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.s32),
            child: Text(
              t.favoritesEmptyBody,
              textAlign: TextAlign.center,
              style: context.regular14TextSub,
            ),
          ),
        ],
      ),
    );
  }
}
