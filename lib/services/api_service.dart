import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
   final String baseUrl = 'https://gidcaf.ru';
   final storage = const FlutterSecureStorage();
 

  Future<String?> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/api/auth/login');
    final response = await http.post(
      url,
      body: {'email': email, 'password': password},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['token']; // Возвращаем токен
    } else {
      return null;
    }
  }
 
   // Метод для регистрации
   Future<bool> register(String username, String password, String confirmPassword) async {
     final url = Uri.parse('$baseUrl/api/auth/registration');
     final response = await http.post(
       url,
       body: {
         'username': username,
         'password': password,
         'confirmPassword': confirmPassword,
       },
     );
 
     if (response.statusCode == 200) {
       // Регистрация прошла успешно
       return true;
     } else {
       // Обработка ошибок
       return false;
     }
   }
 
   // Метод для восстановления пароля
   Future<bool> forgetPassword(String email) async {
     final url = Uri.parse('$baseUrl/api/auth/forget');
     final response = await http.post(
       url,
       body: {'email': email},
     );
 
     if (response.statusCode == 200) {
       // Письмо для восстановления отправлено
       return true;
     } else {
       // Обработка ошибок
       return false;
     }
   }
 
   // Метод для получения защищенных данных
   Future<http.Response> getProtectedData(String endpoint) async {
     final token = await storage.read(key: 'jwt');
     final url = Uri.parse('$baseUrl$endpoint');
     final response = await http.get(
       url,
       headers: {'Authorization': 'Bearer $token'},
     );
     return response;
   }
 
   // Метод для выхода
   Future<void> logout() async {
     await storage.delete(key: 'jwt');
   }
 }