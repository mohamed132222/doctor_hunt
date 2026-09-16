import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/home_bottom_nav.dart';

/// Bottom-nav container that hosts the in-app tabs via [navigationShell].
///
/// Every tab keeps its own navigation stack (go_router `StatefulShellRoute`),
/// so state is preserved when switching tabs.
class MainShell extends StatelessWidget {
  const MainShell({super.key, required this.navigationShell});

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
