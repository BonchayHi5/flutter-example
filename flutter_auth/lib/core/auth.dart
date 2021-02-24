import 'package:http/http.dart' as http;
import 'dart:convert';

class Auth {
  static const BASE_URL = 'https://identitytoolkit.googleapis.com';
  static const API_KEY = 'AIzaSyCLMKUDWAV_eVFhyJckiRRTiWdiDHwp9EQ';

  Future<Map> signUp(String email, String password) async {
    Map result;

    final res = await http.post(
      '$BASE_URL/v1/accounts:signUp?key=$API_KEY',
      body: json.encode({
        'email': email,
        'password': password,
        'returnSecureToken': true,
      }),
    );

    if (res != null) {
      result = json.decode(res.body);
    }

    return result;
  }

  Future<Map> signIn(String email, String password) async {
    Map result;

    final res = await http.post(
      '$BASE_URL/v1/accounts:signInWithPassword?key=$API_KEY',
      body: json.encode({
        'email': email,
        'password': password,
        'returnSecureToken': true,
      }),
    );
    
    if(res!=null){
     result = json.decode(res.body);
    }

    return result;
  }
}
