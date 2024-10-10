import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners(); // Notifica os ouvintes para reconstruir a interface
  }

  ThemeData get themeData {
    return _isDarkMode
        ? ThemeData.dark().copyWith(
      colorScheme: ColorScheme.dark(),
    )
        : ThemeData.light().copyWith(
      colorScheme: ColorScheme.light(),
    );
  }
}
