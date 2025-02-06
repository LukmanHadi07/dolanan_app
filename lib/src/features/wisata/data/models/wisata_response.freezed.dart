// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wisata_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WisataResponse _$WisataResponseFromJson(Map<String, dynamic> json) {
  return _WisataResponse.fromJson(json);
}

/// @nodoc
mixin _$WisataResponse {
  String? get status => throw _privateConstructorUsedError;
  List<Wisata>? get data => throw _privateConstructorUsedError;
  Pagination? get pagination => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WisataResponseCopyWith<WisataResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WisataResponseCopyWith<$Res> {
  factory $WisataResponseCopyWith(
          WisataResponse value, $Res Function(WisataResponse) then) =
      _$WisataResponseCopyWithImpl<$Res, WisataResponse>;
  @useResult
  $Res call({String? status, List<Wisata>? data, Pagination? pagination});
}

/// @nodoc
class _$WisataResponseCopyWithImpl<$Res, $Val extends WisataResponse>
    implements $WisataResponseCopyWith<$Res> {
  _$WisataResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
    Object? data = freezed,
    Object? pagination = freezed,
  }) {
    return _then(_value.copyWith(
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<Wisata>?,
      pagination: freezed == pagination
          ? _value.pagination
          : pagination // ignore: cast_nullable_to_non_nullable
              as Pagination?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WisataResponseImplCopyWith<$Res>
    implements $WisataResponseCopyWith<$Res> {
  factory _$$WisataResponseImplCopyWith(_$WisataResponseImpl value,
          $Res Function(_$WisataResponseImpl) then) =
      __$$WisataResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? status, List<Wisata>? data, Pagination? pagination});
}

/// @nodoc
class __$$WisataResponseImplCopyWithImpl<$Res>
    extends _$WisataResponseCopyWithImpl<$Res, _$WisataResponseImpl>
    implements _$$WisataResponseImplCopyWith<$Res> {
  __$$WisataResponseImplCopyWithImpl(
      _$WisataResponseImpl _value, $Res Function(_$WisataResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
    Object? data = freezed,
    Object? pagination = freezed,
  }) {
    return _then(_$WisataResponseImpl(
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<Wisata>?,
      pagination: freezed == pagination
          ? _value.pagination
          : pagination // ignore: cast_nullable_to_non_nullable
              as Pagination?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WisataResponseImpl implements _WisataResponse {
  _$WisataResponseImpl({this.status, final List<Wisata>? data, this.pagination})
      : _data = data;

  factory _$WisataResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$WisataResponseImplFromJson(json);

  @override
  final String? status;
  final List<Wisata>? _data;
  @override
  List<Wisata>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final Pagination? pagination;

  @override
  String toString() {
    return 'WisataResponse(status: $status, data: $data, pagination: $pagination)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WisataResponseImpl &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.pagination, pagination) ||
                other.pagination == pagination));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, status,
      const DeepCollectionEquality().hash(_data), pagination);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WisataResponseImplCopyWith<_$WisataResponseImpl> get copyWith =>
      __$$WisataResponseImplCopyWithImpl<_$WisataResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WisataResponseImplToJson(
      this,
    );
  }
}

abstract class _WisataResponse implements WisataResponse {
  factory _WisataResponse(
      {final String? status,
      final List<Wisata>? data,
      final Pagination? pagination}) = _$WisataResponseImpl;

  factory _WisataResponse.fromJson(Map<String, dynamic> json) =
      _$WisataResponseImpl.fromJson;

  @override
  String? get status;
  @override
  List<Wisata>? get data;
  @override
  Pagination? get pagination;
  @override
  @JsonKey(ignore: true)
  _$$WisataResponseImplCopyWith<_$WisataResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
