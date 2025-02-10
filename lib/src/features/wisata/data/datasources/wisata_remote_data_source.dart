// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dulinan/src/features/wisata/data/models/wisata_response.dart';

import 'package:dulinan/src/shared/data/remote/remote.dart';
import 'package:dulinan/src/shared/domain/models/either.dart';
import 'package:dulinan/src/shared/exceptions/http_exceptions.dart';

abstract class WisataDataSource {
  Future<Either<AppExceptions, WisataResponse>> getWisata();
}

class WisataRemoteDataSource extends WisataDataSource {
  final DioNetworkService networkService;
  WisataRemoteDataSource({
    required this.networkService,
  });

  @override
  Future<Either<AppExceptions, WisataResponse>> getWisata() async {
    try {
      final eitherType = await networkService.get(
        '/wisata',
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
                    'WisataRemoteDataSource.getWisata() - Null response data'),
          );
        }
        final wisata = WisataResponse.fromJson(response.data);
        return Right(wisata);
      });
    } catch (e) {
      return Left(
        AppExceptions(
            message: 'Failed to fetch wisata',
            statusCode: 500,
            identifier: 'WisataRemoteDataSource.getWisata() - $e'),
      );
    }
  }
}
