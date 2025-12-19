import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/hot_stories_provider.dart';
import '../providers/recently_updated_provider.dart';
import '../providers/completed_stories_provider.dart';
import '../widgets/horizontal_story_card.dart';
import '../widgets/story_list_item.dart';
import '../../../../core/widgets/skeleton_loader.dart';

/// Home screen for the StoryNest app
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hotStories = ref.watch(hotStoriesProvider);
    final recentlyUpdated = ref.watch(recentlyUpdatedProvider);
    final completedStories = ref.watch(completedStoriesProvider);

    return Scaffold(
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Search bar
            SliverToBoxAdapter(child: _buildSearchBar(context)),

            // Hot Stories Section
            SliverToBoxAdapter(
              child: _buildSectionHeader(context, '🔥 Hot Stories'),
            ),
            hotStories.when(
              data: (stories) {
                if (stories.isEmpty) {
                  return SliverToBoxAdapter(
                    child: _buildEmptyState(
                      context,
                      'No hot stories available',
                    ),
                  );
                }
                return SliverToBoxAdapter(
                  child: SizedBox(
                    height: 260,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: stories.length,
                      itemBuilder: (context, index) {
                        final story = stories[index];
                        return Padding(
                          padding: EdgeInsets.only(
                            right: index == stories.length - 1 ? 0 : 12,
                          ),
                          child: HorizontalStoryCard(
                            story: story,
                            isLarge: true,
                            onTap: () => context.push('/reader/${story.id}'),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
              loading: () => SliverToBoxAdapter(
                child: SizedBox(
                  height: 260,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(right: index == 2 ? 0 : 12),
                        child: HorizontalStoryCardSkeleton(isLarge: true),
                      );
                    },
                  ),
                ),
              ),
              error: (error, stack) => SliverToBoxAdapter(
                child: _buildErrorState(context, error.toString()),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 24)),

            // Recently Updated Section
            SliverToBoxAdapter(
              child: _buildSectionHeader(context, '🆕 Recently Updated'),
            ),
            recentlyUpdated.when(
              data: (stories) {
                if (stories.isEmpty) {
                  return SliverToBoxAdapter(
                    child: _buildEmptyState(
                      context,
                      'No recently updated stories',
                    ),
                  );
                }
                return SliverToBoxAdapter(
                  child: SizedBox(
                    height: 220,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: stories.length,
                      itemBuilder: (context, index) {
                        final story = stories[index];
                        return Padding(
                          padding: EdgeInsets.only(
                            right: index == stories.length - 1 ? 0 : 12,
                          ),
                          child: HorizontalStoryCard(
                            story: story,
                            isLarge: false,
                            showLatestChapter: true,
                            onTap: () => context.push('/reader/${story.id}'),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
              loading: () => SliverToBoxAdapter(
                child: SizedBox(
                  height: 220,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(right: index == 2 ? 0 : 12),
                        child: HorizontalStoryCardSkeleton(isLarge: false),
                      );
                    },
                  ),
                ),
              ),
              error: (error, stack) => SliverToBoxAdapter(
                child: _buildErrorState(context, error.toString()),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 24)),

            // Completed Stories Section
            SliverToBoxAdapter(
              child: _buildSectionHeader(context, '✅ Completed Stories'),
            ),
            completedStories.when(
              data: (stories) {
                if (stories.isEmpty) {
                  return SliverToBoxAdapter(
                    child: _buildEmptyState(
                      context,
                      'No completed stories available',
                    ),
                  );
                }
                return SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final story = stories[index];
                    return StoryListItem(
                      story: story,
                      onTap: () => context.push('/reader/${story.id}'),
                    );
                  }, childCount: stories.length),
                );
              },
              loading: () => SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => const StoryListItemSkeleton(),
                  childCount: 5,
                ),
              ),
              error: (error, stack) => SliverToBoxAdapter(
                child: _buildErrorState(context, error.toString()),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 32)),
          ],
        ),
      ),
    );
  }

  /// Build custom app bar
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      elevation: 0,
      backgroundColor: theme.colorScheme.surface,
      title: Text(
        '📚 StoryNest',
        style: theme.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
          color: theme.colorScheme.primary,
        ),
      ),
      centerTitle: false,
      actions: [
        IconButton(
          icon: const Icon(Icons.search_rounded),
          onPressed: () {
            // TODO: Navigate to search screen
          },
        ),
        IconButton(
          icon: const Icon(Icons.account_circle_rounded),
          onPressed: () {
            // TODO: Navigate to profile screen
          },
        ),
      ],
    );
  }

  /// Build search bar
  Widget _buildSearchBar(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search stories, authors...',
          prefixIcon: const Icon(Icons.search_rounded),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear_rounded),
                  onPressed: () {
                    _searchController.clear();
                    setState(() {});
                  },
                )
              : null,
          filled: true,
          fillColor: theme.colorScheme.surfaceContainerHighest.withValues(
            alpha: 0.5,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
        onChanged: (value) {
          setState(() {});
          // TODO: Implement search functionality
          // if (value.isNotEmpty) {
          //   ref.read(searchStoriesProvider.notifier).search(value);
          // }
        },
      ),
    );
  }

  /// Build section header
  Widget _buildSectionHeader(BuildContext context, String title) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          TextButton(
            onPressed: () {
              // TODO: Navigate to section view
            },
            child: const Text('See All'),
          ),
        ],
      ),
    );
  }

  /// Build empty state
  Widget _buildEmptyState(BuildContext context, String message) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.library_books_rounded,
              size: 64,
              color: theme.colorScheme.primary.withValues(alpha: 0.3),
            ),
            const SizedBox(height: 12),
            Text(
              message,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build error state
  Widget _buildErrorState(BuildContext context, String error) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 64,
              color: theme.colorScheme.error.withValues(alpha: 0.7),
            ),
            const SizedBox(height: 12),
            Text(
              'Oops! Something went wrong',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Retry'),
              onPressed: () {
                // Trigger reload
                ref.invalidate(hotStoriesProvider);
                ref.invalidate(recentlyUpdatedProvider);
                ref.invalidate(completedStoriesProvider);
              },
            ),
          ],
        ),
      ),
    );
  }
}
