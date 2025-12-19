import 'package:flutter/material.dart';
import '../../domain/models/story.dart';

/// Horizontal story card for featured/recently updated sections
class HorizontalStoryCard extends StatelessWidget {
  final Story story;
  final VoidCallback onTap;
  final bool isLarge;
  final bool showLatestChapter;

  const HorizontalStoryCard({
    Key? key,
    required this.story,
    required this.onTap,
    this.isLarge = true,
    this.showLatestChapter = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardWidth = isLarge ? 180.0 : 140.0;
    final cardHeight = isLarge ? 240.0 : 200.0;

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: cardWidth,
        height: cardHeight,
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Background image
              Container(
                color: theme.colorScheme.primary.withOpacity(0.1),
                child: story.coverImageUrl != null
                    ? Image.network(
                        story.coverImageUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return _buildPlaceholder(context);
                        },
                      )
                    : _buildPlaceholder(context),
              ),

              // Gradient overlay (bottom to top)
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.8),
                        Colors.black.withOpacity(0.4),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),

              // Content
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Title
                      Text(
                        story.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: isLarge ? 14 : 12,
                        ),
                      ),
                      if (isLarge) const SizedBox(height: 8),
                      
                      // Status badge + Latest chapter
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Status badge
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: story.status == StoryStatus.full
                                  ? Colors.green
                                  : Colors.orange,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              story.status == StoryStatus.full ? 'FULL' : 'ONGOING',
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          
                          // Latest chapter (if enabled)
                          if (showLatestChapter)
                            Text(
                              'Ch ${story.latestChapter}',
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: Colors.white70,
                                fontSize: 10,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholder(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: theme.colorScheme.primary.withOpacity(0.2),
      child: Center(
        child: Icon(
          Icons.book,
          size: isLarge ? 48 : 40,
          color: theme.colorScheme.primary.withOpacity(0.5),
        ),
      ),
    );
  }
}
