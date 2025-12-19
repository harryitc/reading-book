/// Response model from /truyen/query API endpoint
class ApiStoryResponse {
  final String id;
  final String imageSrc;
  final String? imageAlt;
  final String title;
  final String author;
  final List<String> badge;
  final int latestChapter;

  const ApiStoryResponse({
    required this.id,
    required this.imageSrc,
    this.imageAlt,
    required this.title,
    required this.author,
    required this.badge,
    required this.latestChapter,
  });

  /// Create from JSON response
  factory ApiStoryResponse.fromJson(Map<String, dynamic> json) {
    return ApiStoryResponse(
      id: json['id'] as String? ?? '',
      imageSrc: json['image_src'] as String? ?? '',
      imageAlt: json['image_alt'] as String?,
      title: json['title'] as String? ?? 'Unknown',
      author: json['author'] as String? ?? 'Unknown',
      badge: List<String>.from(json['badge'] as List? ?? []),
      latestChapter: json['latest_chapter'] as int? ?? 0,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() => {
        'id': id,
        'image_src': imageSrc,
        'image_alt': imageAlt,
        'title': title,
        'author': author,
        'badge': badge,
        'latest_chapter': latestChapter,
      };

  /// Convert API response to domain Story model
  /// This is used internally - maps API structure to app domain model
  Map<String, dynamic> toDomainJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'description': 'Tập mới nhất: Chương $latestChapter',
      'coverImageUrl': imageSrc,
      'content': '',
      'genres': _parseBadgesAsGenres(),
      'rating': _getDefaultRating(),
      'totalChapters': latestChapter,
      'latestChapter': latestChapter,
      'publishedAt': DateTime.now().subtract(const Duration(days: 30)).toIso8601String(),
      'updatedAt': DateTime.now().toIso8601String(),
      'status': _parseStatus(),
    };
  }

  /// Parse badges as genres
  List<String> _parseBadgesAsGenres() {
    // Default genres
    const defaultGenres = ['Huyền Huyễn', 'Tiên Hiệp', 'Phiêu Lưu'];

    if (badge.isEmpty) {
      return defaultGenres;
    }

    // Map badges to genres if needed
    final genres = <String>[...defaultGenres];

    if (badge.contains('hot')) {
      // Hot stories might be action genre
    }

    return genres;
  }

  /// Get default rating based on badges
  double _getDefaultRating() {
    // Hot stories get higher rating
    if (badge.contains('hot')) {
      return 4.7;
    }
    if (badge.contains('full')) {
      return 4.5;
    }
    return 4.3;
  }

  /// Parse status from badges
  String _parseStatus() {
    if (badge.contains('full')) {
      return 'full';
    }
    return 'ongoing';
  }

  @override
  String toString() =>
      'ApiStoryResponse(id: $id, title: $title, author: $author, chapters: $latestChapter, badges: $badge)';
}
