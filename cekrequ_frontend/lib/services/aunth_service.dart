import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String baseUrl = 'https://gilberto-unpercussive-dara.ngrok-free.dev';
  
  // ================= LOGIN =================
  Future<String?> login(String identifier, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/sign-in'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'ngrok-skip-browser-warning': 'true',
        },
        body: jsonEncode({
          'identifier': identifier,
          'password': password,
        }),
      );
      
      print("🔵 Login Status: ${response.statusCode}");
      print("🔵 Login Response: ${response.body}");
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        
        // Ambil token dari response: {"massage":"...", "data":{"token":"..."}}
        final token = data['data']['token'];
        
        if (token != null && token.toString().isNotEmpty) {
          // Simpan token ke SharedPreferences
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('access_token', token);
          print("✅ Token berhasil disimpan: $token");
          return token;
        } else {
          print("❌ Token tidak ditemukan dalam response");
          return null;
        }
      } else {
        print("❌ Login gagal dengan status: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("❌ Error login: $e");
      return null;
    }
  }
  
  // ================= REGISTER =================
  Future<bool> register(String identifier, String password, String username) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/sign-up'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'ngrok-skip-browser-warning': 'true',
        },
        body: jsonEncode({
          'identifier': identifier,
          'password': password,
          'username': username,
        }),
      );
      
      print("🔵 Register Status: ${response.statusCode}");
      print("🔵 Register Response: ${response.body}");
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("✅ Register berhasil");
        return true;
      } else {
        print("❌ Register gagal");
        return false;
      }
    } catch (e) {
      print("❌ Error register: $e");
      return false;
    }
  }
  
  // ================= GET PROFILE =================
  Future<Map<String, dynamic>?> getProfile() async {
    try {
      final token = await getToken();
      
      if (token == null) {
        print("❌ Token tidak ditemukan");
        return null;
      }
      
      final response = await http.get(
        Uri.parse('$baseUrl/api/user/profile'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'ngrok-skip-browser-warning': 'true',
        },
      );
      
      print("🔵 Profile Status: ${response.statusCode}");
      print("🔵 Profile Response: ${response.body}");
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // Sesuaikan dengan struktur response API
        return data['data'] ?? data;
      } else {
        print("❌ Gagal mengambil profile");
        return null;
      }
    } catch (e) {
      print("❌ Error get profile: $e");
      return null;
    }
  }
  
  // ================= GET TOKEN =================
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    print("🔍 Token dari storage: $token");
    return token;
  }
  
  // ================= CHECK LOGIN STATUS =================
  static Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }
  
  // ================= LOGOUT =================
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    print("✅ Token berhasil dihapus, user logout");
  }
  
  // ================= UPDATE PROFILE =================
  Future<bool> updateProfile(Map<String, dynamic> data) async {
    try {
      final token = await getToken();
      
      if (token == null) {
        print("❌ Token tidak ditemukan");
        return false;
      }
      
      final response = await http.put(
        Uri.parse('$baseUrl/api/user/profile'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'ngrok-skip-browser-warning': 'true',
        },
        body: jsonEncode(data),
      );
      
      print("🔵 Update Profile Status: ${response.statusCode}");
      print("🔵 Update Profile Response: ${response.body}");
      
      if (response.statusCode == 200) {
        print("✅ Profile berhasil diupdate");
        return true;
      } else {
        print("❌ Gagal update profile");
        return false;
      }
    } catch (e) {
      print("❌ Error update profile: $e");
      return false;
    }
  }
  
  // ================= CHANGE PASSWORD =================
  Future<bool> changePassword(String oldPassword, String newPassword) async {
    try {
      final token = await getToken();
      
      if (token == null) {
        print("❌ Token tidak ditemukan");
        return false;
      }
      
      final response = await http.post(
        Uri.parse('$baseUrl/api/user/change-password'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'ngrok-skip-browser-warning': 'true',
        },
        body: jsonEncode({
          'old_password': oldPassword,
          'new_password': newPassword,
        }),
      );
      
      print("🔵 Change Password Status: ${response.statusCode}");
      
      if (response.statusCode == 200) {
        print("✅ Password berhasil diubah");
        return true;
      } else {
        print("❌ Gagal mengubah password");
        return false;
      }
    } catch (e) {
      print("❌ Error change password: $e");
      return false;
    }
  }
}