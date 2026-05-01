import 'package:flutter/material.dart';

import 'views/splash_screen_view.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Cekrequ",
      theme: ThemeData(primaryColor: Colors.pink[200]),
      home: SplashScreenView(),
    );
  }
}