// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dulinan/src/features/user/data/datasources/user_remote_data_sources.dart';
import 'package:dulinan/src/features/user/domain/entities/user.dart';
import 'package:dulinan/src/features/user/domain/repositories/user_repository.dart';
import 'package:dulinan/src/shared/domain/models/either.dart';
import 'package:dulinan/src/shared/exceptions/http_exceptions.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDataSource userDataSource;
  UserRepositoryImpl({
    required this.userDataSource,
  });
  @override
  Future<Either<AppExceptions, User>> fetchUser() async {
    final resp = await userDataSource.fetchUser();

    return resp.fold((error) {
      return Left(error);
    }, (userResponse) {
      return Right(userResponse);
    });
  }
}
