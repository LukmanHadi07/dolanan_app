import 'package:dulinan/src/features/category/data/models/categories_response.dart';
import 'package:dulinan/src/shared/data/remote/remote.dart';
import 'package:dulinan/src/shared/domain/models/either.dart';
import 'package:dulinan/src/shared/exceptions/http_exceptions.dart';

abstract class CategoryDataSource {
  Future<Either<AppExceptions, CategoriesResponse>> getCategories();
}

class CategoryRemoteDataSource extends CategoryDataSource {
  final DioNetworkService networkService;

  CategoryRemoteDataSource({required this.networkService});

  @override
  Future<Either<AppExceptions, CategoriesResponse>> getCategories() async {
    try {
      final eitherType = await networkService.get(
        '/categories',
      );
      return eitherType.fold((exception) {
        return Left(exception);
      }, (response) {
        if (response.data == null) {
          return Left(
            AppExceptions(
              message: 'Invalid response from server',
              statusCode: 400,
              identifier:
                  'CategoryRemoteDataSource.getCategories() - Null response data',
            ),
          );
        }

        final categories = CategoriesResponse.fromJson(response.data);

        return Right(categories);
      });
    } catch (e) {
      return Left(
        AppExceptions(
          message: 'Failed to fetch categories',
          statusCode: 500,
          identifier: 'CategoryRemoteDataSource.getCategories() - $e',
        ),
      );
    }
  }
}
