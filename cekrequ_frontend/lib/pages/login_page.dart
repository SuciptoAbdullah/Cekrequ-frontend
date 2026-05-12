import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';  
import 'package:cekrequ_frontend/pages/home_page.dart';
import 'register_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController identifierController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> _login(BuildContext context) async {
    // Validasi input
    if (identifierController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Isi identifier dan password!")),
      );
      return;
    }

    // Tampilkan loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      // Panggil API login
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

      print("STATUS: ${response.statusCode}");
      print("BODY: ${response.body}");

      // Tutup loading
      if (context.mounted) Navigator.pop(context);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        
        print("🔍 FULL RESPONSE: $data");
        
        // Ambil token
        var token = data['data']['token'];
        
        // 🔥 BUAT DATA USER DARI INPUTAN LOGIN
        // Karena response tidak mengirimkan data user, kita buat sendiri
        Map<String, dynamic> userData = {
          'username': identifierController.text.split('@')[0], // Ambil nama sebelum @ jika email
          'email': identifierController.text,
          'name': identifierController.text.split('@')[0],
        };
        
        print("✅ User data yang akan disimpan: $userData");
        
        if (token != null) {
          // Simpan token dan user data
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('access_token', token);
          await prefs.setString('user_data', jsonEncode(userData));
          
          print("✅ Token tersimpan: $token");
          print("✅ User data tersimpan: $userData");
          
          // Tampilkan pesan sukses
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Login berhasil!"), backgroundColor: Colors.green),
            );
            
            // Pindah ke halaman Home dengan membawa user data
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(
                  token: token,
                  userData: userData, // Kirim user data
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
        // Login gagal
        try {
          var data = jsonDecode(response.body);
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(data['massage'] ?? data['message'] ?? "Login gagal!"),
                backgroundColor: Colors.red,
              ),
            );
          }
        } catch (e) {
          if (context.mounted) {
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
      print("Error: $e");
      if (context.mounted) Navigator.pop(context);
      
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error: ${e.toString()}"),
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
              const Text("Login",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
                  child: const Text("Masuk"),
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
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}