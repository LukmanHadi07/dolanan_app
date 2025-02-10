import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int? id;
  final String? name;
  final String? email;
  final String? role;
  final dynamic noHp;
  final dynamic profileImage;
  final dynamic alamat;

  const User({
    this.id,
    this.name,
    this.email,
    this.role,
    this.noHp,
    this.profileImage,
    this.alamat,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        role: json["role"],
        noHp: json["noHp"],
        profileImage: json["profileImage"],
        alamat: json["alamat"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "role": role,
        "noHp": noHp,
        "profileImage": profileImage,
        "alamat": alamat,
      };

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        role,
        noHp,
        profileImage,
        alamat,
      ];
}
