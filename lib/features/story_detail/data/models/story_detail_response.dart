/// Genre model from API response
class GenreResponse {
  final String ten; // genre name
  final String url; // genre URL

  const GenreResponse({
    required this.ten,
    required this.url,
  });

  factory GenreResponse.fromJson(Map<String, dynamic> json) {
    return GenreResponse(
      ten: json['ten'] as String? ?? 'Unknown',
      url: json['url'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'ten': ten,
        'url': url,
      };

  @override
  String toString() => 'GenreResponse(ten: $ten)';
}

/// Chapter model from latest_chapters array
class ChapterResponse {
  final String ten; // chapter name (e.g. "Chương 680")
  final String id; // chapter id
  final String url; // chapter URL

  const ChapterResponse({
    required this.ten,
    required this.id,
    required this.url,
  });

  factory ChapterResponse.fromJson(Map<String, dynamic> json) {
    return ChapterResponse(
      ten: json['ten'] as String? ?? 'Unknown',
      id: json['id'] as String? ?? '',
      url: json['url'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'ten': ten,
        'id': id,
        'url': url,
      };

  @override
  String toString() => 'ChapterResponse(ten: $ten)';
}

/// Rating model from API response
class RatingResponse {
  final double value; // rating value (e.g. 8.5)
  final int count; // number of ratings (e.g. 13)
  final int max; // max rating (usually 10)

  const RatingResponse({
    required this.value,
    required this.count,
    required this.max,
  });

  factory RatingResponse.fromJson(Map<String, dynamic> json) {
    return RatingResponse(
      value: (json['value'] as num?)?.toDouble() ?? 0.0,
      count: json['count'] as int? ?? 0,
      max: json['max'] as int? ?? 10,
    );
  }

  Map<String, dynamic> toJson() => {
        'value': value,
        'count': count,
        'max': max,
      };

  @override
  String toString() => 'RatingResponse(value: $value, count: $count)';
}

/// Story Detail API Response model
/// Maps API response from /truyen/get-one?id={storyId}
class StoryDetailResponse {
  final String id;
  final String imageSrc;
  final String? imageAlt;
  final String title;
  final String description;
  final String author;
  final List<GenreResponse> genres;
  final List<ChapterResponse> latestChapters;
  final String chapters;
  final RatingResponse rating;
  final String status;

  const StoryDetailResponse({
    required this.id,
    required this.imageSrc,
    this.imageAlt,
    required this.title,
    required this.description,
    required this.author,
    required this.genres,
    required this.latestChapters,
    required this.chapters,
    required this.rating,
    required this.status,
  });

  /// Create from JSON response
  factory StoryDetailResponse.fromJson(Map<String, dynamic> json) {
    final genresList = (json['genres'] as List?)
            ?.map((g) => GenreResponse.fromJson(g as Map<String, dynamic>))
            .toList() ??
        [];

    final chaptersList = (json['latest_chapters'] as List?)
            ?.map((c) => ChapterResponse.fromJson(c as Map<String, dynamic>))
            .toList() ??
        [];

    final ratingData = json['rating'] as Map<String, dynamic>?;
    final rating = ratingData != null
        ? RatingResponse.fromJson(ratingData)
        : const RatingResponse(value: 0.0, count: 0, max: 10);

    return StoryDetailResponse(
      id: json['id'] as String? ?? '',
      imageSrc: json['image_src'] as String? ?? '',
      imageAlt: json['image_alt'] as String?,
      title: json['title'] as String? ?? 'Unknown',
      description: json['description'] as String? ?? '',
      author: json['author'] as String? ?? 'Unknown',
      genres: genresList,
      latestChapters: chaptersList,
      chapters: json['chapters'] as String? ?? '',
      rating: rating,
      status: json['status'] as String? ?? 'Đang ra',
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() => {
        'id': id,
        'image_src': imageSrc,
        'image_alt': imageAlt,
        'title': title,
        'description': description,
        'author': author,
        'genres': genres.map((g) => g.toJson()).toList(),
        'latest_chapters': latestChapters.map((c) => c.toJson()).toList(),
        'chapters': chapters,
        'rating': rating.toJson(),
        'status': status,
      };

  /// Get genre names as list
  List<String> getGenreNames() => genres.map((g) => g.ten).toList();

  /// Get latest chapter name
  String? getLatestChapterName() =>
      latestChapters.isNotEmpty ? latestChapters.first.ten : null;

  /// Get rating percentage (0-100)
  double getRatingPercentage() =>
      (rating.value / rating.max) * 100;

  @override
  String toString() =>
      'StoryDetailResponse(id: $id, title: $title, author: $author, genres: ${genres.length}, chapters: ${latestChapters.length}, status: $status)';
}
