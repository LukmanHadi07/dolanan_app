// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dulinan/src/shared/data/local/storage_service.dart';
import 'package:dulinan/src/shared/domain/models/either.dart';
import 'package:dulinan/src/shared/domain/models/user/user_model.dart';
import 'package:dulinan/src/shared/exceptions/http_exceptions.dart';
import 'package:dulinan/src/shared/globals.dart';

abstract class UserDataSource {
  String get storageKey;
  Future<Either<AppExceptions, User>> fetchUser();
  Future<bool> saveUser({required User user});
  Future<bool> deleteUser();
  Future<bool> hasUser();
}

class UserLocalDatasource extends UserDataSource {
  final StorageService storageService;
  UserLocalDatasource({
    required this.storageService,
  });

  @override
  String get storageKey => USER_LOCAL_STORAGE_KEY;

  @override
  Future<Either<AppExceptions, User>> fetchUser() async {
    final data = await storageService.get(storageKey);
    if (data == null) {
      return Left(
        AppExceptions(
          message: 'User not found',
          statusCode: 404,
          identifier: 'UserLocalDatasource.fetchUser()',
        ),
      );
    }
    final userJson = jsonDecode(data.toString());
    return Right(User.fromJson(userJson));
  }

  @override
  Future<bool> saveUser({required User user}) async {
    return await storageService.set(storageKey, jsonEncode(user.toJson()));
  }

  @override
  Future<bool> deleteUser() async {
    return await storageService.remove(storageKey);
  }

  @override
  Future<bool> hasUser() async {
    return await storageService.has(storageKey);
  }
}
