import 'package:dulinan/src/features/auth/presentation/views/login_views.dart';
import 'package:dulinan/src/features/auth/presentation/views/register_view.dart';
import 'package:dulinan/src/features/details_wisata/presentation/views/detail_wisata.dart';
import 'package:dulinan/src/features/home/presentation/views/home.dart';
import 'package:dulinan/src/features/main/presentation/views/main_screen.dart';
import 'package:dulinan/src/features/onboard/presentation/views/onboarding.dart';

import 'package:dulinan/src/features/splash/presentation/views/splash.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static const splash = '/';
  static const onBoard = '/onBoard';
  static const login = '/login';
  static const home = '/home';
  static const register = '/register';
  static const main = '/main';
  static const detailWisata = '/detailWisata';

  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
          path: splash,
          name: splash,
          builder: (BuildContext context, GoRouterState state) {
            return const Splash();
          }),
      GoRoute(
          path: main,
          name: main,
          builder: (BuildContext context, GoRouterState state) {
            return const MainScreen();
          }),
      GoRoute(
          path: onBoard,
          name: onBoard,
          builder: (BuildContext context, GoRouterState state) {
            return const OnBoarding();
          }),
      GoRoute(
          path: login,
          name: login,
          builder: (BuildContext context, GoRouterState state) {
            return const LoginView();
          }),
      GoRoute(
          path: register,
          name: register,
          builder: (BuildContext context, GoRouterState state) {
            return const RegisterView();
          }),
      GoRoute(
          path: home,
          name: home,
          builder: (BuildContext context, GoRouterState state) {
            return const Home();
          }),
      GoRoute(
          path: detailWisata,
          name: detailWisata,
          builder: (BuildContext context, GoRouterState state) {
            return const DetailWisata();
          })
    ],
  );
}
