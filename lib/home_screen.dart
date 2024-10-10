import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'menu_screen.dart'; // Certifique-se de importar a nova tela
import 'login.dart'; // Importe a tela de login
import 'about.dart'; // Importe a tela sobre (que será criada depois)
import 'theme_provider.dart'; // Importe seu ThemeProvider


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: themeProvider.isDarkMode
          ? Colors.black
          : const Color(0xFFFFFFFF), // Ajusta o fundo de acordo com o tema
      appBar: AppBar(
        backgroundColor: themeProvider.isDarkMode
            ? Colors.grey[900]
            : const Color(0xFF006400), // Ajusta a cor do AppBar de acordo com o tema
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'sobre') {
                // Navegar para a tela Sobre
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const AboutScreen()),
                );
              } else if (value == 'modo_escuro') {
                // Alternar entre claro e escuro
                themeProvider.toggleTheme();
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<String>(
                  value: 'sobre',
                  child: Text('Sobre'),
                ),
                PopupMenuItem<String>(
                  value: 'modo_escuro',
                  child: Text(
                    themeProvider.isDarkMode ? 'Modo Claro' : 'Modo Escuro',
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navegar para a tela do cardápio
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const MenuScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: themeProvider.isDarkMode
                    ? Colors.grey[800]
                    : const Color(0xFF006400), // Ajusta a cor de fundo do botão
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                textStyle: const TextStyle(fontSize: 20),
              ),
              child: const Text('Ver Cardápio'),
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                // Navegar para a tela de login de funcionários
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: themeProvider.isDarkMode
                    ? Colors.grey[800]
                    : const Color(0xFF006400), // Ajusta a cor de fundo do botão
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                textStyle: const TextStyle(fontSize: 16),
              ),
              child: const Text('Login de Funcionarios'),
            ),
          ],
        ),
      ),
    );
  }
}
