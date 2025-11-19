import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

class FieldsPage extends StatelessWidget {
  const FieldsPage({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // 100% прозрачный
        statusBarIconBrightness: Brightness.dark, // белые иконки
        statusBarBrightness: Brightness.dark, // для iOS
      ),
    );


    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Column(
          children: [

            // ---------- Верхний бар ----------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  const Text(
                    "Поля",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.search, size: 26),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.add, size: 26),
                  ),
                ],
              ),
            ),

            // ---------- Пустой блок ----------
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12), // отступы слева/справа по 12px
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(242, 242, 247, 1), // фон для области списка полей
                    borderRadius: BorderRadius.all(Radius.circular(24)), // скругление 24px со всех сторон
                  ),
                  // Если нужно обрезать содержимое по скруглённым углам, оберните в ClipRRect
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        // Иконка
                        SvgPicture.asset(
                          'assets/icons/fields.svg',
                          width: 48,
                          height: 48,
                          color: const Color.fromRGBO(142, 142, 147, 1),
                        ),
                      
                        const SizedBox(height: 12),

                        const Text(
                          "Добавьте поля, чтобы начать\nанализ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color.fromRGBO(142, 142, 147, 1),
                            fontSize: 16,
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Зеленая кнопка
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: SvgPicture.asset(
                            'assets/icons/plusbig.svg',
                            width: 24,
                            height: 24,
                            color: Colors.white,
                          ),
                          label: const Text(
                            "Добавить поля",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 16),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2FAE4A),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
