import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:reading_book/features/explore/presentation/providers/explore_provider.dart';
import 'package:reading_book/features/explore/presentation/widgets/view_toggle_button.dart';
import 'package:reading_book/features/explore/presentation/widgets/story_grid_item.dart';
import 'package:reading_book/features/explore/presentation/widgets/story_list_item.dart';
import 'package:reading_book/features/story_api/presentation/providers/story_api_provider.dart';

/// Explore / Discover screen
/// Displays all available stories in grid or list view
class ExploreScreen extends ConsumerWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewMode = ref.watch(exploreViewModeProvider);
    // Use real API data instead of mock data
    final storiesAsync = ref.watch(fetchStoriesProvider);

    return Scaffold(
      appBar: _buildAppBar(context, ref, viewMode),
      body: storiesAsync.when(
        data: (stories) {
          if (stories.isEmpty) {
            return _buildEmptyState(context);
          }

          return viewMode == ViewMode.grid
              ? _buildGridView(context, stories)
              : _buildListView(context, stories);
        },
        loading: () => _buildLoadingState(context),
        error: (error, stackTrace) =>
            _buildErrorState(context, ref, error.toString()),
      ),
    );
  }

  /// Build app bar with title and view toggle button
  PreferredSizeWidget _buildAppBar(
    BuildContext context,
    WidgetRef ref,
    ViewMode viewMode,
  ) {
    return AppBar(
      title: const Text('Khám phá'),
      centerTitle: false,
      elevation: 0,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Center(
            child: ViewToggleButton(
              currentMode: viewMode,
              onModeChanged: (newMode) {
                ref.read(exploreViewModeProvider.notifier).state = newMode;
              },
            ),
          ),
        ),
      ],
    );
  }

  /// Build grid view layout (2 columns)
  Widget _buildGridView(BuildContext context, List stories) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.6,
      ),
      itemCount: stories.length,
      itemBuilder: (context, index) {
        final story = stories[index];
        return StoryGridItem(
          story: story,
          onTap: () {
            // Navigate to Story Detail screen
            context.pushNamed(
              'story_detail',
              pathParameters: {'storyId': story.id},
            );
          },
        );
      },
    );
  }

  /// Build list view layout
  Widget _buildListView(BuildContext context, List stories) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: stories.length,
      itemBuilder: (context, index) {
        final story = stories[index];
        return StoryListItem(
          story: story,
          onTap: () {
            // Navigate to Story Detail screen
            context.pushNamed(
              'story_detail',
              pathParameters: {'storyId': story.id},
            );
          },
        );
      },
    );
  }

  /// Build loading state with skeleton/shimmer
  Widget _buildLoadingState(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: List.generate(
          6,
          (index) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _SkeletonLoader(),
          ),
        ),
      ),
    );
  }

  /// Build empty state
  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.library_books_outlined,
            size: 64,
            color: Theme.of(context).primaryColor.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'Không tìm thấy truyện',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'Hãy quay lại sau để xem các truyện mới nhất',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  /// Build error state with retry functionality
  Widget _buildErrorState(BuildContext context, WidgetRef ref, String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.red.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'Có lỗi xảy ra',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              error,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              // Retry by refreshing the provider
              ref.refresh(fetchStoriesProvider);
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Thử lại'),
          ),
        ],
      ),
    );
  }
}

/// Simple skeleton loader for loading state
class _SkeletonLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: 110,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: isDark ? Colors.grey[800] : Colors.grey[200],
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 110,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              color: isDark ? Colors.grey[700] : Colors.grey[300],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 16,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: isDark ? Colors.grey[700] : Colors.grey[300],
                    ),
                  ),
                  Container(
                    height: 12,
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: isDark ? Colors.grey[700] : Colors.grey[300],
                    ),
                  ),
                  Container(
                    height: 12,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: isDark ? Colors.grey[700] : Colors.grey[300],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
