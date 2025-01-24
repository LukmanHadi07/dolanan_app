// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dulinan/src/shared/data/remote/network_service.dart';
import 'package:dulinan/src/shared/domain/models/either.dart';
import 'package:dulinan/src/shared/domain/models/user/user_model.dart';
import 'package:dulinan/src/shared/exceptions/http_exceptions.dart';

abstract class LoginUserDataSource {
  Future<Either<AppExceptions, User>> loginUser({required User user});
}

class LoginUserRemoteDataSource implements LoginUserDataSource {
  final NetworkService networkService;
  LoginUserRemoteDataSource({
    required this.networkService,
  });

  @override
  Future<Either<AppExceptions, User>> loginUser({
    required User user,
  }) async {
    try {
      final eitherType = await networkService.post(
        '/auth/login',
        data: user.toJson(),
      );
      return eitherType.fold((exception) {
        return Left(exception);
      }, (response) {
        final user = User.fromJson(response.data);
        // networkService.updateHeaders({
        //   'Authorization': 'Bearer ${user.token}',
        // });
        return Right(user);
      });
    } catch (e) {
      return Left(
        AppExceptions(
          message: 'Unknown error',
          statusCode: 1,
          identifier: '${e.toString()}\nLoginUserRemoteDataSource.loginUser()',
        ),
      );
    }
  }
}
