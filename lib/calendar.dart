import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Importa o Firestore
import 'theme_provider.dart';
import 'package:provider/provider.dart'; // Importa o provider

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  Future<void> _showMenuForDate(BuildContext context, String date) async {
    // Faz uma consulta ao Firestore para obter o cardápio da data
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
        .collection('menu')
        .where('data', isEqualTo: date)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot<Map<String, dynamic>> snapshot = querySnapshot.docs.first;
      // Mostra um diálogo com os dados do cardápio
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Cardápio para $date'),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Text('Salada: ${snapshot['salada']}'),
                  Text('Acompanhamento: ${snapshot['acompanhamento']}'),
                  Text('Guarnição: ${snapshot['guarnicao']}'),
                  Text('Prato Principal: ${snapshot['pratoPrincipal']}'),
                  Text('Vegetariano: ${snapshot['vegetariano']}'),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: const Text('Fechar'),
                onPressed: () {
                  Navigator.of(context).pop(); // Fecha o diálogo
                },
              ),
            ],
          );
        },
      );
    } else {
      // Exibe uma mensagem se não houver cardápio para a data
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Nenhum cardápio cadastrado para $date")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Obtém o estado do tema
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF121212) : const Color(0xFFFFFFFF), // Cor de fundo
      appBar: AppBar(
        backgroundColor: isDarkMode ? const Color(0xFF1E1E1E) : const Color(0xFFFFFFFF), // Cor do fundo do AppBar
        title: const Text('Calendário'), // Título do AppBar
        iconTheme: IconThemeData(color: isDarkMode ? Colors.white : Colors.black), // Ícones
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Outubro', // Nome do mês
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Text('Seg', style: TextStyle(fontSize: 24)),
                Text('Ter', style: TextStyle(fontSize: 24)),
                Text('Qua', style: TextStyle(fontSize: 24)),
                Text('Qui', style: TextStyle(fontSize: 24)),
                Text('Sex', style: TextStyle(fontSize: 24)),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _dayCircleButton(context, 30),
                    _dayCircleButton(context, 1),
                    _dayCircleButton(context, 2),
                    _dayCircleButton(context, 3),
                    _dayCircleButton(context, 4),
                  ],
                ),
                const SizedBox(height: 10), // Espaçamento entre as linhas
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _dayCircleButton(context, 7),
                    _dayCircleButton(context, 8),
                    _dayCircleButton(context, 9),
                    _dayCircleButton(context, 10),
                    _dayCircleButton(context, 11),
                  ],
                ),
                const SizedBox(height: 10), // Espaçamento entre as linhas
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _dayCircleButton(context, 14),
                    _dayCircleButton(context, 15),
                    _dayCircleButton(context, 16),
                    _dayCircleButton(context, 17),
                    _dayCircleButton(context, 18),
                  ],
                ),
                const SizedBox(height: 10), // Espaçamento entre as linhas
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _dayCircleButton(context, 21),
                    _dayCircleButton(context, 22),
                    _dayCircleButton(context, 23),
                    _dayCircleButton(context, 24),
                    _dayCircleButton(context, 25),
                  ],
                ),
                const SizedBox(height: 10), // Espaçamento entre as linhas
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _dayCircleButton(context, 28),
                    _dayCircleButton(context, 29),
                    _dayCircleButton(context, 30),
                    _dayCircleButton(context, 31),
                    _dayCircleButton(context, 1),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _dayCircleButton(BuildContext context, int day) {
    // Obtém o estado do tema
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return GestureDetector(
      onTap: () {
        // Formata a data para ser compatível com o Firestore
        String formattedDate = '05/10'; // Ajuste para a lógica de formatação correta
        if (day < 10) {
          formattedDate = '0$day/10'; // Adiciona o zero à frente se o dia for menor que 10
        } else {
          formattedDate = '$day/10'; // Formato do dia
        }
        _showMenuForDate(context, formattedDate); // Chama o método para mostrar o cardápio
      },
      child: CircleAvatar(
        radius: 30, // Tamanho da bolinha
        backgroundColor: isDarkMode ? const Color(0xFF006400) : const Color(0xFF006400), // Cor de fundo da bolinha
        child: Text(
          '$day', // Número do dia
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.white, // Cor do texto
            fontSize: 20, // Ajuste o tamanho do texto aqui
          ),
        ),
      ),
    );
  }
}
