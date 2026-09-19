import 'package:flutter/material.dart';

import '../../../../../core/constants/app_strings.dart';
import '../widgets/placeholder_tab.dart';

class BookScreen extends StatelessWidget {
  const BookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderTab(
      title: AppStrings.tabBook,
      icon: Icons.menu_book_rounded,
    );
  }
}
