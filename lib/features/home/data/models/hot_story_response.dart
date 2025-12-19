import 'package:json_annotation/json_annotation.dart';

part 'hot_story_response.g.dart';

/// Hot story API response model
@JsonSerializable()
class HotStoryResponse {
  final String id;
  final String title;
  @JsonKey(name: 'imageUrl')
  final String imageUrl;
  @JsonKey(name: 'imageAlt')
  final String imageAlt;
  @JsonKey(name: 'is_full')
  final bool isFull;

  const HotStoryResponse({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.imageAlt,
    required this.isFull,
  });

  factory HotStoryResponse.fromJson(Map<String, dynamic> json) =>
      _$HotStoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HotStoryResponseToJson(this);

  @override
  String toString() =>
      'HotStoryResponse(id: $id, title: $title, isFull: $isFull)';
}
