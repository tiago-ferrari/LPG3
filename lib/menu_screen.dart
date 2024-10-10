import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Importar o Firestore
import 'package:intl/intl.dart'; // Para formatação de datas
import 'calendar.dart'; // Importar a nova tela
import 'theme_provider.dart';
import 'package:provider/provider.dart'; // Importa o Provider

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> days = []; // Lista de datas da semana
  Map<String, Map<String, dynamic>> menus = {}; // Mapa para armazenar menus

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _initializeDays();
    _fetchMenus(); // Buscar menus no início
  }

  void _initializeDays() {
    DateTime now = DateTime.now();
    days.add(DateFormat('dd/MM').format(now.subtract(Duration(days: now.weekday - 1)))); // Seg
    days.add(DateFormat('dd/MM').format(now.subtract(Duration(days: now.weekday - 2)))); // Ter
    days.add(DateFormat('dd/MM').format(now.subtract(Duration(days: now.weekday - 3)))); // Qua
    days.add(DateFormat('dd/MM').format(now)); // Qui (hoje)
    days.add(DateFormat('dd/MM').format(now.add(Duration(days: 1)))); // Sex
  }

  Future<void> _fetchMenus() async {
    for (String date in days) {
      Map<String, dynamic> menu = await _getMenuForDate(date);
      menus[date] = menu; // Armazenar o menu em um mapa
    }
    setState(() {}); // Atualizar a UI após buscar os menus
  }

  Future<Map<String, dynamic>> _getMenuForDate(String date) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('menu')
        .where('data', isEqualTo: date)
        .get();

    if (snapshot.docs.isNotEmpty) {
      // Retornar os dados do cardápio
      return {
        'salada': snapshot.docs.first['salada'] ?? "N/A",
        'guarnicao': snapshot.docs.first['guarnicao'] ?? "N/A",
        'pratoPrincipal': snapshot.docs.first['pratoPrincipal'] ?? "N/A",
        'vegetariano': snapshot.docs.first['vegetariano'] ?? "N/A",
        'acompanhamento': snapshot.docs.first['acompanhamento'] ?? "N/A", // Adicionando acompanhamento
      };
    } else {
      // Retornar mensagem caso não exista
      return {
        'salada': "Cardápio não cadastrado",
        'guarnicao': "Cardápio não cadastrado",
        'pratoPrincipal': "Cardápio não cadastrado",
        'vegetariano': "Cardápio não cadastrado",
        'acompanhamento': "Cardápio não cadastrado", // Mensagem para acompanhamento
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context); // Obter o ThemeProvider

    return DefaultTabController(
      length: 5, // Número de abas (Seg, Ter, Qua, Qui, Sex)
      child: Scaffold(
        backgroundColor: themeProvider.isDarkMode ? const Color(0xFF121212) : const Color(0xFFFFFFFF), // Cor de fundo com base no tema
        appBar: AppBar(
          backgroundColor: themeProvider.isDarkMode ? const Color(0xFF1A1A1A) : const Color(0xFF006400), // Cor do fundo do AppBar
          title: const Text(' '), // Título do AppBar
        ),
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(11.0),
              child: Text(
                'Cardápio da Semana', // Título do cardápio
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
            ),
            const Divider( // Linha divisória no início
              color: Color(0xFF77D1FF), // Cor da linha
              thickness: 3, // Espessura da linha
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: List.generate(5, (index) {
                  String currentDate = days[index]; // Data atual da aba
                  Map<String, dynamic>? currentMenu = menus[currentDate]; // Menu atual

                  return ListView(
                    padding: const EdgeInsets.all(16.0),
                    children: [
                      ExpansionTile(
                        leading: const Icon(Icons.eco), // Ícone para salada
                        title: const Text('Salada'),
                        children: [
                          Text(currentMenu?['salada'] ?? "Cardápio não cadastrado", style: TextStyle(color: themeProvider.isDarkMode ? Colors.white : Colors.black)),
                        ],
                      ),
                      ExpansionTile(
                        leading: const Icon(Icons.fastfood), // Ícone para guarnição
                        title: const Text('Guarnição'),
                        children: [
                          Text(currentMenu?['guarnicao'] ?? "Cardápio não cadastrado", style: TextStyle(color: themeProvider.isDarkMode ? Colors.white : Colors.black)),
                        ],
                      ),
                      ExpansionTile(
                        leading: const Icon(Icons.restaurant_menu), // Ícone para prato principal
                        title: const Text('Prato Principal'),
                        children: [
                          Text(currentMenu?['pratoPrincipal'] ?? "Cardápio não cadastrado", style: TextStyle(color: themeProvider.isDarkMode ? Colors.white : Colors.black)),
                        ],
                      ),
                      ExpansionTile(
                        leading: const Icon(Icons.favorite), // Ícone para vegetariano
                        title: const Text('Vegetariano'),
                        children: [
                          Text(currentMenu?['vegetariano'] ?? "Cardápio não cadastrado", style: TextStyle(color: themeProvider.isDarkMode ? Colors.white : Colors.black)),
                        ],
                      ),
                      ExpansionTile(
                        leading: const Icon(Icons.cake), // Ícone para acompanhamento
                        title: const Text('Acompanhamento'),
                        children: [
                          Text(currentMenu?['acompanhamento'] ?? "Cardápio não cadastrado", style: TextStyle(color: themeProvider.isDarkMode ? Colors.white : Colors.black)),
                        ],
                      ),
                    ],
                  );
                }),
              ),
            ),
            Container(
              child: TabBar(
                controller: _tabController,
                labelColor: themeProvider.isDarkMode ? Colors.white : Colors.black, // Cor do texto das abas
                indicatorColor: const Color(0xFF77D1FF), // Cor do indicador da aba selecionada
                tabs: const [
                  Tab(text: 'Seg'),
                  Tab(text: 'Ter'),
                  Tab(text: 'Qua'),
                  Tab(text: 'Qui'),
                  Tab(text: 'Sex'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CalendarScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF006400), // Cor do fundo do botão
                  foregroundColor: Colors.white, // Cor do texto do botão
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: const Text('Ver outros dias'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose(); // Destruir o controlador da aba
    super.dispose();
  }
}
