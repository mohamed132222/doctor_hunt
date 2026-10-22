import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/appsize/app_size.dart';
import '../../../../../core/di/injection.dart';
import '../../../../../core/extensions/media_query_extension.dart';
import '../../../../../core/themes/app_colors.dart';
import '../controllers/favorites/favorites_cubit.dart';
import '../widgets/home_bottom_nav.dart';
import '../widgets/patient_drawer.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  final ZoomDrawerController _drawerController = ZoomDrawerController();

  final FavoritesCubit _favorites = getIt<FavoritesCubit>()..ensureLoaded();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FavoritesCubit>.value(
      value: _favorites,
      child: ZoomDrawer(
        controller: _drawerController,
        style: DrawerStyle.defaultStyle,
        menuScreen: PatientDrawer(navigationShell: widget.navigationShell),
        mainScreen: _MainScreen(navigationShell: widget.navigationShell),
        borderRadius: context.drawerMainRadius,
        showShadow: true,
        angle: 0.0,
        drawerShadowsBackgroundColor: AppColors.drawerBackground,
        menuBackgroundColor: AppColors.drawerBackground,
        shadowLayer1Color: AppColors.drawerShadowNear,
        shadowLayer2Color: AppColors.drawerShadowFar,
        mainScreenScale: AppSize.drawerMainScale,
        slideWidth:
            MediaQuery.sizeOf(context).width * AppSize.drawerSlideFraction,
        mainScreenTapClose: true,
        disableDragGesture: true,
        openCurve: Curves.easeOutCubic,
        closeCurve: Curves.easeInCubic,
      ),
    );
  }
}

class _MainScreen extends StatelessWidget {
  const _MainScreen({required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: HomeBottomNav(
        currentIndex: navigationShell.currentIndex,
        onSelect: (index) => navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        ),
      ),
    );
  }
}
