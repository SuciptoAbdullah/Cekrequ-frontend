import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cekrequ_frontend/pages/login_page.dart';
import 'package:cekrequ_frontend/pages/home_page.dart'; // 🔥 Import HomePage

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () async { // 🔥 Tambah async
      // 🔥 Ambil token dari SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token');
      
      print("🔍 Token di SplashScreen: $token");
      
      if (context.mounted) {
        if (token != null && token.isNotEmpty) {
          // Token ada, langsung ke HomePage
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(token: token), // 🔥 Kirim token
            ),
          );
        } else {
          // Token tidak ada, ke LoginPage
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>  LoginPage(),
            ),
          );
        }
      }
    }); // 🔥 Tutup Timer dengan benar
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/image/Logo.jpeg', width: 150),
            const SizedBox(height: 20),
            const Text(
              "FANESYA PHOTO STUDIO",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}