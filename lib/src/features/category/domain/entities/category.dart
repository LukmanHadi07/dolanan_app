import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final int? id;
  final String? categoryName;
  final String? categoryImage;

  const Category({this.id, this.categoryName, this.categoryImage});

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        categoryName: json["category_name"],
        categoryImage: json["category_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_name": categoryName,
        "category_image": categoryImage,
      };
  @override
  List<Object?> get props => [
        id,
        categoryName,
        categoryImage,
      ];
}
