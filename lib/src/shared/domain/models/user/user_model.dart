import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int? id;
  final String? name;
  final String? email;
  final String? role;
  final dynamic noHp;
  final String? password;

  const User({
    this.id,
    this.name,
    this.email,
    this.role,
    this.noHp,
    this.password,
  });

  @override
  List<Object> get props {
    return [
      id!,
      name!,
      password!,
      email!,
      role!,
      noHp!,
    ];
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'password': password,
      'email': email,
      'role': role,
      'noHp': noHp
    };
  }

  factory User.fromJson(Map<String, dynamic> map) {
    return User(
        id: map['id'] as int,
        name: map['name'] as String,
        password: map['password'] as String,
        email: map['email'] as String,
        role: map['role'] as String,
        noHp: map['noHp'] as dynamic);
  }

  User copyWith({
    int? id,
    String? name,
    String? password,
    String? email,
    String? role,
    dynamic? noHp,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      password: password ?? this.password,
      email: email ?? this.email,
      role: role ?? this.role,
    );
  }
}
