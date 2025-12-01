import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'profile_login_page.dart'; // использует PressableListTile

class ProfileMyProfilePage extends StatelessWidget {
  const ProfileMyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ),
    );

    void _showComingSoon(String title) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$title — в разработке'), duration: const Duration(seconds: 1)),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Верхняя строка: стрелка назад + "Назад"
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 16, 0),
              child: Row(
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () => Navigator.maybePop(context),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                      child: Row(
                        children: const [
                          Icon(Icons.arrow_back, size: 20),
                          SizedBox(width: 6),
                          Text('Назад', style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Заголовок
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Мой аккаунт',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
                ),
              ),
            ),

            const SizedBox(height: 8),

            // Карточка с опциями
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(242, 242, 242, 1),
                  borderRadius: BorderRadius.circular(16),
                  
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    PressableListTile(
                      borderRadius: BorderRadius.zero,
                      leading: CircleAvatar(
                        backgroundColor: const Color(0xFF2FAE4A),
                        child: const Icon(Icons.email, color: Colors.white, size: 20),
                      ),
                      title: const Text('Поменять почту'),
                      trailing: const Icon(Icons.chevron_right, color: Color.fromRGBO(142, 142, 147, 1)),
                      onTap: () => _showComingSoon('Поменять почту'),
                    ),

                    const Divider(height: 1, color: Color.fromRGBO(223, 223, 223, 1), indent: 8),

                    PressableListTile(
                      borderRadius: BorderRadius.zero,
                      leading: CircleAvatar(
                        backgroundColor: const Color(0xFF2FAE4A),
                        child: const Icon(Icons.lock, color: Colors.white, size: 20),
                      ),
                      title: const Text('Поменять пароль'),
                      trailing: const Icon(Icons.chevron_right, color: Color.fromRGBO(142, 142, 147, 1)),
                      onTap: () => _showComingSoon('Поменять пароль'),
                    ),

                    const Divider(height: 1, color: Color.fromRGBO(223, 223, 223, 1), indent: 8),

                    PressableListTile(
                      // нижняя плитка — скруглённые нижние углы, чтобы ripple не выходил за карту
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                      leading: CircleAvatar(
                        backgroundColor: const Color(0xFF2FAE4A),
                        child: const Icon(Icons.delete_outline, color: Colors.white, size: 20),
                      ),
                      title: const Text('Удалить аккаунт'),
                      trailing: const Icon(Icons.chevron_right, color: Color.fromRGBO(142, 142, 147, 1)),
                      onTap: () => _showComingSoon('Удалить аккаунт'),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Кнопка Выйти
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    // пример: выйти и вернуться на старт
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(242, 242, 242, 1),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 0,
                  ),
                  child: const Text('Выйти', style: TextStyle(fontSize: 16)),
                ),
              ),
            ),

            // пространство под кнопкой
            const Expanded(child: SizedBox()),
          ],
        ),
      ),
    );
  }
}
// filepath: c:\Users\Farkhad\FlutterProjects\Agro\fieldscan\lib\ui\profile_myprofile_page.dart