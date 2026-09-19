import 'package:flutter/material.dart';

import '../../../../../core/constants/app_strings.dart';
import '../widgets/placeholder_tab.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderTab(
      title: AppStrings.tabChat,
      icon: Icons.chat_bubble,
    );
  }
}
