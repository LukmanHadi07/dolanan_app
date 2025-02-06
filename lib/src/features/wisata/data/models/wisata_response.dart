import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dulinan/src/features/category/domain/entities/pagination.dart';
import 'package:dulinan/src/features/wisata/domain/entities/wisata.dart';

part 'wisata_response.freezed.dart';
part 'wisata_response.g.dart';

@freezed
class WisataResponse with _$WisataResponse {
  factory WisataResponse({
    String? status,
    List<Wisata>? data,
    Pagination? pagination,
  }) = _WisataResponse;

  factory WisataResponse.fromJson(Map<String, dynamic> json) =>
      _$WisataResponseFromJson(json);
}
