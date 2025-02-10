import 'package:dulinan/src/features/auth/presentation/providers/state/auth_state.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dulinan/src/features/auth/domain/repositories/auth_repository.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthenticationRepository _repository;

  AuthNotifier(this._repository) : super(const AuthState.initial()) {}

  // Future<void> checkAuthStatus() async {
  //   state = const AuthState.loading();d
  //   final result = await _repository.getCurrentUser();
  //   result.fold(
  //     (failure) => state = AuthState.unauthenticated(failure.message),
  //     (user) => state = user != null
  //         ? AuthState.authenticated(user)
  //         : const AuthState.unauthenticated(null),
  //   );
  // }

  Future<void> login(String email, String password) async {
    state = const AuthState.loading();
    final result = await _repository.login(email, password);
    result.fold((failure) => state = AuthState.error(failure),
        (user) => state = const AuthState.success());
  }

  Future<void> register(String name, String email, String password) async {
    state = const AuthState.loading();
    final result = await _repository.register(name, email, password);
    result.fold((failure) {
      state = AuthState.error(failure);
    }, (user) => state = const AuthState.success());
  }

  Future<void> checkLoginStatus() async {
    final isLoggedIn = await _repository.isLoggedIn();
    if (isLoggedIn) {
      state = const AuthState.success();
    }
  }

  // Future<void> logout() async {
  //   final result = await _repository.logout();
  //   result.fold(
  //     (failure) => state = AuthState.unauthenticated(failure.message),
  //     (_) => state = const AuthState.unauthenticated(null),
  //   );
  // }
}
