import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  
  User? _user;
  bool _initialized = false;
  
  User? get user => _user;
  
  AuthProvider() {
    _auth.authStateChanges().listen((User? newUser) {
      _user = newUser;
      notifyListeners();
    });
    _initGoogleSignIn();
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
        debugPrint("Error: ID Token tidak ditemukan.");
        return;
      }
      
      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: idToken,
      );
      
      await _auth.signInWithCredential(credential);
      
      await _sendTokenToBackend(idToken);
    } catch (e) {
      debugPrint("Error login: $e");
    }
  }
  
  Future<void> _sendTokenToBackend(String idToken) async {
    const String baseUrl = "http://10.0.166.53";
    
    try {
      debugPrint("Mencoba kirim ke PHP...");
      
      final response = await http.post(
        Uri.parse("$baseUrl/cekrequ_backend/login.php"),
        body: {"id_token": idToken},
      );
      
      debugPrint("Status HTTP: ${response.statusCode}");
      debugPrint("Response body: ${response.body}");
      
      final responseData = json.decode(response.body);
      debugPrint("Pesan dari Server PHP: ${responseData["message"]}");
    } catch (e) {
      debugPrint("Error mengirim token ke backend: $e");
    }
  }
  
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}