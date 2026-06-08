import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  User? _user;
  User? get user => _user;

  bool _initialized = false;

  AuthProvider() {
    _auth.authStateChanges().listen((User? newUser) {
      _user = newUser;
      if (newUser != null) {
        // Simpan session saat login
        _saveUserSession(newUser);
      } else {
        // Hapus session saat logout
        _clearUserSession();
      }
      notifyListeners();
    });
    _initGoogleSignIn();
  }

  Future<void> _saveUserSession(User user) async {
    final prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> userData = {
      'username': user.displayName ?? user.email?.split('@')[0] ?? 'User',
      'email': user.email ?? '',
      'name': user.displayName ?? '',
      'photo_url': user.photoURL ?? '',
      'google_id': user.uid,
    };
    String token = 'google_${user.uid}';
    
    await prefs.setString('access_token', token);
    await prefs.setString('user_data', jsonEncode(userData));
  }

  Future<void> _clearUserSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    await prefs.remove('user_data');
  }

  Future<void> _initGoogleSignIn() async {
    if (_initialized) return;
    _initialized = true;
    await _googleSignIn.initialize();
    await _googleSignIn.attemptLightweightAuthentication();
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();
      final String? idToken = (await googleUser.authentication).idToken;

      if (idToken == null) {
        throw Exception("ID Token tidak ditemukan");
      }

      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: idToken,
      );

      await _auth.signInWithCredential(credential);

      // Kirim ke backend PHP (opsional)
      try {
        const String baseUrl = "http://10.230.232.96";
        final response = await http.post(
          Uri.parse("$baseUrl/api_code/login.php"),
          body: {"id_token": idToken},
        );
        debugPrint("Status HTTP: ${response.statusCode}");
        debugPrint("Response: ${response.body}");
        jsonDecode(response.body);
      } catch (e) {
        debugPrint("Gagal menghubungi backend PHP: $e");
      }
    } catch (e) {
      debugPrint("Google Sign In Error: $e");
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
    await _clearUserSession();
  }
}