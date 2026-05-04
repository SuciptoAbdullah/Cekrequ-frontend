// ignore_for_file: avoid_print

import 'package:cekrequ_frontend/models/user.dart';
import 'package:cekrequ_frontend/services/user_api_services.dart';

void main() async{
  final String token = "aKhKlhaRTE76diiO8UwTffJN65SOWSVQ";
  final UserApiService userService = UserApiService(token);

  User user = await userService.fetchUser();  
  print(user.toString());

}