import 'package:dulinan/src/features/wisata/data/models/wisata_response.dart';
import 'package:dulinan/src/shared/domain/models/either.dart';
import 'package:dulinan/src/shared/exceptions/http_exceptions.dart';

abstract class WisataRepository {
  Future<Either<AppExceptions, WisataResponse>> getWisata();
}
