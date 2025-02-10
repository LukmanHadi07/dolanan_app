import 'package:dulinan/src/core/theme/color.dart';
import 'package:dulinan/src/features/auth/presentation/providers/auth_providers.dart';
import 'package:dulinan/src/features/auth/presentation/providers/state/auth_state.dart';
import 'package:dulinan/src/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final TextEditingController emailControler = TextEditingController();
  final TextEditingController passwordControler = TextEditingController();

  bool _isObscured = true;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(authStateNotifierProvider.notifier).checkLoginStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authStateNotifierProvider);

    ref.listen(authStateNotifierProvider.select((value) => value),
        ((previous, next) {
      if (next is Failure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              next.exception.message.toString(),
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
          ),
        );
      } else if (next is Success) {
        context.go(AppRoutes.main);
      }
    }));

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
                      controller: emailControler,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.white,
                        hintText: 'Email',
                        hintStyle: Theme.of(context)
                            .textTheme
                            .titleSmall!
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
                          controller: passwordControler,
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
                            hintText: 'Password',
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
                      state.maybeMap(
                        loading: (value) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          );
                        },
                        orElse: () {
                          return SizedBox(
                            width: 400,
                            height: 60,
                            child: ElevatedButton(
                              onPressed: () {
                                if (emailControler.text.isEmpty ||
                                    passwordControler.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Email dan password tidak boleh kosong',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                  return;
                                }
                                ref
                                    .read(authStateNotifierProvider.notifier)
                                    .login(emailControler.text,
                                        passwordControler.text);
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
                          );
                        },
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
