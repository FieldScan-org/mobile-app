import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'widgets/add_field_button.dart'; // добавлен импорт

class MapPlaceholder extends StatelessWidget {
  const MapPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, 
        statusBarIconBrightness: Brightness.light, 
        statusBarBrightness: Brightness.dark, 
      ),
    );


    return SizedBox.expand(
      child: Stack(
        children: [
          Image.asset(
            'assets/map_placeholder.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),

          // Кнопка, поднятая на 6px над BottomNavBar
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: kBottomNavigationBarHeight - 50),
              child: AddFieldButton(
                onPressed: () {
                  print("Добавить поле");
                  // Здесь позже откроется экран добавления
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}