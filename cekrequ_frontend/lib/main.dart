import 'package:flutter/material.dart';
import 'package:cekrequ_frontend/pages/splash_screen.dart'; // 🔥 Import SplashScreen
// import 'models/paket.dart'; // Tidak perlu di sini

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cekreup App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(), // 🔥 Gunakan SplashScreen sebagai halaman awal
    );
  }
}