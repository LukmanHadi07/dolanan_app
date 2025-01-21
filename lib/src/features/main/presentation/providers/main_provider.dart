import 'package:dulinan/src/features/home/presentation/views/home.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'main_provider.g.dart';

@riverpod
class MainProvider extends _$MainProvider {
  @override
  int build() => 0;

  final List<Widget> _pages = [
    const Home(),
    const Center(child: Text('Search')),
    const Center(child: Text('Chat')),
    const Center(child: Text('Personal')),
  ];

  List<Widget> get pages => _pages;

  void selectedIndex(int index) {
    state = index;
  }

  Widget get currentPage => _pages[state];
}
