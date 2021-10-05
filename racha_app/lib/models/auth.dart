import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/foundation.dart';

class Auth with ChangeNotifier {
  static const _url =
      'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyA7J_misLHB1wkz_cXg9grp4ZMu8B3zV3k';
  Future<void> signup(
      String name, String userName, String email, String password) async {
    final response = await http.post(
      Uri.parse(_url),
      body: jsonEncode({
        'name': name,
        'userName': userName,
        'email': email,
        'password': password,
        'returnSecureToken': true,
      }),
    );

    print(jsonDecode(response.body));
  }
}
