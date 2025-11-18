import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> icons = [
      'assets/icons/map.svg',
      'assets/icons/fields.svg',
      'assets/icons/profile.svg',
    ];

    final List<String> labels = [
      'Карта',
      'Поля',
      'Профиль',
    ];

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      backgroundColor: Colors.white,

      showSelectedLabels: true,
      showUnselectedLabels: true,

      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.grey,

      items: List.generate(icons.length, (index) {
        return BottomNavigationBarItem(
          icon: SvgPicture.asset(
            icons[index],
            width: 26,
            colorFilter: ColorFilter.mode(
              currentIndex == index ? Colors.green : Colors.grey,
              BlendMode.srcIn,
            ),
          ),
          label: labels[index],
        );
      }),
    );
  }
}
