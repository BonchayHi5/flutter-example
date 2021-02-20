import 'package:http/http.dart' as http;
import 'dart:convert';

class Auth {
  static const BASE_URL = 'https://identitytoolkit.googleapis.com';
  static const API_KEY = 'AIzaSyCLMKUDWAV_eVFhyJckiRRTiWdiDHwp9EQ';

  //https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=[API_KEY]

  Future<void> signUp(String email, String password) async {
    try {
      final res = await http.post(
        '$BASE_URL+/v1/accounts:signUp?key=$API_KEY',
        body: json.encode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }),
      );

      print(json.decode(res.body));
    } catch (e) {
      print(e.toString());
    }
  }
}
