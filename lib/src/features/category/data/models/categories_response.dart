import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dulinan/src/features/category/domain/entities/category.dart';
import 'package:dulinan/src/features/category/domain/entities/pagination.dart';

part 'categories_response.freezed.dart';
part 'categories_response.g.dart';

@freezed
class CategoriesResponse with _$CategoriesResponse {
  factory CategoriesResponse({
    final String? status,
    final List<Category>? data,
    final Pagination? pagination,
  }) = _CategoriesResponse;

  factory CategoriesResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoriesResponseFromJson(json);
}
