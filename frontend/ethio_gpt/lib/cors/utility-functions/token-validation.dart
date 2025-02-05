import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class TokenValidation {
  Future<void> saveToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> removeToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  Future<bool> isTokenSet() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('token') && prefs.getString('token') != null;
  }

  String getUserEmail(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('Invalid token');
    }
    final payload = _decodeBase64(parts[1]);
    final String email = json.decode(payload)['email'].toString();

    return email;
  }

  String _decodeBase64(String str) {
    String normalized = base64Url.normalize(str);
    return utf8.decode(base64Url.decode(normalized));
  }
}
