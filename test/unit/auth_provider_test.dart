import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:cine_explore/features/auth/presentation/providers/auth_provider.dart';
import 'package:cine_explore/features/auth/data/repositories/auth_repository.dart';
import 'package:cine_explore/features/auth/data/models/user_model.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late AuthProvider provider;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    // Stub checkAuthStatus called in constructor
    when(() => mockRepository.isLoggedIn()).thenAnswer((_) async => false);
    provider = AuthProvider.withRepository(mockRepository);
  });

  group('AuthProvider - état initial', () {
    test('isAuthenticated est false par défaut', () async {
      // give constructor time to run checkAuthStatus
      await Future.delayed(Duration.zero);
      expect(provider.isAuthenticated, false);
    });

    test('isLoading est false par défaut', () {
      expect(provider.isLoading, false);
    });

    test('errorMessage est null par défaut', () {
      expect(provider.errorMessage, isNull);
    });
  });

  group('AuthProvider - login', () {
    test('login avec succès met isAuthenticated à true', () async {
      when(() => mockRepository.login(any(), any()))
          .thenAnswer((_) async => UserModel(
                id: 1,
                email: 'test@test.com',
                token: 'fake_token',
              ));

      final result = await provider.login('test@test.com', 'password');

      expect(result, true);
      expect(provider.isAuthenticated, true);
      expect(provider.errorMessage, isNull);
    });

    test('login en erreur renvoie false et errorMessage non null', () async {
      when(() => mockRepository.login(any(), any()))
          .thenThrow(Exception('Identifiants invalides'));

      final result = await provider.login('bad@email.com', 'wrong');

      expect(result, false);
      expect(provider.isAuthenticated, false);
      expect(provider.errorMessage, isNotNull);
    });
  });

  group('AuthProvider - logout', () {
    test('logout met isAuthenticated à false', () async {
      when(() => mockRepository.login(any(), any()))
          .thenAnswer((_) async => UserModel(
                id: 1,
                email: 'test@test.com',
                token: 'fake_token',
              ));
      when(() => mockRepository.logout()).thenAnswer((_) async {});

      await provider.login('test@test.com', 'password');
      await provider.logout();

      expect(provider.isAuthenticated, false);
    });
  });
}
