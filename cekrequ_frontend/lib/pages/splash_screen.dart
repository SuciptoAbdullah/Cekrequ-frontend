import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cekrequ_frontend/pages/login_page.dart';
import 'package:cekrequ_frontend/pages/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () async {
      // Ambil token dan userData dari SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token');
      final userDataString = prefs.getString('user_data');
      
      print("🔍 Token di SplashScreen: $token");
      print("🔍 UserData di SplashScreen: $userDataString");
      
      Map<String, dynamic>? userData;
      if (userDataString != null) {
        userData = jsonDecode(userDataString);
      }
      
      if (context.mounted) {
        if (token != null && token.isNotEmpty && userData != null) {
          // Token dan userData ada, langsung ke HomePage
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(
                token: token,
                userData: userData,
              ),
            ),
          );
        } else {
          // Token atau userData tidak ada, ke LoginPage
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginPage(),
            ),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Gunakan logo dari assets
            Image.asset(
              'assets/logo/logo.png',
              width: 150,
              height: 150,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                // Jika gambar tidak ditemukan, tampilkan icon sebagai fallback
                return const Icon(
                  Icons.photo_camera,
                  size: 80,
                  color: Color(0xFF1EA0E9),
                );
              },
            ),
            const SizedBox(height: 20),
            const Text(
              "FANESYA PHOTO STUDIO",
              style: TextStyle(
                fontSize: 18, 
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 40),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1EA0E9)),
            ),
          ],
        ),
      ),
    );
  }
}