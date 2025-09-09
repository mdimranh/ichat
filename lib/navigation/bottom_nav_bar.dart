import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  Widget _buildIcon(List<List<dynamic>> iconData, bool isSelected) {
    return Container(
      // padding: const EdgeInsets.symmetric(
      //   horizontal: 10,
      //   vertical: 4,
      // ), // Reduced padding to keep badge close
      // decoration: isSelected
      //     ? BoxDecoration(
      //         color: Colors.green.withOpacity(0.2),
      //         borderRadius: BorderRadius.circular(10),
      //       )
      //     : null,
      child: HugeIcon(
        icon: iconData,
        color: isSelected ? Colors.green : Colors.grey,
        size: 24,
        strokeWidth: 2,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StylishBottomBar(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      option: AnimatedBarOptions(iconSize: 24),
      items: [
        BottomBarItem(
          icon: _buildIcon(
            HugeIcons.strokeRoundedChatting01,
            currentIndex == 0,
          ),
          title: const Text('Chats'),
          selectedColor: Colors.green,
          showBadge: true,
          badge: const Text(
            '3',
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
          badgeColor: Colors.red,
          selectedIcon: _buildIcon(HugeIcons.strokeRoundedChatting01, true),
        ),
        BottomBarItem(
          icon: _buildIcon(HugeIcons.strokeRoundedCall02, currentIndex == 1),
          title: const Text('Calls'),
          selectedColor: Colors.green,
          selectedIcon: _buildIcon(HugeIcons.strokeRoundedCall02, true),
        ),
        BottomBarItem(
          icon: _buildIcon(
            HugeIcons.strokeRoundedUserMultiple02,
            currentIndex == 2,
          ),
          title: const Text('Groups'),
          selectedColor: Colors.green,
          selectedIcon: _buildIcon(HugeIcons.strokeRoundedUserMultiple02, true),
        ),
        BottomBarItem(
          icon: _buildIcon(HugeIcons.strokeRoundedClipboard, currentIndex == 3),
          title: const Text('Channels'),
          selectedColor: Colors.green,
          selectedIcon: _buildIcon(HugeIcons.strokeRoundedClipboard, true),
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
