import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final int? id;
  final String? categoryName;

  const Category({
    this.id,
    this.categoryName,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        categoryName: json["category_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_name": categoryName,
      };
  @override
  List<Object?> get props => [
        id,
        categoryName,
      ];
}
