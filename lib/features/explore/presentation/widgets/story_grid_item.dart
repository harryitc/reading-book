import 'package:flutter/material.dart';
import 'package:reading_book/features/home/domain/models/story.dart';

/// Reusable grid item widget for story display
/// Shows cover image, title, and status badge
class StoryGridItem extends StatelessWidget {
  final Story story;
  final VoidCallback onTap;

  const StoryGridItem({
    super.key,
    required this.story,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Cover image with status badge
          Stack(
            children: [
              /// Cover image
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: double.infinity,
                  height: 200,
                  color: isDark ? Colors.grey[800] : Colors.grey[300],
                  child: story.coverImageUrl != null
                      ? Image.network(
                          story.coverImageUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: isDark
                                  ? Colors.grey[800]
                                  : Colors.grey[300],
                              child: Center(
                                child: Icon(
                                  Icons.image_not_supported_outlined,
                                  color: isDark
                                      ? Colors.grey[600]
                                      : Colors.grey[500],
                                ),
                              ),
                            );
                          },
                          loadingBuilder:
                              (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              color: isDark
                                  ? Colors.grey[800]
                                  : Colors.grey[300],
                              child: const Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                            );
                          },
                        )
                      : Container(
                          color: isDark
                              ? Colors.grey[800]
                              : Colors.grey[300],
                          child: Icon(
                            Icons.image_outlined,
                            color: isDark
                                ? Colors.grey[600]
                                : Colors.grey[500],
                          ),
                        ),
                ),
              ),

              /// Status badge
              Positioned(
                top: 8,
                right: 8,
                child: _StatusBadge(status: story.status),
              ),
            ],
          ),

          const SizedBox(height: 8),

          /// Title (1-2 lines)
          Text(
            story.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black87,
                ),
          ),

          const SizedBox(height: 4),

          /// Author name
          Text(
            story.author,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                ),
          ),
        ],
      ),
    );
  }
}

/// Status badge widget (FULL / ONGOING)
class _StatusBadge extends StatelessWidget {
  final StoryStatus status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isOngoing = status == StoryStatus.ongoing;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: isOngoing
            ? (isDark ? Colors.blue[700] : Colors.blue[400])
            : (isDark ? Colors.green[700] : Colors.green[400]),
      ),
      child: Text(
        isOngoing ? 'Đang ra' : 'Hoàn thành',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
