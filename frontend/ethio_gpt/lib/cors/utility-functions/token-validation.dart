import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class TokenValidation {
  // for the token part
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
  // for the theme part

  Future<void> saveTheme(String theme) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme', theme);
  }

  Future<String?> getTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('theme');
  }

  Future<bool> isThemeSet() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('theme') && prefs.getString('theme') != null;
  }

  // for the language part
  Future<void> saveLanguage(String language) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', language);
  }

  Future<String?> getLanguage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('language');
  }

  Future<bool> isLanguageSet() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('language') && prefs.getString('language') != null;
  }
}
