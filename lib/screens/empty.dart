import 'package:flutter/material.dart';

class Empty extends StatelessWidget {
  final IconData icon;
  final String message;
  final Color iconColor;

  const Empty({
    super.key,
    required this.icon,
    required this.message,
    this.iconColor = Colors.green, // default color
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Opacity(
        opacity: 0.7,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, size: 120, color: iconColor),
            const SizedBox(height: 16),
            Text(
              message,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
