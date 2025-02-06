// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wisata_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WisataResponseImpl _$$WisataResponseImplFromJson(Map<String, dynamic> json) =>
    _$WisataResponseImpl(
      status: json['status'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Wisata.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$WisataResponseImplToJson(
        _$WisataResponseImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'pagination': instance.pagination,
    };
