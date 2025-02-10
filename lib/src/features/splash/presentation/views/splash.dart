import 'package:dulinan/src/core/theme/color.dart';
import 'package:dulinan/src/features/auth/domain/providers/auth_provider.dart';
import 'package:dulinan/src/features/auth/presentation/providers/auth_providers.dart';
import 'package:dulinan/src/features/splash/presentation/providers/splash_provider.dart';
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

    Future.microtask(() async {
      await ref.read(authStateNotifierProvider.notifier).checkLoginStatus();
      _navigateToNextScreen(); // Pindahkan navigasi ke sini setelah login dicek
      loadToken(ref);
    });
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));

    final isLoggedIn = await ref.read(isLoggedInProvider.future);
    debugPrint("DEBUG: isLoggedIn = $isLoggedIn");

    if (isLoggedIn) {
      debugPrint("Navigating to Main Screen");
      // ignore: use_build_context_synchronously
      context.go(AppRoutes.main); // Arahkan ke Main Screen jika login
    } else {
      debugPrint("Navigating to OnBoard");
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
