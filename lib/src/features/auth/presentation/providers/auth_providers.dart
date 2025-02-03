import 'package:dulinan/src/features/auth/domain/providers/auth_provider.dart';
import 'package:dulinan/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:dulinan/src/features/auth/presentation/providers/state/auth_notifier.dart';
import 'package:dulinan/src/features/auth/presentation/providers/state/auth_state.dart';
import 'package:dulinan/src/services/user_cache_service/domain/providers/user_cache_provider.dart';
import 'package:dulinan/src/services/user_cache_service/domain/repositories/user_cache_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authStateNotifierProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final AuthenticationRepository authRepository =
      ref.watch(authRepositoryProvider);
  final UserRepository userRepository = ref.watch(userLocalRepositoryProvider);
  return AuthNotifier(
      authRepository: authRepository, userRepository: userRepository);
});
