import 'package:flutter/material.dart';

Widget Avatar({required String imageUrl, bool isOnline = false}) {
  return Stack(
    children: [
      CircleAvatar(
        radius: 20,
        backgroundImage: NetworkImage(imageUrl),
        backgroundColor: Colors.green.shade100,
      ),
      if (isOnline)
        Positioned(
          right: 0,
          bottom: 0,
          child: Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              color: Colors.green, // active indicator color
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white, // border for clean look
                width: 2,
              ),
            ),
          ),
        ),
    ],
  );
}
