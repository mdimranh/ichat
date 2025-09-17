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

  Widget _buildIcon(
    List<List<dynamic>> iconData,
    bool isSelected,
    BuildContext context,
  ) {
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
        color: isSelected ? Theme.of(context).colorScheme.primary : Colors.grey,
        size: 24,
        strokeWidth: 2,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StylishBottomBar(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      option: AnimatedBarOptions(iconSize: 24, iconStyle: IconStyle.Default),
      backgroundColor: Theme.of(
        context,
      ).bottomNavigationBarTheme.backgroundColor,
      elevation: 0,
      items: [
        BottomBarItem(
          icon: _buildIcon(
            HugeIcons.strokeRoundedChatting01,
            currentIndex == 0,
            context,
          ),
          title: const Text('Chats'),
          selectedColor: Theme.of(context).colorScheme.primary,
          showBadge: true,
          badge: const Text(
            '3',
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
          badgeColor: Colors.red,
          selectedIcon: _buildIcon(
            HugeIcons.strokeRoundedChatting01,
            true,
            context,
          ),
        ),
        BottomBarItem(
          icon: _buildIcon(
            HugeIcons.strokeRoundedCall02,
            currentIndex == 1,
            context,
          ),
          title: const Text('Calls'),
          selectedColor: Theme.of(context).colorScheme.primary,
          selectedIcon: _buildIcon(
            HugeIcons.strokeRoundedCall02,
            true,
            context,
          ),
        ),
        BottomBarItem(
          icon: _buildIcon(
            HugeIcons.strokeRoundedUserMultiple02,
            currentIndex == 2,
            context,
          ),
          title: const Text('Groups'),
          selectedColor: Theme.of(context).colorScheme.primary,
          selectedIcon: _buildIcon(
            HugeIcons.strokeRoundedUserMultiple02,
            true,
            context,
          ),
        ),
        BottomBarItem(
          icon: _buildIcon(
            HugeIcons.strokeRoundedClipboard,
            currentIndex == 3,
            context,
          ),
          title: const Text('Channels'),
          selectedColor: Theme.of(context).colorScheme.primary,
          selectedIcon: _buildIcon(
            HugeIcons.strokeRoundedClipboard,
            true,
            context,
          ),
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
