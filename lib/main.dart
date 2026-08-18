import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_tv_app/config/tv_theme.dart';
import 'package:smart_tv_app/providers/tv_provider.dart';
import 'package:smart_tv_app/screens/tv_dashboard_screen.dart';
import 'package:smart_tv_app/screens/tv_pairing_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Aquí debes agregar las credenciales de Firebase cuando hagas la configuración manual (google-services.json)
  await Firebase.initializeApp();

  final tvProvider = TvProvider();
  await tvProvider.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: tvProvider),
      ],
      child: const SmartTvApp(),
    ),
  );
}

class SmartTvApp extends StatelessWidget {
  const SmartTvApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VitalHabit TV',
      debugShowCheckedModeBanner: false,
      theme: TvTheme.darkTheme,
      home: const TvRootRouter(),
    );
  }
}

class TvRootRouter extends StatelessWidget {
  const TvRootRouter({super.key});

  @override
  Widget build(BuildContext context) {
    final tvProvider = context.watch<TvProvider>();

    if (tvProvider.isPaired) {
      return const TvDashboardScreen();
    }

    return const TvPairingScreen();
  }
}
