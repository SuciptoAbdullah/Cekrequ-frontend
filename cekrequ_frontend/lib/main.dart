import 'package:flutter/material.dart';
import 'models/paket.dart';
import 'pages/home_page.dart';
//import 'paket.dart'; // arah ke file paket.dart

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
      home: HomePage(), // panggil halaman paket
    );
  }
}