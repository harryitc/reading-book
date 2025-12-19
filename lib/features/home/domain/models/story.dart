/// Story status enum
enum StoryStatus { full, ongoing }

/// Story model representing a story/book item
class Story {
  final String id;
  final String title;
  final String author;
  final String description;
  final String? coverImageUrl;
  final String content;
  final List<String> genres;
  final double rating;
  final int totalChapters;
  final int latestChapter;
  final DateTime publishedAt;
  final DateTime? updatedAt;
  final StoryStatus status;

  const Story({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    this.coverImageUrl,
    required this.content,
    required this.genres,
    required this.rating,
    required this.totalChapters,
    this.latestChapter = 1,
    required this.publishedAt,
    this.updatedAt,
    this.status = StoryStatus.ongoing,
  });

  /// Copy with method for immutability
  Story copyWith({
    String? id,
    String? title,
    String? author,
    String? description,
    String? coverImageUrl,
    String? content,
    List<String>? genres,
    double? rating,
    int? totalChapters,
    int? latestChapter,
    DateTime? publishedAt,
    DateTime? updatedAt,
    StoryStatus? status,
  }) {
    return Story(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      description: description ?? this.description,
      coverImageUrl: coverImageUrl ?? this.coverImageUrl,
      content: content ?? this.content,
      genres: genres ?? this.genres,
      rating: rating ?? this.rating,
      totalChapters: totalChapters ?? this.totalChapters,
      latestChapter: latestChapter ?? this.latestChapter,
      publishedAt: publishedAt ?? this.publishedAt,
      updatedAt: updatedAt ?? this.updatedAt,
      status: status ?? this.status,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'description': description,
      'coverImageUrl': coverImageUrl,
      'content': content,
      'genres': genres,
      'rating': rating,
      'totalChapters': totalChapters,
      'latestChapter': latestChapter,
      'publishedAt': publishedAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'status': status.name,
    };
  }

  /// Create from JSON
  factory Story.fromJson(Map<String, dynamic> json) {
    return Story(
      id: json['id'] as String,
      title: json['title'] as String,
      author: json['author'] as String,
      description: json['description'] as String,
      coverImageUrl: json['coverImageUrl'] as String?,
      content: json['content'] as String? ?? '',
      genres: List<String>.from(json['genres'] as List? ?? []),
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      totalChapters: json['totalChapters'] as int? ?? 1,
      latestChapter: json['latestChapter'] as int? ?? 1,
      publishedAt: DateTime.parse(json['publishedAt'] as String),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
      status: json['status'] != null
          ? StoryStatus.values.byName(json['status'] as String)
          : StoryStatus.ongoing,
    );
  }

  @override
  String toString() =>
      'Story(id: $id, title: $title, author: $author, rating: $rating)';
}
