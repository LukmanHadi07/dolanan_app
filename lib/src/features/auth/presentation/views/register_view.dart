import 'package:dulinan/src/core/theme/color.dart';
import 'package:dulinan/src/features/auth/presentation/providers/auth_providers.dart';
import 'package:dulinan/src/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:google_fonts/google_fonts.dart';

class RegisterView extends ConsumerStatefulWidget {
  const RegisterView({super.key});

  @override
  ConsumerState<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends ConsumerState<RegisterView> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isObscured = true;
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authStateNotifierProvider);

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Sign Up Now',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      color: AppColors.white,
                      fontFamily:
                          GoogleFonts.poppins(fontWeight: FontWeight.w500)
                              .fontFamily,
                    ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                'Please fill details to create your account',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: AppColors.white,
                      fontFamily:
                          GoogleFonts.poppins(fontWeight: FontWeight.w400)
                              .fontFamily,
                    ),
              ),
              const SizedBox(
                height: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name',
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
                      controller: nameController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.white,
                        hintText: 'Name',
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
                      controller: emailController,
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
                          controller: passwordController,
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
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Column(
                    children: [
                      state.maybeMap(loading: (value) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.white,
                          ),
                        );
                      }, orElse: () {
                        return SizedBox(
                          width: 400,
                          height: 60,
                          child: ElevatedButton(
                            onPressed: () {
                              ref
                                  .read(authStateNotifierProvider.notifier)
                                  .register(
                                      nameController.text,
                                      emailController.text,
                                      passwordController.text);
                              context.go(AppRoutes.login);
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
                              'Sign up',
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: 16.sp,
                              ),
                            ),
                          ),
                        );
                      }),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account?',
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
                            child: Text(
                              'Sign in',
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
