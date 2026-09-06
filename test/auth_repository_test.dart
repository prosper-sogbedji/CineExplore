import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cine_explore/features/auth/data/repositories/auth_repository.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late AuthRepository repository;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    repository = AuthRepository(dio: mockDio);
    SharedPreferences.setMockInitialValues({});
  });

  group('AuthRepository Tests', () {
    test("login sauvegarde le token JWT et retourne l'utilisateur", () async {
      // Arrange
      final mockResponse = {
        'token': 'QpwL5tke4Pnpja7X4'
      };
      
      when(() => mockDio.post(any(), data: any(named: 'data')))
          .thenAnswer((_) async => Response(
                data: mockResponse,
                statusCode: 200,
                requestOptions: RequestOptions(path: ''),
              ));

      // Act
      final user = await repository.login('eve.holt@reqres.in', 'cityslicka');

      // Assert
      expect(user.email, 'eve.holt@reqres.in');
      expect(user.token, 'QpwL5tke4Pnpja7X4');
      
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString('jwt_token'), 'QpwL5tke4Pnpja7X4');
    });

    test('isLoggedIn retourne true si le token existe', () async {
      // Arrange
      SharedPreferences.setMockInitialValues({'jwt_token': 'fake_token'});
      
      // Act
      final isAuth = await repository.isLoggedIn();
      
      // Assert
      expect(isAuth, true);
    });

    test('logout supprime le token', () async {
      // Arrange
      SharedPreferences.setMockInitialValues({'jwt_token': 'fake_token'});
      
      // Act
      await repository.logout();
      
      // Assert
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.containsKey('jwt_token'), false);
    });
  });
}
