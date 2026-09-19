import 'package:doctor_hunt/apps/core/i18n/strings.g.dart';
import 'package:flutter/material.dart';

import '../widgets/placeholder_tab.dart';

class BookScreen extends StatelessWidget {
  const BookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PlaceholderTab(title: t.tabBook, icon: Icons.menu_book_rounded);
  }
}
