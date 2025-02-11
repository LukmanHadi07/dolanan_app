import 'package:dulinan/src/features/user/domain/entities/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_response.freezed.dart';
part 'user_response.g.dart';

@freezed
class UserResponse with _$UserResponse {
  factory UserResponse({
    final bool? success,
    final String? message,
    final User? data,
    final String? accessToken,
    final String? refreshToken,
    final String? tokenType,
    final int? expiresIn,
    final String? expiresAt,
    final String? role,
  }) = _UserResponse;

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);
}
