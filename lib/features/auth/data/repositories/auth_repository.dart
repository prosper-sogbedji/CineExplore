import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/network/api_constants.dart';
import '../../../core/network/dio_client.dart';
import '../models/user_model.dart';

class AuthRepository {
  final Dio _dio;

  AuthRepository({Dio? dio}) : _dio = dio ?? DioClient().dio;

  Future<UserModel> login(String email, String password) async {
    try {
      final response = await _dio.post(
        '${ApiConstants.authBaseUrl}/login',
        data: {'email': email, 'password': password},
      );
      
      final token = response.data['token'];
      final user = UserModel(id: 1, email: email, token: token);
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwt_token', token);
      
      return user;
    } catch (e) {
      throw Exception('Erreur de connexion. Vérifiez vos identifiants.');
    }
  }

  Future<UserModel> register(String email, String password) async {
    try {
      final response = await _dio.post(
        '${ApiConstants.authBaseUrl}/register',
        data: {'email': email, 'password': password},
      );
      
      final token = response.data['token'];
      final id = response.data['id'] ?? 2;
      final user = UserModel(id: id, email: email, token: token);
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwt_token', token);
      
      return user;
    } catch (e) {
      throw Exception('Erreur lors de l\\'inscription.');
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt_token');
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('jwt_token');
  }
}
