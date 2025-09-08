import 'package:flutter/material.dart';

import '../screens/empty.dart';

class GroupPage extends StatelessWidget {
  const GroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Empty(icon: Icons.group, message: "Didn't join any group yet."),
    );
  }
}
