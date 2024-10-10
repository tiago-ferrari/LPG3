import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Importa o Firebase Auth
import 'signup.dart'; // Importe a tela de cadastro
import 'menu_registration_screen.dart'; // Importe a tela de registro de menu
import 'theme_provider.dart';
import 'package:provider/provider.dart'; // Importa o Provider para acessar o ThemeProvider

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false; // Estado de carregamento

  Future<void> _login() async {
    setState(() {
      _isLoading = true; // Inicia o carregamento
    });

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Se o login for bem-sucedido, navegue para outra tela
      print("Usuário logado: ${userCredential.user?.email}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login realizado com sucesso!")),
      );

      // Navegar para a tela de cadastro do cardápio
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MenuRegistrationScreen()), // Navegue para a tela correta
      );
    } catch (e) {
      print("Erro ao fazer login: $e");
      // Exibir uma mensagem de erro se o login falhar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao fazer login: ${e.toString()}")),
      );
    } finally {
      setState(() {
        _isLoading = false; // Finaliza o carregamento
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Acesse o ThemeProvider para obter o estado do Dark Mode
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: themeProvider.isDarkMode ? const Color(0xFF121212) : const Color(0xFFFFFFFF), // Cor de fundo
      appBar: AppBar(
        backgroundColor: themeProvider.isDarkMode ? const Color(0xFF1F1F1F) : const Color(0xFF006400),
        title: const Text(
          'Login de Funcionários',
          style: TextStyle(
            color: Colors.white, // Cor do texto da AppBar
          ),
        ),
        centerTitle: true, // Centraliza o título
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _emailController, // Controlador para o e-mail
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(
                    color: themeProvider.isDarkMode ? Colors.white54 : Colors.black54,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: themeProvider.isDarkMode ? Colors.white : Colors.black),
                  ),
                ),
                style: TextStyle(color: themeProvider.isDarkMode ? Colors.white : Colors.black), // Cor do texto
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController, // Controlador para a senha
                decoration: InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(
                    color: themeProvider.isDarkMode ? Colors.white54 : Colors.black54,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: themeProvider.isDarkMode ? Colors.white : Colors.black),
                  ),
                ),
                obscureText: true, // Oculta o texto da senha
                style: TextStyle(color: themeProvider.isDarkMode ? Colors.white : Colors.black), // Cor do texto
              ),
              const SizedBox(height: 16),
              _isLoading // Exibe o indicador de carregamento se necessário
                  ? CircularProgressIndicator() // Indicador de carregamento
                  : ElevatedButton(
                onPressed: _login, // Chama a função de login
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF006400), // Cor de fundo do botão
                  foregroundColor: Colors.white, // Cor do texto do botão
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15), // Ajuste o tamanho do botão
                ),
                child: const Text(
                  'Entrar',
                  style: TextStyle(
                    fontSize: 20, // Tamanho do texto
                  ),
                ),
              ),
              const SizedBox(height: 16), // Espaçamento entre o botão e o texto
              TextButton(
                onPressed: () {
                  // Navegar para a tela de cadastro
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const SignupScreen()),
                  );
                },
                child: const Text(
                  'Cadastre-se',
                  style: TextStyle(color: Colors.blue), // Cor do texto
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
