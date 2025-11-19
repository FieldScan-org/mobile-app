import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'login_screen.dart'; // добавлен импорт
class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

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
                      ),
                    ],
                  ),
                  child: Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          // ---------- Логотип ----------
                          SvgPicture.asset(
                            'assets/icons/logo.svg',
                              width: 91,
                              height: 105,
                              color: const Color.fromRGBO(52, 168, 83, 1),
                          ),

                          const SizedBox(height: 24),

                          const Text(
                            "Добро пожаловать в",
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const Text(
                            "Agro Lab",
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 8),

                          // ---------- "Есть аккаунт? Войти" (подчёркнуто только "Войти") ----------
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                "Есть аккаунт? ",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginScreen(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Войти",
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          
                          const SizedBox(height: 24),

                          // ---------- Email ----------
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFF2F2F7),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                hintText: "Email",
                                hintStyle: TextStyle(color: Color(0xFFB3B3B3)),
                              ),
                            ),
                          ),

                          const SizedBox(height: 12),

                          // ---------- Пароль ----------
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFF2F2F7),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                hintText: "Пароль",
                                hintStyle: TextStyle(color: Color(0xFFB3B3B3)),
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          // ---------- Зеленая кнопка ----------
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF2FAE4A),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                "Зарегистрироваться",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          const Text(
                            "ИЛИ",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black45,
                            ),
                          ),

                          const SizedBox(height: 20),

                          // ---------- Google Button ----------
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Colors.grey),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/icons/google.png",
                                    height: 18,
                                  ),
                                  const SizedBox(width: 10),
                                  const Text(
                                    "Continue with Google",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 40),
                        ],
                      ),
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
