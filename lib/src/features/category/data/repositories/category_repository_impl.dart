import 'package:dulinan/src/features/category/data/datasources/category_remote_data_source.dart';
import 'package:dulinan/src/features/category/data/models/categories_response.dart';
import 'package:dulinan/src/features/category/domain/repositories/category_repository.dart';
import 'package:dulinan/src/shared/domain/models/either.dart';
import 'package:dulinan/src/shared/exceptions/http_exceptions.dart';

class CategoryRepositoryImpl extends CategoryRepository {
  final CategoryDataSource categoryDataSource;

  CategoryRepositoryImpl({required this.categoryDataSource});

  @override
  Future<Either<AppExceptions, CategoriesResponse>> getCategories() async {
    final result = await categoryDataSource.getCategories();

    return result.fold((exceptionError) {
      return Left(exceptionError);
    }, (categoryResponseSuceess) {
      return Right(categoryResponseSuceess);
    });
  }
}
