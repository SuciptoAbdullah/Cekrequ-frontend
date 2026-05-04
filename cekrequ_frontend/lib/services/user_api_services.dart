import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:cekrequ_frontend/models/user.dart';
import 'api_services.dart';

class UserApiService extends ApiService{
  
  UserApiService(String token){
    super.additionalURL = '/user/$token';
  }

  Future<User> fetchUser() async {
    final response = await http.get(
      Uri.parse(super.getURL()),
      headers: super.header
    );

    if(response.statusCode != 200){
      throw Exception("Failed to get user Data, status: ${response.statusCode}");
    }

    final Map<String, dynamic> jsonResponse = json.decode(response.body);

    return User.froomJson(jsonResponse['data']);
  }

  Future<User> fetchUserBookingList({int offset = 0}) async {
    final response = await http.get(
      Uri.parse("${ super.getURL() }/booking-list"),
      headers: super.header
    );

    if(response.statusCode != 200){
      throw Exception("Failed to get user Data");
    }

    final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

    return User.froomJson(jsonResponse);
  }

}