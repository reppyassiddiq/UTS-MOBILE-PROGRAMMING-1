import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  final ValueNotifier<bool> _isDarkMode = ValueNotifier(false);
  late AnimationController _avatarController;
  late Animation<double> _avatarAnimation;

  @override
  void initState() {
    super.initState();

    // Animasi untuk avatar
    _avatarController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _avatarAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _avatarController,
      curve: Curves.elasticOut,
    ));

    // Memulai animasi avatar saat halaman dimuat
    _avatarController.forward();
  }

  void _toggleDarkMode() {
    _isDarkMode.value = !_isDarkMode.value;
  }

  void _logout(BuildContext context) {
    // Navigasi kembali ke halaman login
    Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
  }

  @override
  void dispose() {
    _avatarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _isDarkMode,
      builder: (context, isDarkMode, child) {
        return MaterialApp(
          theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
          home: Scaffold(
            appBar: AppBar(
              title: const Text('Profil Pengguna'),
              backgroundColor: Colors.green.shade300,
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Hero animation untuk avatar
                  ScaleTransition(
                    scale: _avatarAnimation,
                    child: Hero(
                      tag: 'profile-avatar',
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.green.shade300,
                        child: const Icon(Icons.person, size: 50),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text('Admin', style: TextStyle(fontSize: 18)),
                  const SizedBox(height: 20),
                  // AnimatedSwitcher untuk mengganti tema
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (Widget child, Animation<double> animation) {
                      return ScaleTransition(scale: animation, child: child);
                    },
                    child: ElevatedButton(
                      key: ValueKey<bool>(isDarkMode),
                      onPressed: _toggleDarkMode,
                      child: Text(isDarkMode ? 'Tema Terang' : 'Tema Gelap'),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => _logout(context),
                    child: const Text('Keluar'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
