import 'dart:async';
import 'package:flutter/material.dart';
import 'home_screen.dart'; 


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), _loadHomeScreen); // Chama após 3 segundos
  }

  void _loadHomeScreen() {
    // Navega para a tela principal do aplicativo
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const HomeScreen()), // Nova rota
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF006400), // Cor de fundo da SplashScreen
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/dtudo_logo.png',
              height: 200, // Ajuste a altura conforme necessário
            ),
            const SizedBox(height: 20),
            const Text(
              ' ',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
