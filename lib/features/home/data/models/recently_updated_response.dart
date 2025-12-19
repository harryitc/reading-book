import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'recently_updated_response.g.dart';

/// Recently updated story API response model
@JsonSerializable()
class RecentlyUpdatedResponse {
  final String id;
  final String title;
  @JsonKey(name: 'latestChapter')
  final String latestChapter;
  @JsonKey(name: 'latestTime')
  final String latestTime;
  final List<String> genres;

  const RecentlyUpdatedResponse({
    required this.id,
    required this.title,
    required this.latestChapter,
    required this.latestTime,
    required this.genres,
  });

  factory RecentlyUpdatedResponse.fromJson(Map<String, dynamic> json) {
    return _$RecentlyUpdatedResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$RecentlyUpdatedResponseToJson(this);

  @override
  String toString() =>
      'RecentlyUpdatedResponse(id: $id, title: $title, latestChapter: $latestChapter)';
}
