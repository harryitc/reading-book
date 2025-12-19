// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recently_updated_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecentlyUpdatedResponse _$RecentlyUpdatedResponseFromJson(
        Map<String, dynamic> json) =>
    RecentlyUpdatedResponse(
      id: json['id'] as String,
      title: json['title'] as String,
      latestChapter: json['latestChapter'] as String,
      latestTime: json['latestTime'] as String,
      genres: List<String>.from(json['genres'] as List),
    );

Map<String, dynamic> _$RecentlyUpdatedResponseToJson(
        RecentlyUpdatedResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'latestChapter': instance.latestChapter,
      'latestTime': instance.latestTime,
      'genres': instance.genres,
    };
