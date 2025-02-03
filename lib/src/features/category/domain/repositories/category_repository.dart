import 'package:dulinan/src/features/category/data/models/categories_response.dart';
import 'package:dulinan/src/shared/domain/models/either.dart';
import 'package:dulinan/src/shared/exceptions/http_exceptions.dart';

abstract class CategoryRepository {
  Future<Either<AppExceptions, CategoriesResponse>> getCategories();
}
