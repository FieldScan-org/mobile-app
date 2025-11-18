import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'ui/main_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarDividerColor: Colors.white,
    ),
  );

  runApp(const FieldScanApp());
}

class FieldScanApp extends StatelessWidget {
  const FieldScanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FieldScan',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}
