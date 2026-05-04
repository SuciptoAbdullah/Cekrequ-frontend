// ignore_for_file: unused_field

class ApiService{
  String baseURL = 'https://gilberto-unpercussive-dara.ngrok-free.dev/api';
  String additionalURL = '';
  
  final Map<String, String> header = {
    'Accept': 'aplication/json',
    'ngrok-skrip-browser-warning' : 'true'
  };
  
  String getURL() => baseURL + additionalURL;
}