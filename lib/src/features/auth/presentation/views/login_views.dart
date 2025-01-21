// import 'package:dulinan/src/core/theme/theme.dart';
// import 'package:dulinan/src/features/auth/presentation/providers/auth_providers.dart';
// import 'package:dulinan/src/features/auth/presentation/providers/state/auth_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class LoginView extends ConsumerWidget {
//   LoginView({super.key});

//   final TextEditingController usernameController =
//       TextEditingController(text: 'emilys');
//   final TextEditingController passwordController =
//       TextEditingController(text: 'emilyspass');

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final theme = dolananNewTheme(true);
//     final state = ref.watch(authStateNotifierProvider);
//     ref.listen(authStateNotifierProvider.select((value) => value),
//         ((previous, next) {
//       if (next is Failure) {
//         debugPrint(next.exception.message.toString());
//       } else if (next is Success) {
//         debugPrint('Login successful');
//       }
//     }));
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Center(
//               child: Text(
//                 'Welcome Back',
//                 style: theme.textTheme.headlineMedium!.copyWith(
//                   color: theme.primaryColor,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 15),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Email',
//                   style: theme.textTheme.labelMedium,
//                 ),
//                 const SizedBox(height: 10),
//                 TextField(
//                   controller: usernameController,
//                   decoration: InputDecoration(
//                     hintText: 'Masukan Email',
//                     hintStyle: theme.textTheme.labelSmall,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 15),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Password',
//                   style: theme.textTheme.labelMedium,
//                 ),
//                 const SizedBox(height: 10),
//                 TextField(
//                   controller: passwordController,
//                   decoration: InputDecoration(
//                     hintText: 'Masukan Password',
//                     hintStyle: theme.textTheme.labelSmall,
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10)),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),
//             state.maybeMap(
//                 loading: (_) => const Center(
//                       child: CircularProgressIndicator(),
//                     ),
//                 orElse: () => loginButton(ref))
//           ],
//         ),
//       ),
//     );
//   }

//   Widget loginButton(WidgetRef ref) {
//     final theme = dolananNewTheme(true);
//     return SizedBox(
//       width: double.infinity,
//       height: 45,
//       child: ElevatedButton(
//         style: theme.appTheme.primaryButtonTheme.style,
//         onPressed: () {
//           ref
//               .read(authStateNotifierProvider.notifier)
//               .loginUser(usernameController.text, passwordController.text);
//         },
//         child: Text(
//           'Login',
//           style: theme.appTheme.primaryTextTheme.labelLarge?.copyWith(
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:dulinan/src/core/theme/color.dart';
import 'package:dulinan/src/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:google_fonts/google_fonts.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool _isObscured = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Sign In Now',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: AppColors.white,
                    fontFamily: GoogleFonts.poppins(fontWeight: FontWeight.w500)
                        .fontFamily),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                'Please sign in to continue our app',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: AppColors.white,
                    fontFamily: GoogleFonts.poppins(fontWeight: FontWeight.w400)
                        .fontFamily),
              ),
              const SizedBox(
                height: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Email',
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: AppColors.white,
                        fontFamily:
                            GoogleFonts.poppins(fontWeight: FontWeight.w300)
                                .fontFamily),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextField(
                      decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.white,
                    hintText: 'Email',
                    hintStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: AppColors.white,
                        fontFamily:
                            GoogleFonts.poppins(fontWeight: FontWeight.w400)
                                .fontFamily),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  )),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Password',
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: AppColors.white,
                        fontFamily:
                            GoogleFonts.poppins(fontWeight: FontWeight.w300)
                                .fontFamily),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextField(
                          obscureText: _isObscured,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isObscured
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isObscured = !_isObscured;
                                });
                              },
                            ),
                            filled: true,
                            fillColor: AppColors.white,
                            hintText: 'Email',
                            hintStyle: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(
                                    color: AppColors.white,
                                    fontFamily: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w400)
                                        .fontFamily),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Forgot Password?',
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            color: AppColors.white,
                            fontFamily:
                                GoogleFonts.poppins(fontWeight: FontWeight.w300)
                                    .fontFamily),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        width: 400,
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () {
                            context.go(AppRoutes.main);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: Text(
                            'Sign in',
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an account?',
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(
                                    color: AppColors.white,
                                    fontFamily: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w300)
                                        .fontFamily),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          InkWell(
                            onTap: () {
                              context.go(AppRoutes.register);
                            },
                            child: Text(
                              'Sign up',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(
                                      color: AppColors.white,
                                      fontFamily: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w400)
                                          .fontFamily),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
