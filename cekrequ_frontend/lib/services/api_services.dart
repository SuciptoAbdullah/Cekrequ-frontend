import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://gilberto-unpercussive-dara.ngrok-free.dev";
  static const String apiVersion = "/api/v1";
  
  // Helper untuk mendapatkan full URL
  String getFullUrl(String endpoint) {
    return "$baseUrl$apiVersion$endpoint";
  }
  
  // Header standar
  Map<String, String> getHeaders({String? token}) {
    final headers = {
      'ngrok-skip-browser-warning': 'true',
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }
    
    return headers;
  }
  
  // ================= GET REQUEST =================
  Future<Map<String, dynamic>?> get(String endpoint, {String? token}) async {
    try {
      final Uri url = Uri.parse(getFullUrl(endpoint));
      final response = await http.get(
        url,
        headers: getHeaders(token: token),
      );
      
      print("🔵 GET $endpoint - Status: ${response.statusCode}");
      print("🔵 Response: ${response.body}");
      
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print("❌ GET gagal: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("❌ Error GET: $e");
      return null;
    }
  }
  
  // ================= POST REQUEST =================
  Future<Map<String, dynamic>?> post(String endpoint, Map<String, dynamic> data, {String? token}) async {
    try {
      final Uri url = Uri.parse(getFullUrl(endpoint));
      final response = await http.post(
        url,
        headers: getHeaders(token: token),
        body: jsonEncode(data),
      );
      
      print("🔵 POST $endpoint - Status: ${response.statusCode}");
      print("🔵 Response: ${response.body}");
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        print("❌ POST gagal: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("❌ Error POST: $e");
      return null;
    }
  }
  
  // ================= PUT REQUEST =================
  Future<Map<String, dynamic>?> put(String endpoint, Map<String, dynamic> data, {String? token}) async {
    try {
      final Uri url = Uri.parse(getFullUrl(endpoint));
      final response = await http.put(
        url,
        headers: getHeaders(token: token),
        body: jsonEncode(data),
      );
      
      print("🔵 PUT $endpoint - Status: ${response.statusCode}");
      print("🔵 Response: ${response.body}");
      
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print("❌ PUT gagal: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("❌ Error PUT: $e");
      return null;
    }
  }
  
  // ================= DELETE REQUEST =================
  Future<bool> delete(String endpoint, {String? token}) async {
    try {
      final Uri url = Uri.parse(getFullUrl(endpoint));
      final response = await http.delete(
        url,
        headers: getHeaders(token: token),
      );
      
      print("🔵 DELETE $endpoint - Status: ${response.statusCode}");
      
      if (response.statusCode == 200) {
        return true;
      } else {
        print("❌ DELETE gagal: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("❌ Error DELETE: $e");
      return false;
    }
  }
  
  // ================= LOGIN =================
  Future<Map<String, dynamic>?> login(String email, String password) async {
    return post('/sign-in', {
      'email': email,
      'password': password,
    });
  }
  
  // ================= REGISTER =================
  Future<Map<String, dynamic>?> register(String email, String password, String username) async {
    return post('/sign-up', {
      'email': email,
      'password': password,
      'username': username,
    });
  }
  
  // ================= GET PROFILE =================
  Future<Map<String, dynamic>?> getProfile(String token) async {
    return get('/user/profile', token: token);
  }
  
  // ================= GET ALL PAKET =================
  Future<Map<String, dynamic>?> getAllPaket() async {
    return get('/paket');
  }
  
  // ================= GET PAKET BY ID =================
  Future<Map<String, dynamic>?> getPaketById(String id) async {
    return get('/paket/$id');
  }
  
  // ================= CREATE PESANAN =================
  Future<Map<String, dynamic>?> createPesanan(Map<String, dynamic> data, String token) async {
    return post('/pesanan', data, token: token);
  }
  
  // ================= GET PESANAN USER =================
  Future<Map<String, dynamic>?> getPesananUser(String token) async {
    return get('/pesanan/user', token: token);
  }
  
  // ================= TEST KONEKSI =================
  Future<bool> testConnection() async {
    try {
      final Uri url = Uri.parse("$baseUrl$apiVersion");
      final response = await http.get(
        url,
        headers: {
          'ngrok-skip-browser-warning': 'true',
          'Accept': 'application/json',
        },
      );
      
      print("🔵 Test Connection - Status: ${response.statusCode}");
      return response.statusCode == 200;
    } catch (e) {
      print("❌ Test Connection Error: $e");
      return false;
    }
  }
  
  // ================= GET dengan query parameters =================
  Future<Map<String, dynamic>?> getWithParams(
    String endpoint, 
    Map<String, String> params, 
    {String? token}
  ) async {
    try {
      final Uri url = Uri.parse(getFullUrl(endpoint)).replace(queryParameters: params);
      final response = await http.get(
        url,
        headers: getHeaders(token: token),
      );
      
      print("🔵 GET $endpoint with params - Status: ${response.statusCode}");
      
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print("❌ GET gagal: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("❌ Error GET: $e");
      return null;
    }
  }
}