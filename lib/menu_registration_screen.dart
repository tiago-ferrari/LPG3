import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Importa o Firestore
import 'theme_provider.dart';


class MenuRegistrationScreen extends StatefulWidget {
  const MenuRegistrationScreen({Key? key}) : super(key: key);

  @override
  _MenuRegistrationScreenState createState() => _MenuRegistrationScreenState();
}

class _MenuRegistrationScreenState extends State<MenuRegistrationScreen> {
  final TextEditingController _dataController = TextEditingController();
  final TextEditingController _saladaController = TextEditingController();
  final TextEditingController _acompanhamentoController = TextEditingController();
  final TextEditingController _guarnicaoController = TextEditingController();
  final TextEditingController _pratoPrincipalController = TextEditingController();
  final TextEditingController _vegetarianoController = TextEditingController();

  Future<void> _registerMenu() async {
    // Coleta os dados do formulário
    String data = _dataController.text;
    String salada = _saladaController.text;
    String acompanhamento = _acompanhamentoController.text;
    String guarnicao = _guarnicaoController.text;
    String pratoPrincipal = _pratoPrincipalController.text;
    String vegetariano = _vegetarianoController.text;

    // Verifica se todos os campos estão preenchidos
    if (data.isEmpty || salada.isEmpty || acompanhamento.isEmpty ||
        guarnicao.isEmpty || pratoPrincipal.isEmpty || vegetariano.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Por favor, preencha todos os campos.")),
      );
      return;
    }

    // Cria um novo documento na coleção 'menu'
    await FirebaseFirestore.instance.collection('menu').add({
      'data': data,
      'salada': salada,
      'acompanhamento': acompanhamento,
      'guarnicao': guarnicao,
      'pratoPrincipal': pratoPrincipal,
      'vegetariano': vegetariano,
    });

    // Exibe uma mensagem de sucesso
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Cardápio cadastrado com sucesso!")),
    );

    // Limpa os campos do formulário
    _dataController.clear();
    _saladaController.clear();
    _acompanhamentoController.clear();
    _guarnicaoController.clear();
    _pratoPrincipalController.clear();
    _vegetarianoController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF006400),
        title: const Text('Cadastro de Cardápio'),
        centerTitle: true,
      ),
      body: SingleChildScrollView( // Adiciona rolagem ao conteúdo
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _dataController,
              decoration: const InputDecoration(
                labelText: 'Data',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _saladaController,
              decoration: const InputDecoration(
                labelText: 'Salada',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _acompanhamentoController,
              decoration: const InputDecoration(
                labelText: 'Acompanhamento',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _guarnicaoController,
              decoration: const InputDecoration(
                labelText: 'Guarnição',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _pratoPrincipalController,
              decoration: const InputDecoration(
                labelText: 'Prato Principal',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _vegetarianoController,
              decoration: const InputDecoration(
                labelText: 'Vegetariano',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _registerMenu,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF006400),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: const Text('Cadastrar Cardápio'),
            ),
          ],
        ),
      ),
    );
  }
}
