import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int? id;
  final String? name;
  final String email;
  final String? role;
  final String password;
  final String? accessToken; // Token JWT
  final String? tokenType; // Tipe token (bearer)
  final int? expiresIn; // Waktu kedaluwarsa token

  const User({
    this.id,
    this.name,
    required this.email,
    this.role,
    required this.password,
    this.accessToken,
    this.tokenType,
    this.expiresIn,
  });

  @override
  List<Object?> get props {
    return [
      id,
      name,
      email,
      password,
      role,
      accessToken,
      tokenType,
      expiresIn,
    ];
  }

  // Convert User object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'role': role,
      'access_token': accessToken,
      'token_type': tokenType,
      'expires_in': expiresIn,
    };
  }

  factory User.fromJson(Map<String, dynamic>? json) {
    if (json == null || json['data'] == null) {
      throw Exception('User data is null');
    }
    final data = json['data'] as Map<String, dynamic>;
    return User(
      id: data['id'] as int,
      name: data['name'] as String,
      email: data['email'] as String,
      password: data['password'] as String,
      role: data['role'] as String,
      accessToken: json['access_token'] as String?,
      tokenType: json['token_type'] as String?,
      expiresIn: json['expires_in'] as int?,
    );
  }
  // Copy with method
  User copyWith({
    int? id,
    String? name,
    String? email,
    String? password,
    String? role,
    String? accessToken,
    String? tokenType,
    int? expiresIn,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      role: role ?? this.role,
      accessToken: accessToken ?? this.accessToken,
      tokenType: tokenType ?? this.tokenType,
      expiresIn: expiresIn ?? this.expiresIn,
    );
  }
}
