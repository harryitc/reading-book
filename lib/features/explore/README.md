# Explore / Discover Feature

A complete implementation of the Explore screen for the Truyện Hay reading application.

## Overview

The Explore feature displays all available stories in the system with two view modes:
- **Grid View (Default)**: 2-column layout with visual focus
- **List View**: Vertical list optimized for scanning

## Architecture

### Folder Structure
```
explore/
├── domain/
│   └── models/
│       └── story_mock_data.dart         # Mock data provider (16 sample stories)
├── presentation/
│   ├── providers/
│   │   └── explore_provider.dart        # State management (Riverpod)
│   ├── screens/
│   │   └── explore_screen.dart          # Main screen
│   └── widgets/
│       ├── view_toggle_button.dart      # Grid/List toggle
│       ├── story_grid_item.dart         # Grid item component
│       └── story_list_item.dart         # List item component
└── README.md                             # This file
```

## Components

### ExploreScreen
Main screen with:
- App bar with "Khám phá" title
- View toggle button (Grid/List)
- Loading state (skeleton loader)
- Empty state
- Error state with retry button
- Grid/List view switching with state persistence

### ViewToggleButton
Reusable button component to toggle between:
- Grid view icon
- List view icon

Selected state is highlighted with primary color.

### StoryGridItem
Reusable grid item displaying:
- Cover image (200px height)
- Status badge (FULL/ONGOING)
- Story title (1-2 lines)
- Author name
- Rounded corners
- Image error handling and loading states

### StoryListItem
Reusable list item displaying:
- Cover image (80px width)
- Story title
- Author
- Status badge
- Latest chapter number
- Chevron icon for navigation hint
- Full-row tap area

## State Management

Uses **Riverpod** for state management:

```dart
// View mode state (Grid/List)
exploreViewModeProvider

// All stories async data
allStoriesProvider

// Filtered stories (extensible for search/genre filtering)
filteredStoriesProvider
```

## Mock Data

**16 sample Vietnamese stories** included with:
- id
- title
- author
- description
- coverImageUrl (network image)
- genres (list of strings)
- rating (0-5)
- totalChapters
- latestChapter
- publishedAt
- updatedAt
- status (FULL/ONGOING)

**Mock data location**: `lib/features/explore/domain/models/story_mock_data.dart`

## Navigation

Tapping any story navigates to the **Story Detail screen** (existing):

```dart
context.pushNamed(
  'reader',
  pathParameters: {'storyId': story.id},
);
```

The Story Detail screen is assumed to be located at:
- `lib/features/story_detail/presentation/screens/story_detail_screen.dart`
- or routed as `/reader/:storyId`

## UI States

### Loading State
- Skeleton loader with animated placeholders
- 6 placeholder items shown during loading
- 500ms simulated delay

### Empty State
- Book icon
- "Không tìm thấy truyện" message
- Subtitle text

### Error State
- Error icon
- "Có lỗi xảy ra" message
- Error details
- "Thử lại" (Retry) button

## Routing Integration

Route added to main router:
```dart
GoRoute(
  path: '/main/explore',
  builder: (context, state) => const ExploreScreen(),
),
```

Bottom navigation updated with:
- Icon: `Icons.explore`
- Label: "Khám phá"
- Index: 1 (between Home and Library)

## Theming

- Supports Light and Dark themes
- Respects Material 3 theme colors
- Adaptive colors for status badges
- Blue for ONGOING, Green for FULL

## Performance

- Grid view: 2-column layout with fixed aspect ratio (0.6)
- List view: Single column with optimized height
- Image caching via network image
- Lazy loading with SingleChildScrollView and ListView builders

## Extensibility

To add filtering:
1. Add filter state to `explore_provider.dart`
2. Modify `filteredStoriesProvider` to apply filters
3. Update `ExploreScreen` to display filter UI

To add search:
1. Add search query state
2. Filter stories in `filteredStoriesProvider`
3. Add search field to app bar

## Design Principles

✓ Content-first layout
✓ Smooth scrolling
✓ Reading-app friendly spacing
✓ Material 3 best practices
✓ Accessible touch targets
✓ Clear visual hierarchy
✓ Dark mode support
✓ Network image error handling
✓ Loading state feedback
✓ Empty/error state guidance
