import 'package:flutter/material.dart';
import 'package:reading_book/features/home/domain/models/story.dart';

/// Reusable list item widget for story display
/// Shows cover image, title, author, status, and latest chapter
class StoryListItem extends StatelessWidget {
  final Story story;
  final VoidCallback onTap;

  const StoryListItem({
    super.key,
    required this.story,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isDark ? Colors.grey[850] : Colors.grey[100],
          border: Border.all(
            color: isDark ? Colors.grey[700]! : Colors.grey[300]!,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            /// Cover image
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              child: Container(
                width: 80,
                height: 110,
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
                            child: Icon(
                              Icons.image_not_supported_outlined,
                              color: isDark
                                  ? Colors.grey[600]
                                  : Colors.grey[500],
                            ),
                          );
                        },
                        loadingBuilder: (context, child, loadingProgress) {
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
                    : Icon(
                        Icons.image_outlined,
                        color: isDark
                            ? Colors.grey[600]
                            : Colors.grey[500],
                      ),
              ),
            ),

            /// Content section
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /// Title
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

                    /// Author
                    Text(
                      'Tác giả: ${story.author}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: isDark ? Colors.grey[400] : Colors.grey[600],
                          ),
                    ),

                    const SizedBox(height: 4),

                    /// Status badge and latest chapter
                    Row(
                      children: [
                        /// Status badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: story.status == StoryStatus.ongoing
                                ? (isDark
                                    ? Colors.blue[700]
                                    : Colors.blue[400])
                                : (isDark
                                    ? Colors.green[700]
                                    : Colors.green[400]),
                          ),
                          child: Text(
                            story.status == StoryStatus.ongoing
                                ? 'Đang ra'
                                : 'Hoàn thành',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        const SizedBox(width: 8),

                        /// Latest chapter
                        Text(
                          'Ch.${story.latestChapter}',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: isDark
                                    ? Colors.grey[400]
                                    : Colors.grey[600],
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            /// Trailing chevron
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Icon(
                Icons.chevron_right,
                color: isDark ? Colors.grey[600] : Colors.grey[400],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
