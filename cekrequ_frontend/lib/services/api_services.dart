import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  String url = "https://gilberto-unpercussive-dara.ngrok-free.dev/api/v1";

  String test(){
    return "";
  }

  Future<String> hehe() async {
    try {
      final Uri url = Uri.parse(this.url);
      final response = await http.get(
        url,
        headers: {
          'ngrok-skip-browser-warning': 'true',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'].toString();
        // Future.delayed(const Duration());
        return "";
      } else {
        return "hehe";
      }
    } catch (e) {
      return "";
    }
  }

  // Future<void> fetchNgrokData() async {
  //   final Uri url = Uri.parse(
  //     'https://gilberto-unpercussive-dara.ngrok-free.dev/api/v1',
  //   );

  //   try {
  //     // Menyertakan header khusus untuk melewati browser warning
  //     final response = await http.get(
  //       url,
  //       headers: {
  //         'ngrok-skip-browser-warning': 'true',
  //         'Accept': 'application/json',
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       final data = jsonDecode(response.body);
  //       return data['data'];
  //     } else {
  //       return "hehe";
  //     }
  //   } catch (e) {
  //     return "hehe";
  //   }
  // }
}
