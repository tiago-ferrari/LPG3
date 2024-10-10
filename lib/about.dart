import 'package:flutter/material.dart';
import 'theme_provider.dart';


class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' '),
        backgroundColor: const Color(0xFF006400), // Cor do AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Espaçamento
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Sobre o Aplicativo',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16), // Espaçamento
            const Text(
              'Implementar: Dark Mode, Alterar Logo, Campo de foto, Icone do App',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16), // Espaçamento
            const Text(
              'Versão: cardapio 1.5',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16), // Espaçamento
            const Text(
              'Desenvolvido por Tiago',
              style: TextStyle(fontSize: 16),
            ),
            const Spacer(), // Para empurrar o conteúdo para cima
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Voltar à tela anterior
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF006400), // Cor do botão
                  foregroundColor: Colors.white, // Cor do texto do botão
                ),
                child: const Text('Voltar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
