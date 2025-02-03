import 'package:dulinan/src/features/category/data/models/categories_response.dart';
import 'package:dulinan/src/shared/exceptions/http_exceptions.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_state.freezed.dart';

@freezed
class CategoryState with _$CategoryState {
  const factory CategoryState.initial() = Initial;
  const factory CategoryState.loading() = Loading;
  const factory CategoryState.success(CategoriesResponse categories) = Success;
  const factory CategoryState.error(AppExceptions exception) = Failure;
}
