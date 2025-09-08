import 'package:flutter/material.dart';
import 'package:qalb/screens/empty.dart';

class CallPage extends StatelessWidget {
  const CallPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Empty(icon: Icons.phone, message: "Didn't call yet."),
    );
  }
}
