import 'package:flutter/material.dart';
import 'fields_page.dart';
import 'map_placeholder.dart';
import 'profile_empty_page.dart';
import 'widgets/bottom_nav_bar.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0; 

  final List<Widget> _pages = const [
    MapPlaceholder(),
    FieldsPage(),
    ProfileEmptyPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],

      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
