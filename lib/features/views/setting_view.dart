import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/shared/components/components.dart';
import '../viewmodels/theme_provider.dart';

/*
  Vista de configuracion

  - DarkMode
  - Bloquear usuario
  - Configuracion de cuenta 
*/

class SettingView extends ConsumerWidget {
  const SettingView({super.key});

  static const name = 'setting_view';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeProvider);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text('A J U S T E S'),
        foregroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Column(
        children: [
          // DarkMode
          CustomSwitchListtile(
            title: 'Dark Mode',
            value: isDarkMode,
            onChanged: (value) =>
                ref.read(themeProvider.notifier).toggleTheme(),
          )

          // Bloquear usuario

          // Configuracion de cuenta
        ],
      ),
    );
  }
}
