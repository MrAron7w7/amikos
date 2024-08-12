import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Provider para SharedPreferences
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

// Provider para el tema
final themeProvider = StateNotifierProvider<ThemeNotifier, bool>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return ThemeNotifier(prefs);
});

class ThemeNotifier extends StateNotifier<bool> {
  static const _darkModeKey = 'isDarkMode';
  final SharedPreferences _prefs;

  ThemeNotifier(this._prefs) : super(_prefs.getBool(_darkModeKey) ?? false) {
    _loadTheme();
  }

  void _loadTheme() {
    state = _prefs.getBool('isDarkMode') ?? false;
  }

  Future<void> toggleTheme() async {
    state = !state;
    await _prefs.setBool(_darkModeKey, state);
  }
}
