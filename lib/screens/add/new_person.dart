import 'package:flutter/material.dart';
import 'package:qalb/screens/empty.dart';

class AddNewPersonPage extends StatelessWidget {
  const AddNewPersonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Person"),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Divider(
            thickness: 0.5,
            height: 0.5,
            color: Colors.black.withOpacity(0.1),
          ),
        ),
      ),
      body: Empty(icon: Icons.person, message: "Not implemented yet."),
    );
  }
}
