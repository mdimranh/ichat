import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StylishBottomBar(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      option: AnimatedBarOptions(iconSize: 24),
      items: [
        BottomBarItem(
          icon: const Icon(Icons.chat),
          title: const Text('Chats'),
          selectedColor: Colors.green,
          showBadge: true,
          badge: Text('3'),
          badgeColor: Colors.red,
        ),
        BottomBarItem(
          icon: const Icon(Icons.phone),
          title: const Text('Calls'),
          selectedColor: Colors.green,
        ),
        BottomBarItem(
          icon: const Icon(Icons.group),
          title: const Text('Groups'),
          selectedColor: Colors.green,
        ),
        BottomBarItem(
          icon: const Icon(Icons.folder_copy),
          title: const Text('Channels'),
          selectedColor: Colors.green,
        ),
      ],
      hasNotch: true,
      notchStyle: NotchStyle.circle,
      fabLocation: StylishBarFabLocation.center,
      currentIndex: currentIndex,
      onTap: onTap,
    );
  }
}
