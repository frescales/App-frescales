import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Asegúrate de importar esto
import 'package:frescales_app/models/enfermedad.dart';
import 'package:frescales_app/screens/actividades/actividades_form_screen.dart';
import 'package:frescales_app/screens/enfermedades/enfermedades_form_screen.dart';
import 'package:frescales_app/screens/insumos/insumos_form_screen.dart';
import 'package:frescales_app/screens/labores/labores_form_screen.dart';
import 'package:frescales_app/screens/login_screen.dart';
import 'package:frescales_app/screens/main_menu_screen.dart';
import 'package:frescales_app/screens/produccion/produccion_form_screen.dart';
import 'package:frescales_app/screens/produccion/produccion_list_screen.dart';
import 'package:frescales_app/screens/insumos/insumos_list_screen.dart';
import 'package:frescales_app/screens/labores/labores_list_screen.dart';
import 'package:frescales_app/screens/enfermedades/enfermedades_list_screen.dart';
import 'package:frescales_app/screens/actividades/actividades_list_screen.dart';
import 'package:frescales_app/screens/catalogos/unidades_screen.dart';
import 'package:frescales_app/utils/theme.dart';
import 'supabase_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseConfig.initialize();

  runApp(
    /// 🔥 Aquí está la clave
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Frescales App',
      theme: appTheme,
      home: const LoginScreen(),
      routes: {
        '/main': (_) => const MainMenuScreen(),
        '/produccion': (_) => const ProduccionListScreen(),
        '/insumos': (_) => const InsumosListScreen(),
        '/labores': (_) => const LaboresListScreen(),
        '/enfermedades': (_) => const EnfermedadesListScreen(),
        '/actividades': (_) => const ActividadesListScreen(),
        '/catalogos': (_) => const UnidadesScreen(),
        '/produccion_form': (_) => const ProduccionFormScreen(),
        '/insumos_form': (_) => const InsumosFormScreen(),
        '/labores_form': (_) => const LaboresFormScreen(),
        '/enfermedades_form': (_) => const EnfermedadesFormScreen(),
        '/actividades_form': (_) => const ActividadesFormScreen(),

      },
    );
  }
}
