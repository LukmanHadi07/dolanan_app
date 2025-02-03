import 'dart:convert';

import 'package:dulinan/src/features/category/domain/entities/category.dart';
import 'package:dulinan/src/features/category/domain/entities/pagination.dart';

CategoriesResponse categoriesResponseFromJson(String str) =>
    CategoriesResponse.fromJson(json.decode(str));

String categoriesResponseToJson(CategoriesResponse data) =>
    json.encode(data.toJson());

class CategoriesResponse {
  final String? status;
  final List<Category>? data;
  final Pagination? pagination;

  CategoriesResponse({
    this.status,
    this.data,
    this.pagination,
  });

  factory CategoriesResponse.fromJson(Map<String, dynamic> json) =>
      CategoriesResponse(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<Category>.from(
                json["data"]!.map((x) => Category.fromJson(x))),
        pagination: json["pagination"] == null
            ? null
            : Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "pagination": pagination?.toJson(),
      };
}
