// Mengimpor paket dasar Flutter
import 'package:flutter/material.dart';

// Mengimpor seluruh layar aplikasi
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home_screen.dart';
import 'screens/info_poli_screen.dart';
import 'screens/info_bed_screen.dart';
import 'screens/igd_screen.dart';
import 'screens/tentang_kami_screen.dart';
import 'screens/transaksi_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rumah Sehat Mobile',
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const HomeScreen(),
        '/info-poli': (context) => const InfoPoliScreen(),
        '/info-bed': (context) => const InfoBedScreen(),
        '/igd': (context) => const IgdScreen(),
        '/tentang-kami': (context) => const TentangKamiScreen(),
        '/transaksi': (context) => const TransaksiScreen(),
      },
    );
  }
}
