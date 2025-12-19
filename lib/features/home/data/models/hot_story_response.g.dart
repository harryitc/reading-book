// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hot_story_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HotStoryResponse _$HotStoryResponseFromJson(Map<String, dynamic> json) =>
    HotStoryResponse(
      id: json['id'] as String,
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String,
      imageAlt: json['imageAlt'] as String,
      isFull: json['is_full'] as bool,
    );

Map<String, dynamic> _$HotStoryResponseToJson(HotStoryResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'imageUrl': instance.imageUrl,
      'imageAlt': instance.imageAlt,
      'is_full': instance.isFull,
    };
