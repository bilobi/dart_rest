// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsModel _$NewsModelFromJson(Map<String, dynamic> json) => NewsModel(
      id: json['id'] as int?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      image: json['image'] as String?,
      dtPublishing: json['dtPublishing'] == null
          ? null
          : DateTime.parse(json['dtPublishing'] as String),
      dtUpdating: json['dtUpdating'] == null
          ? null
          : DateTime.parse(json['dtUpdating'] as String),
    );

Map<String, dynamic> _$NewsModelToJson(NewsModel instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'image': instance.image,
      'dtPublishing': instance.dtPublishing?.toIso8601String(),
      'dtUpdating': instance.dtUpdating?.toIso8601String(),
    };
