import 'package:flutter/material.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isPasswordVisible = false;
  bool _showWelcomeText = false;

  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Slide animation controller
    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _slideAnimation = Tween<Offset>(begin: const Offset(-1.0, 0.0), end: Offset.zero)
        .animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOut));

    // Scale animation controller
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2)
        .animate(CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut));

    // Memulai animasi slide
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _showWelcomeText = true;
        _slideController.forward();
      });
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _slideController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState?.validate() ?? false) {
      String username = _usernameController.text;
      String password = _passwordController.text;

      if (username == 'admin' && password == 'admin1') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Username atau password salah')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login'),
      backgroundColor: Colors.green.shade300,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(
            'assets/images/hjo.jpg',
            fit: BoxFit.cover,
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Menempatkan di tengah
              children: [
                SlideTransition(
                  position: _slideAnimation,
                  child: AnimatedOpacity(
                    duration: const Duration(seconds: 1),
                    opacity: _showWelcomeText ? 1.0 : 0.0,
                    child: const Text(
                      'Selamat datang di aplikasi Tugasku!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 0, 0), // Ubah warna teks agar kontras dengan hijau
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                SlideTransition(
                  position: _slideAnimation,
                  child: AnimatedOpacity(
                    duration: const Duration(seconds: 1),
                    opacity: _showWelcomeText ? 1.0 : 0.0,
                    child: const Text(
                      'Silahkan login untuk melanjutkan.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 0, 0, 0), // Sesuaikan dengan warna background hijau
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                // Form untuk login
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _usernameController,
                        decoration: const InputDecoration(labelText: 'Username'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Username tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTapDown: (_) => _scaleController.forward(),
                        onTapUp: (_) {
                          _scaleController.reverse();
                          _login();
                        },
                        onTapCancel: () => _scaleController.reverse(),
                        child: ScaleTransition(
                          scale: _scaleAnimation,
                          child: ElevatedButton(
                            onPressed: null, // GestureDetector menangani onTap
                            child: const Text('Login'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
