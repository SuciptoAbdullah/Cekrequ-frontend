import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  int step = 1;
  bool isLoading = false;  // 🔥 TAMBAHKAN untuk loading state

  final username = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  // 🔥 TAMBAHKAN FUNGSI REGISTER
  Future<void> _register() async {
    // Validasi password match
    if (password.text != confirmPassword.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password dan konfirmasi password tidak cocok'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse('https://gilberto-unpercussive-dara.ngrok-free.dev/api/sign-up'),
        headers: {
          'ngrok-skip-browser-warning': 'true',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'username': username.text.trim(),
          'email': email.text.trim(),
          'password': password.text.trim(),
          'password-confirm': confirmPassword.text.trim(),
        }),
      );

      print("Register Status: ${response.statusCode}");
      print("Register Response: ${response.body}");

      if (mounted) {
        if (response.statusCode == 200 || response.statusCode == 201) {
          // Sukses register
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('✅ Registrasi berhasil! Silakan login.'),
              backgroundColor: Colors.green,
            ),
          );
                          Navigator.pop(context); // Kembali ke halaman login
        } else {
          // Gagal register
          final data = jsonDecode(response.body);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(data['message'] ?? 'Registrasi gagal'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
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
          child: step == 1 ? stepOne() : stepTwo(),
        ),
      ),
    );
  }

  // STEP 1
  Widget stepOne() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text("Buat Akun",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),

        const SizedBox(height: 20),

        TextField(
          controller: username,
          decoration: const InputDecoration(
            labelText: "Username",
            border: OutlineInputBorder(),
          ),
        ),

        const SizedBox(height: 10),

        TextField(
          controller: email,
          decoration: const InputDecoration(
            labelText: "Email",
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.emailAddress,
        ),

        const SizedBox(height: 20),

        Row(
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("← Kembali"),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                // Validasi step 1
                if (username.text.isEmpty || email.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Username dan email harus diisi'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }
                setState(() {
                  step = 2;
                });
              },
              child: const Text("Lanjut →"),
            )
          ],
        )
      ],
    );
  }

  // STEP 2
  Widget stepTwo() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text("Buat Akun",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),

        const SizedBox(height: 20),

        TextField(
          controller: password,
          obscureText: true,
          decoration: const InputDecoration(
            labelText: "Password",
            border: OutlineInputBorder(),
          ),
        ),

        const SizedBox(height: 10),

        TextField(
          controller: confirmPassword,
          obscureText: true,
          decoration: const InputDecoration(
            labelText: "Konfirmasi Password",
            border: OutlineInputBorder(),
          ),
        ),

        const SizedBox(height: 20),

        if (isLoading)
          const Center(child: CircularProgressIndicator())
        else
          Row(
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    step = 1;
                  });
                },
                child: const Text("← Kembali"),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: _register, 
                child: const Text("Buat"),
              )
            ],
          )
      ],
    );
  }

  @override
  void dispose() {
    username.dispose();
    email.dispose();
    password.dispose();
    confirmPassword.dispose();
    super.dispose();
  }
}