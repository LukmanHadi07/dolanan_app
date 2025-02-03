// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:dulinan/src/features/category/domain/providers/state/category_state.dart';
import 'package:dulinan/src/features/category/domain/repositories/category_repository.dart';

class CategoryNotifier extends StateNotifier<CategoryState> {
  final CategoryRepository categoryRepository;
  CategoryNotifier({
    required this.categoryRepository,
  }) : super(const CategoryState.initial());

  Future<void> fetchCategories() async {
    state = const CategoryState.loading();
    final resp = await categoryRepository.getCategories();
    state =
        await resp.fold((failure) => CategoryState.error(failure), (category) {
      return CategoryState.success(category);
    });
  }
}
