import 'package:dulinan/src/core/theme/theme.dart';
import 'package:dulinan/src/features/auth/presentation/providers/auth_providers.dart';
import 'package:dulinan/src/features/auth/presentation/providers/state/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginView extends ConsumerWidget {
  LoginView({super.key});

  final TextEditingController usernameController =
      TextEditingController(text: 'emilys');
  final TextEditingController passwordController =
      TextEditingController(text: 'emilyspass');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = dolananNewTheme(true);
    final state = ref.watch(authStateNotifierProvider);
    ref.listen(authStateNotifierProvider.select((value) => value),
        ((previous, next) {
      if (next is Failure) {
        debugPrint(next.exception.message.toString());
      } else if (next is Success) {
        debugPrint('Login successful');
      }
    }));
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'Welcome Back',
                style: theme.textTheme.headlineMedium!.copyWith(
                  color: theme.primaryColor,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Email',
                  style: theme.textTheme.labelMedium,
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    hintText: 'Masukan Email',
                    hintStyle: theme.textTheme.labelSmall,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Password',
                  style: theme.textTheme.labelMedium,
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    hintText: 'Masukan Password',
                    hintStyle: theme.textTheme.labelSmall,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            state.maybeMap(
                loading: (_) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                orElse: () => loginButton(ref))
          ],
        ),
      ),
    );
  }

  Widget loginButton(WidgetRef ref) {
    final theme = dolananNewTheme(true);
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: ElevatedButton(
        style: theme.appTheme.primaryButtonTheme.style,
        onPressed: () {
          ref
              .read(authStateNotifierProvider.notifier)
              .loginUser(usernameController.text, passwordController.text);
        },
        child: Text(
          'Login',
          style: theme.appTheme.primaryTextTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
