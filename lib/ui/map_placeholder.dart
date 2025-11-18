import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
      child: Image.asset(
        'assets/map_placeholder.png',
        fit: BoxFit.cover,
      ),
      
    );
  }
}