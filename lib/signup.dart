import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Importa o Firestore
import 'theme_provider.dart';
import 'package:provider/provider.dart'; // Importa o Provider

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Obter o ThemeProvider para verificar se está no modo escuro
    final themeProvider = Provider.of<ThemeProvider>(context);
    final Color backgroundColor = themeProvider.isDarkMode ? Colors.black : Colors.white;
    final Color textColor = themeProvider.isDarkMode ? Colors.white : Colors.black;
    final Color buttonColor = const Color(0xFF006400);
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    final FirebaseAuth _auth = FirebaseAuth.instance;

    Future<void> _signUp() async {
      try {
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        if (userCredential.user != null) {
          print("Usuário criado com sucesso: ${userCredential.user?.email}");

          // Adiciona informações adicionais no Firestore
          await FirebaseFirestore.instance.collection('usuarios').doc(userCredential.user!.uid).set({
            'nome': _nameController.text,
            'email': userCredential.user!.email,
          });
          print("Dados do usuário salvos no Firestore.");

          // Exibir uma mensagem de sucesso
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Cadastro realizado com sucesso!")),
          );

          // Navegar para a tela de login ou outra tela, se necessário
          // Adicione aqui a lógica para navegar após o cadastro, se desejado
        }
      } catch (e) {
        print("Erro ao cadastrar: $e");
        // Exibir uma mensagem de erro se o cadastro falhar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erro ao cadastrar: ${e.toString()}")),
        );
      }
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: buttonColor,
        title: Text(
          'Cadastro de Funcionários',
          style: TextStyle(
            color: textColor,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Nome',
                  border: const OutlineInputBorder(),
                  labelStyle: TextStyle(color: textColor), // Cor do texto do rótulo
                ),
                style: TextStyle(color: textColor), // Cor do texto do campo
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  border: const OutlineInputBorder(),
                  labelStyle: TextStyle(color: textColor), // Cor do texto do rótulo
                ),
                style: TextStyle(color: textColor), // Cor do texto do campo
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  border: const OutlineInputBorder(),
                  labelStyle: TextStyle(color: textColor), // Cor do texto do rótulo
                ),
                obscureText: true,
                style: TextStyle(color: textColor), // Cor do texto do campo
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  if (_passwordController.text.length < 6) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: const Text("A senha deve ter pelo menos 6 caracteres")),
                    );
                    return; // Interrompe a execução se a senha for fraca
                  }
                  await _signUp(); // Chame a função de cadastro
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: const Text(
                  'Cadastrar',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
