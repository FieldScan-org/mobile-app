import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';


/// Небольшой компонент с анимацией нажатия + ripple (InkWell).
class PressableListTile extends StatefulWidget {
  final Widget? leading;
  final Widget? title;
  final Widget? trailing;
  final VoidCallback? onTap;
  final BorderRadius? borderRadius;

  const PressableListTile({
    super.key,
    this.leading,
    this.title,
    this.trailing,
    this.onTap,
    this.borderRadius,
  });

  @override
  State<PressableListTile> createState() => _PressableListTileState();
}

class _PressableListTileState extends State<PressableListTile> {
  bool _pressed = false;

  void _setPressed(bool v) {
    if (mounted) setState(() => _pressed = v);
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 1.0, end: _pressed ? 0.986 : 1.0),
      duration: const Duration(milliseconds: 140),
      curve: Curves.easeOut,
      builder: (context, scale, child) {
        return Transform.scale(
          scale: scale,
          child: child,
        );
      },
      child: Material(
        color: Colors.transparent,
        borderRadius: widget.borderRadius,
        clipBehavior: Clip.hardEdge, // <-- важное изменение: обрезаем ripple по радиусу
        child: InkWell(
          borderRadius: widget.borderRadius ?? BorderRadius.circular(0),
          onTap: widget.onTap,
          onTapDown: (_) => _setPressed(true),
          onTapCancel: () => _setPressed(false),
          onTapUp: (_) => _setPressed(false),
          splashColor: Colors.black.withOpacity(0.06),
          highlightColor: Colors.transparent,
          child: ListTile(
            leading: widget.leading,
            title: widget.title,
            trailing: widget.trailing,
            contentPadding: const EdgeInsets.symmetric(horizontal: 8),
          ),
        ),
      ),
    );
  }
}

class ProfileLoginPage extends StatelessWidget {
  const ProfileLoginPage({super.key});

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
            const SizedBox(height: 28),

            // Логотип сверху
            Center(
              child: SvgPicture.asset(
                'assets/icons/logo.svg',
                width: 90,
                height: 105,
                color: const Color(0xFF2FAE4A),
              ),
            ),

            const SizedBox(height: 20),

            // Карточка с опциями (как на скриншоте)
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
                    // Заголовок карточки
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                      child: const Text(
                        'Аккаунт',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),

                    // "Мой аккаунт" с анимацией нажатия
                    PressableListTile(
                      // верхняя плитка — без скругления (header/карточка уже скруглена)
                      borderRadius: BorderRadius.zero,
                      leading: CircleAvatar(
                        backgroundColor: const Color(0xFF2FAE4A),
                        child: const Icon(Icons.person, color: Colors.white, size: 20),
                      ),
                      title: const Text('Мой аккаунт'),
                      trailing: const Icon(Icons.chevron_right, color: Color.fromRGBO(142, 142, 147, 1)),
                      onTap: () {
                        // TODO: открыть страницу профиля
                      },
                    ),

                    const Divider(
                      color: Color.fromRGBO(223, 223, 223, 1),
                      indent: 8,
                      height: 1,
                    ),

                    // "Настройки" с анимацией нажатия
                    PressableListTile(
                      // нижняя плитка — скруглённые нижние углы, чтобы ripple не выходил за карточку
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                      leading: CircleAvatar(
                        backgroundColor: const Color(0xFF2FAE4A),
                        child: Transform.rotate(
                          angle: 0,
                          child: const Icon(Icons.tune, color: Colors.white, size: 20),
                        ),
                      ),
                      title: const Text('Настройки'),
                      trailing: const Icon(Icons.chevron_right, color: Color.fromRGBO(142, 142, 147, 1)),
                      onTap: () {
                        // TODO: открыть настройки
                      },
                    ),
                  ],
                ),
              ),
            ),

            // Доп. отступ, пространство под карточкой
            const SizedBox(height: 24),

            // Здесь можно добавить дополнительные элементы страницы (если нужно)
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }
}