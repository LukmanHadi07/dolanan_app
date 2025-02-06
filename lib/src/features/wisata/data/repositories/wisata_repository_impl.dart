import 'package:dulinan/src/features/wisata/data/datasources/wisata_remote_data_source.dart';
import 'package:dulinan/src/features/wisata/data/models/wisata_response.dart';
import 'package:dulinan/src/features/wisata/domain/repositories/wisata_repository.dart';
import 'package:dulinan/src/shared/domain/models/either.dart';
import 'package:dulinan/src/shared/exceptions/http_exceptions.dart';

class WisataRepositoryImpl extends WisataRepository {
  final WisataDataSource wisataDataSource;

  WisataRepositoryImpl({required this.wisataDataSource});
  @override
  Future<Either<AppExceptions, WisataResponse>> getWisata() async {
    final result = await wisataDataSource.getWisata();
    return result.fold((exceptionError) {
      return Left(exceptionError);
    }, (wisataResponseSuccess) {
      return Right(wisataResponseSuccess);
    });
  }
}
