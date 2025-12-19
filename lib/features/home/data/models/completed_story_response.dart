import 'package:json_annotation/json_annotation.dart';

part 'completed_story_response.g.dart';

/// Completed story API response model
@JsonSerializable()
class CompletedStoryResponse {
  final String id;
  final String title;
  @JsonKey(name: 'imageUrl')
  final String imageUrl;
  @JsonKey(name: 'is_full')
  final bool isFull;
  final int chapters;

  const CompletedStoryResponse({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.isFull,
    required this.chapters,
  });

  factory CompletedStoryResponse.fromJson(Map<String, dynamic> json) =>
      _$CompletedStoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CompletedStoryResponseToJson(this);

  @override
  String toString() =>
      'CompletedStoryResponse(id: $id, title: $title, chapters: $chapters)';
}
