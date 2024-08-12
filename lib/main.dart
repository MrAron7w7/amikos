import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/core/constants/app_route_view.dart';
import '/shared/theme/app_theme.dart';
import 'features/viewmodels/theme_provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Para que conecte servicios antes de la app
  // Llama a la notificacion para los local notification
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final sharedPreferences =
      await SharedPreferences.getInstance(); // Guarda el tema de la aplicacion

  runApp(ProviderScope(
    overrides: [
      sharedPreferencesProvider.overrideWithValue(sharedPreferences),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: isDarkMode ? AppTheme.darkMode() : AppTheme.lightMode(),
      title: 'Twitter Clone',
      routerConfig: appRoute,
    );
  }
}
