import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_constants.dart';

class AuthInterceptor extends Interceptor {
  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // Si la requête est vers TMDB, on ajoute la clé API en query param
    if (options.uri.toString().contains(ApiConstants.tmdbBaseUrl)) {
      options.queryParameters['api_key'] = ApiConstants.tmdbApiKey;
      options.queryParameters['language'] = 'fr-FR';
    } 
    // Sinon (ex: notre backend / reqres), on injecte le token JWT si on l'a
    else if (options.uri.toString().contains(ApiConstants.authBaseUrl)) {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('jwt_token');
      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    }
    
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Gestion globale des erreurs réseau (logs, refresh token si 401, etc.)
    if (err.response?.statusCode == 401) {
      // TODO: Logique de refresh token ici
    }
    super.onError(err, handler);
  }
}
