import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings.dart';
import '../widgets/placeholder_tab.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderTab(
      title: AppStrings.tabFavorites,
      icon: Icons.favorite_rounded,
    );
  }
}
