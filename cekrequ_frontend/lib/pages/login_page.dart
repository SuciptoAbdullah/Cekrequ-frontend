import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cekrequ_frontend/pages/home_page.dart';
import 'register_page.dart';
import 'package:provider/provider.dart';
import '../auth_provider.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController identifierController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> _login(BuildContext context) async {
    if (identifierController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Isi identifier dan password!")),
      );
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final response = await http.post(
        Uri.parse('https://gilberto-unpercussive-dara.ngrok-free.dev/api/sign-in'),
        headers: {
          'ngrok-skip-browser-warning': 'true',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'identifier': identifierController.text,
          'password': passwordController.text,
        }),
      );

      debugPrint("STATUS: ${response.statusCode}");
      debugPrint("BODY: ${response.body}");

      if (context.mounted) Navigator.pop(context);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        
        var token = data['data']?['token'] ?? data['token'];
        
        Map<String, dynamic> userData = {
          'username': identifierController.text.split('@')[0],
          'email': identifierController.text,
          'name': identifierController.text.split('@')[0],
        };
        
        if (token != null) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('access_token', token);
          await prefs.setString('user_data', jsonEncode(userData));
          
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Login berhasil!"), backgroundColor: Colors.green),
            );
            
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(
                  token: token,
                  userData: userData,
                ),
              ),
            );
          }
        } else {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Token tidak ditemukan!"),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      } else {
        if (context.mounted) {
          try {
            var data = jsonDecode(response.body);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(data['message'] ?? data['massage'] ?? "Login gagal!"),
                backgroundColor: Colors.red,
              ),
            );
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Login gagal!"),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      }
    } catch (e) {
      debugPrint("Error: $e");
      if (context.mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error: ${e.toString()}"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _loginWithGoogle(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      print("===== GOOGLE LOGIN START =====");
      await authProvider.signInWithGoogle();
      print("===== GOOGLE LOGIN SUCCESS =====");
      
      if (context.mounted) Navigator.pop(context);
      
      final user = authProvider.user;
      print("User data: ${user?.email}");
      
      if (user != null) {
        final prefs = await SharedPreferences.getInstance();
        
        Map<String, dynamic> userData = {
          'username': user.displayName ?? user.email?.split('@')[0] ?? 'Google User',
          'email': user.email ?? '',
          'name': user.displayName ?? '',
          'photo_url': user.photoURL ?? '',
          'google_id': user.uid,
        };
        
        String token = 'google_${user.uid}';
        
        await prefs.setString('access_token', token);
        await prefs.setString('user_data', jsonEncode(userData));
        
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Google Login berhasil!"), backgroundColor: Colors.green),
          );
          
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(
                token: token,
                userData: userData,
              ),
            ),
          );
        }
      } else {
        print("===== USER IS NULL =====");
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Gagal mendapatkan data dari Google"),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      print("===== GOOGLE LOGIN ERROR =====");
      print("Error: $e");
      if (context.mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Google Login gagal: ${e.toString()}"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5E5E5),
      body: Center(
        child: Container(
          width: 320,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Login",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: identifierController,
                decoration: const InputDecoration(
                  labelText: "Email / Username",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _login(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("Masuk"),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => _loginWithGoogle(context),
                  icon: Image.network(
                    'https://www.google.com/favicon.ico',
                    height: 20,
                    width: 20,
                  ),
                  label: const Text("Login dengan Google"),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black,
                    side: const BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Belum punya akun? "),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterPage(),
                        ),
                      );
                    },
                    child: const Text("Buat Akun"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}