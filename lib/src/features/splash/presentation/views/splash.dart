import 'package:dulinan/src/core/theme/color.dart';
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
    _navigateToNextScreen();
    super.initState();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    final isOnBoarded = ref.watch(splashScreenProvider);

    if (isOnBoarded) {
      context.go(AppRoutes.home);
    } else {
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
