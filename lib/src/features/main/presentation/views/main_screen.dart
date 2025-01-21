import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:dulinan/src/core/theme/color.dart';
import 'package:dulinan/src/features/main/presentation/providers/main_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(mainProviderProvider);
    final controllerNotifier = ref.watch(mainProviderProvider.notifier);

    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
            color: AppColors.primaryColor,
            backgroundColor: Colors.white,
            index: controller,
            items: [
              CurvedNavigationBarItem(
                  child: const Icon(Icons.home_outlined, color: Colors.white),
                  label: 'Home',
                  labelStyle: TextStyle(
                      color: Colors.white,
                      fontFamily: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                      ).fontFamily)),
              CurvedNavigationBarItem(
                  child: const Icon(Icons.search, color: Colors.white),
                  label: 'Search',
                  labelStyle: TextStyle(
                      color: Colors.white,
                      fontFamily: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                      ).fontFamily)),
              CurvedNavigationBarItem(
                  child: const Icon(Icons.chat_bubble_outline,
                      color: Colors.white),
                  label: 'Chat',
                  labelStyle: TextStyle(
                      color: Colors.white,
                      fontFamily: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                      ).fontFamily)),
              CurvedNavigationBarItem(
                  child: const Icon(Icons.perm_identity, color: Colors.white),
                  label: 'Personal',
                  labelStyle: TextStyle(
                      color: Colors.white,
                      fontFamily: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                      ).fontFamily)),
            ],
            onTap: controllerNotifier.selectedIndex),
        body: controllerNotifier.currentPage);
  }
}
