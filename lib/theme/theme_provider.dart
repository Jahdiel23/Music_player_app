import 'package:flutter/material.dart';
import 'package:music_player_dreamteam/theme/dark_mode.dart';
import 'package:music_player_dreamteam/theme/light_mode.dart';

class ThemeProvider extends ChangeNotifier {
  // Inicialmente, modo claro
  ThemeData _themeData = lightMode;

  // Getter para obtener el tema actual
  ThemeData get themeData => _themeData;

  // Verificar si el modo oscuro está activado
  bool get isDarkMode => _themeData == darkMode;

  // Setear un nuevo tema
  set themeData(ThemeData themeData) {
    _themeData = themeData;
    // Notificar a los oyentes (UI) para que se actualicen
    notifyListeners();
  }

  // Método para alternar entre tema claro y oscuro
  void toggleTheme() {
    if (_themeData == lightMode) {
      _themeData = darkMode;
    } else {
      _themeData = lightMode;
    }
    // Notificar a los oyentes después de cambiar el tema
    notifyListeners();
  }
}
