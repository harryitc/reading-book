import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/reader_provider.dart';
import '../../../home/presentation/providers/story_provider.dart';

/// Reader screen for reading stories with adjustable settings
class ReaderScreen extends ConsumerStatefulWidget {
  final String storyId;

  const ReaderScreen({
    Key? key,
    required this.storyId,
  }) : super(key: key);

  @override
  ConsumerState<ReaderScreen> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends ConsumerState<ReaderScreen> {
  late ScrollController _scrollController;
  bool _showControls = true;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    // Load reader settings
    ref.read(readerSettingsProvider.notifier).loadSettings();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    // Auto-hide controls when scrolling
    if (_showControls) {
      setState(() => _showControls = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final storyAsync = ref.watch(storyProvider(widget.storyId));
    final settings = ref.watch(readerSettingsProvider);

    return Scaffold(
      body: storyAsync.when(
        data: (story) {
          if (story == null) {
            return Center(
              child: Text(
                'Story not found',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            );
          }

          return Container(
            color: settings.isDarkMode
                ? Theme.of(context).colorScheme.background
                : Theme.of(context).colorScheme.surface,
            child: SafeArea(
              child: Stack(
                children: [
                  // Main reading area
                  SingleChildScrollView(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Story header
                        Text(
                          story.title,
                          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                                fontSize: settings.fontSize + 4,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'by ${story.author}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 24),

                        // Story content
                        Text(
                          story.content,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                fontSize: settings.fontSize,
                                height: 1.8,
                              ),
                        ),
                        const SizedBox(height: 48),
                      ],
                    ),
                  ),

                  // Reader controls
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: AnimatedOpacity(
                      opacity: _showControls ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 300),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          border: Border(
                            top: BorderSide(
                              color: Theme.of(context)
                                  .colorScheme
                                  .outline
                                  .withOpacity(0.2),
                            ),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Font size controls
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                // Decrease font
                                IconButton(
                                  icon: const Icon(Icons.remove_circle_outline),
                                  onPressed: () {
                                    ref
                                        .read(readerSettingsProvider.notifier)
                                        .decreaseFontSize();
                                  },
                                ),

                                // Font size display
                                Column(
                                  children: [
                                    Text(
                                      'Font Size',
                                      style:
                                          Theme.of(context).textTheme.labelSmall,
                                    ),
                                    Text(
                                      '${settings.fontSize.toStringAsFixed(0)}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall,
                                    ),
                                  ],
                                ),

                                // Increase font
                                IconButton(
                                  icon: const Icon(Icons.add_circle_outline),
                                  onPressed: () {
                                    ref
                                        .read(readerSettingsProvider.notifier)
                                        .increaseFontSize();
                                  },
                                ),

                                // Dark mode toggle
                                IconButton(
                                  icon: Icon(
                                    settings.isDarkMode
                                        ? Icons.light_mode
                                        : Icons.dark_mode,
                                  ),
                                  onPressed: () {
                                    ref
                                        .read(readerSettingsProvider.notifier)
                                        .toggleDarkMode();
                                  },
                                ),

                                // Close reader
                                IconButton(
                                  icon: const Icon(Icons.close),
                                  onPressed: () {
                                    context.go('/main/home');
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Tap to show controls
                  if (!_showControls)
                    Positioned.fill(
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          setState(() => _showControls = true);
                          Future.delayed(const Duration(seconds: 3), () {
                            if (mounted) {
                              setState(() => _showControls = false);
                            }
                          });
                        },
                        child: Container(color: Colors.transparent),
                      ),
                    ),

                  // Top app bar
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: AnimatedOpacity(
                      opacity: _showControls ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 300),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          border: Border(
                            bottom: BorderSide(
                              color: Theme.of(context)
                                  .colorScheme
                                  .outline
                                  .withOpacity(0.2),
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_back),
                              onPressed: () => context.pop(),
                            ),
                            Expanded(
                              child: Text(
                                story.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        loading: () => Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        error: (error, stack) => Center(
          child: Text(
            'Error loading story: $error',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ),
    );
  }
}
