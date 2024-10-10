import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart'; // Importa o Firebase
import 'theme_provider.dart';
import 'splash_screen.dart'; // Importa a SplashScreen

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Garante que o Flutter esteja inicializado
  await Firebase.initializeApp(); // Inicializa o Firebase

  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Cardápio App',
      theme: themeProvider.themeData,
      home: const SplashScreen(), // Altera aqui para exibir a SplashScreen
    );
  }
}
