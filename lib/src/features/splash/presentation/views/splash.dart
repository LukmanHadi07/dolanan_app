import 'package:dulinan/src/core/theme/color.dart';

import 'package:dulinan/src/features/auth/presentation/providers/auth_providers.dart';
import 'package:dulinan/src/features/auth/presentation/providers/state/auth_state.dart';

import 'package:dulinan/src/routes/routes.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class Splash extends ConsumerStatefulWidget {
  const Splash({super.key});

  @override
  ConsumerState<Splash> createState() => _SplashState();
}

class _SplashState extends ConsumerState<Splash> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkStatusLogin();
    });
  }

  Future<void> _checkStatusLogin() async {
    final authNotifier = ref.read(authStateNotifierProvider.notifier);
    await authNotifier.checkStatusLogin();

    final authState = ref.watch(authStateNotifierProvider);
    await Future.delayed(const Duration(seconds: 2));

    if (authState is Success) {
      // ignore: use_build_context_synchronously
      context.go(AppRoutes.main);
    } else {
      // ignore: use_build_context_synchronously
      context.go(AppRoutes.onBoard);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1E88E5),
      body: Center(
        child: Text(
          'DOLANAN',
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }
}
