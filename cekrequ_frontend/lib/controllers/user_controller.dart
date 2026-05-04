import 'package:cekrequ_frontend/models/user.dart';
import 'package:cekrequ_frontend/services/user_api_services.dart';

class UserController {
  
  static Future<User> getUser(String token)async{
    return await UserApiService(token).fetchUser();
  }

}