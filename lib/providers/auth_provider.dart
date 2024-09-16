import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthProvider with ChangeNotifier {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  AuthProvider() {
    _checkAuthentication();
  }

  Future<void> _checkAuthentication() async {
    String? token = await _storage.read(key: 'jwt');
    _isAuthenticated = token != null;
    notifyListeners();
  }

  Future<void> login(String token) async {
    await _storage.write(key: 'jwt', value: token);
    _isAuthenticated = true;
    notifyListeners();
  }

  Future<void> logout() async {
    await _storage.delete(key: 'jwt');
    _isAuthenticated = false;
    notifyListeners();
  }
}