// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dulinan/src/features/user/domain/entities/user.dart';
import 'package:dulinan/src/features/user/domain/providers/user_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:dulinan/src/core/images_const/image_constants.dart';
import 'package:dulinan/src/core/theme/color.dart';
import 'package:dulinan/src/features/category/domain/providers/category_provider.dart';
import 'package:dulinan/src/features/wisata/domain/entities/wisata.dart';
import 'package:dulinan/src/features/wisata/domain/providers/wisata_providers.dart';
import 'package:dulinan/src/routes/routes.dart';

class Home extends ConsumerStatefulWidget {
  final User? user;
  const Home({
    super.key,
    this.user,
  });

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  late ScrollController _scrollController;
  final double _scrollSpeed = 50.0;
  bool _isScrolling = true;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(cateoryStateNotifierProvider.notifier).fetchCategories();
      ref.read(wisataStateNotifierProvider.notifier).fetchWisata();
      ref.read(userNotifierProvider.notifier).fetchUser();
    });
    _scrollController = ScrollController();
    startScrolling();
  }

  void startScrolling() {
    Future.delayed(const Duration(milliseconds: 50), () {
      if (_scrollController.hasClients && _isScrolling) {
        double maxScroll = _scrollController.position.maxScrollExtent;
        double currentScroll = _scrollController.offset;

        if (currentScroll >= maxScroll) {
          _scrollController.jumpTo(0.0);
        } else {
          _scrollController.animateTo(
            currentScroll + 1,
            duration: Duration(milliseconds: (1000 / _scrollSpeed).round()),
            curve: Curves.linear,
          );
        }
        startScrolling();
      }
    });
  }

  @override
  void dispose() {
    _isScrolling = false;
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(
          left: 15,
          right: 15,
          top: 50,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _headerProfile(ref),
              _titleLabel(),
              _rowCircle(ref),
              _bestDestination(),
              _scrollCardDestination(ref)
            ],
          ),
        ),
      ),
    );
  }

  Widget _scrollCardDestination(WidgetRef ref) {
    final wisataState = ref.watch(wisataStateNotifierProvider);

    return wisataState.when(
      initial: () => const Center(child: Text('Initial State')),
      loading: () => const Center(child: CircularProgressIndicator()),
      success: (wisataResponse) {
        final wisataList = wisataResponse.data ?? [];

        if (wisataList.isEmpty) {
          return const Center(child: Text('Tidak ada data wisata'));
        }

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: wisataList.map((wisata) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: InkWell(
                  onTap: () {
                    context.pushNamed(
                      AppRoutes.detailWisata,
                      extra: wisata,
                    );
                  },
                  child: _cardDestination(wisata),
                ),
              );
            }).toList(),
          ),
        );
      },
      error: (message) => Center(child: Text('Error: $message')),
    );
  }

  Widget _headerProfile(WidgetRef ref) {
    final userState = ref.watch(userNotifierProvider);

    return userState.when(
      data: (user) {
        if (user == null) {
          return const Text('User not found');
        }

        return Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
              ),
              child: ClipOval(
                child: user.profileImage != null
                    ? Image.network(
                        user.profileImage!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Image.asset('assets/images/default_avatar.png'),
                      )
                    : Image.asset('assets/images/default_avatar.png'),
              ),
            ),
            const SizedBox(width: 10),
            Text(user.name ?? 'No Name',
                style: Theme.of(context).textTheme.bodyMedium),
          ],
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (error, _) => const Text('Failed to load user'),
    );
  }

  Widget _titleLabel() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Image.asset(
        ImageConstants.instance.textBanner,
        width: 300.w,
      ),
    );
  }

  Widget _rowCircle(WidgetRef ref) {
    final categoryState = ref.watch(cateoryStateNotifierProvider);

    return categoryState.when(
      initial: () => const Center(child: Text('Initial State')),
      loading: () => const Center(child: CircularProgressIndicator()),
      success: (categoriesResponse) {
        // Debug: Pastikan data kategori sudah diterima
        print("Categories: ${categoriesResponse.data}");

        final List<Widget> circles =
            categoriesResponse.data?.map<Widget>((category) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black,
                          ),
                          child: ClipOval(
                            child: Image.network(
                              category.categoryImage ?? '',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        SizedBox(
                          width: 50,
                          child: Text(
                            category.categoryName ??
                                'No Name', // Menampilkan nama kategori
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 11.sp,
                              fontFamily: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                              ).fontFamily,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList() ??
                [];

        return Container(
          height: 100,
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: ListView(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            physics: const AlwaysScrollableScrollPhysics(), // Bisa scroll
            children: circles,
          ),
        );
      },
      error: (exception) => Center(child: Text('Error: ${exception.message}')),
    );
  }

  Widget _bestDestination() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Best Destination',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontFamily: GoogleFonts.poppins(fontWeight: FontWeight.w500)
                    .fontFamily),
          ),
          InkWell(
            onTap: () {},
            child: Text(
              'View All',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontFamily: GoogleFonts.poppins(fontWeight: FontWeight.w300)
                      .fontFamily,
                  color: AppColors.primaryColor),
            ),
          )
        ],
      ),
    );
  }

  Widget _cardDestination(Wisata wisata) {
    return Container(
      width: 268,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ],
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Container(
              width: 240,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(25),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  wisata.gambarWisata!,
                  fit: BoxFit.cover,
                  height: 286,
                  width: 240,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    wisata.nameWisata!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 20,
                      ),
                      SizedBox(width: 5),
                      Text(
                        '4.5',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.grey,
                        size: 20,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        wisata.alamatWisata!,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
