// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'completed_story_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompletedStoryResponse _$CompletedStoryResponseFromJson(
        Map<String, dynamic> json) =>
    CompletedStoryResponse(
      id: json['id'] as String,
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String,
      isFull: json['is_full'] as bool,
      chapters: json['chapters'] as int,
    );

Map<String, dynamic> _$CompletedStoryResponseToJson(
        CompletedStoryResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'imageUrl': instance.imageUrl,
      'isFull': instance.isFull,
      'chapters': instance.chapters,
    };
