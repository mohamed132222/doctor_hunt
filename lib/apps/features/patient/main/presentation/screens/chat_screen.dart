import 'package:doctor_hunt/apps/core/i18n/strings.g.dart';
import 'package:flutter/material.dart';

import '../widgets/placeholder_tab.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PlaceholderTab(title: t.tabChat, icon: Icons.chat_bubble);
  }
}
