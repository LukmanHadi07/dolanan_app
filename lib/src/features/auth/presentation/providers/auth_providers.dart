import 'package:dulinan/src/features/auth/domain/providers/auth_provider.dart';
import 'package:dulinan/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:dulinan/src/features/auth/presentation/providers/state/auth_notifier.dart';
import 'package:dulinan/src/features/auth/presentation/providers/state/auth_state.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final authStateNotifierProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final AuthenticationRepository authRepository =
      ref.watch(authRepositoryProvider);

  return AuthNotifier(authRepository);
});
