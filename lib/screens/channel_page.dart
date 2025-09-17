import 'package:flutter/material.dart';
import 'package:qalb/widgets/empty.dart';

class ChannelPage extends StatelessWidget {
  const ChannelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Empty(
        icon: Icons.folder_copy,
        message: "Didn't join any channel yet.",
      ),
    );
  }
}
