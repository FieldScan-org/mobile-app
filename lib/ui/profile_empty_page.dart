import 'package:fieldscan/ui/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'sign_up.dart'; // добавлен импорт

class ProfileEmptyPage extends StatelessWidget {
  const ProfileEmptyPage({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Column(
          children: [
            // ---------- Большой белый контейнер ----------
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      )
                    ],
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        // Иконка
                        SvgPicture.asset(
                          'assets/icons/profile-circle.svg',
                          width: 50,
                          height: 50,
                          color: const Color.fromRGBO(142, 142, 147, 1),
                        ),

                        const SizedBox(height: 16),

                        const Text(
                          "Создайте учетную запись или\n"
                          "войдите в систему, чтобы\n"
                          "сохранить свои данные.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            height: 1.35,
                            color: Colors.black87,
                          ),
                        ),

                        const SizedBox(height: 28),

                        // Зеленая кнопка — Войти
                        SizedBox(
                          width: 315,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => LoginScreen()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2FAE4A),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            child: const Text(
                              "Войти",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        // СЕРАЯ кнопка — Зарегистрироваться
                        SizedBox(
                          width: 315,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SignUpScreen()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFE5E5EA),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            child: const Text(
                              "Зарегистрироваться",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.black87,
                              ),
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
