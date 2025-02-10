import 'package:dulinan/src/features/category/data/datasources/category_remote_data_source.dart';
import 'package:dulinan/src/features/category/data/repositories/category_repository_impl.dart';
import 'package:dulinan/src/features/category/domain/providers/state/category_notifier.dart';
import 'package:dulinan/src/features/category/domain/providers/state/category_state.dart';
import 'package:dulinan/src/features/category/domain/repositories/category_repository.dart';

import 'package:dulinan/src/shared/data/remote/remote.dart';
import 'package:dulinan/src/shared/domain/providers/dio_network_service_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoryRemoteDataSourceProvider =
    Provider.family<CategoryDataSource, DioNetworkService>(
        (ref, networkService) =>
            CategoryRemoteDataSource(networkService: networkService));

final categoryRepositoryProvider = Provider<CategoryRepository>((ref) {
  final DioNetworkService networkService = ref.watch(networkServiceProvider);
  final CategoryDataSource categoryDataSource =
      ref.watch(categoryRemoteDataSourceProvider(networkService));
  return CategoryRepositoryImpl(categoryDataSource: categoryDataSource);
});

final cateoryStateNotifierProvider =
    StateNotifierProvider<CategoryNotifier, CategoryState>((ref) {
  final CategoryRepository categoryRepository =
      ref.watch(categoryRepositoryProvider);
  return CategoryNotifier(categoryRepository: categoryRepository);
});
