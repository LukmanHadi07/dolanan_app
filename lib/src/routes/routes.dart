import 'package:dulinan/src/features/auth/presentation/views/loginviews.dart';
import 'package:dulinan/src/features/home/presentation/views/home.dart';
import 'package:dulinan/src/features/onboard/presentation/views/onboarding.dart';

import 'package:dulinan/src/features/splash/presentation/views/splash.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static const splash = '/';
  static const onBoard = '/onBoard';
  static const login = '/login';
  static const home = '/home';

  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
          path: splash,
          builder: (BuildContext context, GoRouterState state) {
            return const Splash();
          }),
      GoRoute(
          path: onBoard,
          builder: (BuildContext context, GoRouterState state) {
            return const OnBoarding();
          }),
      GoRoute(
          path: login,
          builder: (BuildContext context, GoRouterState state) {
            return LoginView();
          }),
      GoRoute(
          path: home,
          builder: (BuildContext context, GoRouterState state) {
            return const Home();
          })
    ],
  );
}