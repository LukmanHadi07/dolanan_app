// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dulinan/src/features/auth/presentation/providers/state/auth_state.dart';
import 'package:dulinan/src/services/user_cache_service/domain/repositories/user_cache_repository.dart';
import 'package:dulinan/src/shared/domain/models/user/user_model.dart';
import 'package:dulinan/src/shared/exceptions/http_exceptions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dulinan/src/features/auth/domain/repositories/auth_repository.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthenticationRepository authRepository;
  final UserRepository userRepository;

  AuthNotifier({
    required this.authRepository,
    required this.userRepository,
  }) : super(const AuthState.initial());

  Future<void> checkStatusLogin() async {
    state = const AuthState.loading();
    final user = await userRepository.fetchUser();
    final token = await authRepository.getToken();

    if (user != null && token != null) {
      state = const AuthState.success();
    } else {
      state = const AuthState.initial();
    }
  }

  Future<void> loginUser(String email, String password) async {
    state = const AuthState.loading();
    final resp = await authRepository.loginUser(
      user: User(email: email, password: password),
    );

    state = await resp.fold(
      (failure) => AuthState.error(failure),
      (user) async {
        if (user.accessToken == null) {
          return AuthState.error(AppExceptions(
              message: 'Token not found',
              statusCode: 1,
              identifier: 'LoginUser() - Token is null'));
        }

        final hasSaveUserLogin = await userRepository.saveUser(user: user);
        if (hasSaveUserLogin) {
          return const AuthState.success();
        }
        return AuthState.error(CacheFailureException());
      },
    );
  }

  Future<void> registerUser(String name, String email, String password) async {
    state = const AuthState.loading();
    final resp = await authRepository.registerUser(
      user: User(name: name, email: email, password: password),
    );

    state = await resp.fold(
      (failure) => AuthState.error(failure),
      (user) async {
        if (user.accessToken == null) {
          return AuthState.error(AppExceptions(
              message: 'Token not found', statusCode: 1, identifier: ''));
        }

        final hasSaveRegister = await userRepository.saveUser(user: user);
        if (hasSaveRegister) {
          return const AuthState.success();
        }
        return AuthState.error(CacheFailureException());
      },
    );
  }
}
