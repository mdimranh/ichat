import 'package:flutter/material.dart';
import 'package:qalb/screens/empty.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Empty(icon: Icons.chat, message: "Didn't converse yet."),
    );
  }
}
