# Story Detail Feature

Real API integration for fetching story details by ID.

## Overview

This feature fetches comprehensive story information from the `/truyen/get-one?id={storyId}` API endpoint and displays it in the Story Detail screen.

## Architecture Layers

```
API Response (JSON)
        ↓
   StoryDetailApiDatasource (Network)
        ↓
   StoryDetailRepository (Conversion)
        ↓
   Riverpod Provider (State)
        ↓
   StoryDetailScreen (Display)
```

## Data Flow

### 1. API Endpoint

```
GET /truyen/get-one?id={storyId}
```

### 2. API Response Format

```json
{
  "id": "xuyen-den-thap-nien-70-ac-nu-ta-nguoc-tra-lam-giau",
  "image_src": "https://example.com/image.jpg",
  "image_alt": "Story title image alt",
  "title": "Story Title",
  "description": "Story description text...",
  "author": "Author Name",
  "genres": [
    {
      "ten": "Ngôn Tình",
      "url": "/the-loai/ngon-tinh/"
    }
  ]
}
```

### 3. Field Mapping

| API Field | Model Field | UI Component |
| --- | --- | --- |
| `id` | id | Route parameter |
| `image_src` | imageSrc | Hero image |
| `image_alt` | imageAlt | Image alt text |
| `title` | title | Header title |
| `description` | description | Introduction tab |
| `author` | author | Author section |
| `genres[].ten` | genre.ten | Genre chips |

## File Structure

```
story_detail/
├── data/
│   ├── datasources/
│   │   └── story_detail_api_datasource.dart   # Network layer
│   ├── models/
│   │   └── story_detail_response.dart         # API response model
│   └── repositories/
│       └── story_detail_repository.dart       # Repository layer
└── presentation/
    ├── screens/
    │   └── story_detail_screen.dart           # UI (ConsumerStatefulWidget)
    └── providers/
        └── story_detail_provider.dart         # Riverpod providers
```

## Components

### StoryDetailResponse Model

Maps API JSON response to Dart objects.

**Features:**
- `GenreResponse` nested model for genres
- `fromJson()` factory for API parsing
- `getGenreNames()` helper method
- Null-safe fields with defaults

```dart
final storyDetail = StoryDetailResponse.fromJson(jsonData);
final genreNames = storyDetail.getGenreNames();
```

### StoryDetailApiDatasource

Handles network communication with the API.

**Methods:**
- `fetchStoryDetail(String storyId)` - Fetch story by ID

**Features:**
- HTTP client abstraction
- Error handling:
  - Empty story ID validation
  - 404 Not Found handling
  - Network error handling
  - JSON parsing errors
- Response validation
- Comprehensive logging

```dart
final detail = await datasource.fetchStoryDetail('story-id');
```

### StoryDetailRepository

Bridges datasource and screen logic.

**Methods:**
- `getStoryDetail(String storyId)` - Get story detail

**Features:**
- Clean interface
- Error propagation

```dart
final detail = await repository.getStoryDetail(storyId);
```

### Riverpod Providers

State management using Riverpod.

**Main Provider:**

```dart
fetchStoryDetailProvider.family<StoryDetailResponse, String>
```

**Usage in UI:**
```dart
final storyDetailAsync = ref.watch(fetchStoryDetailProvider(storyId));

storyDetailAsync.when(
  data: (storyDetail) => /* show UI */,
  loading: () => /* loading */,
  error: (error, stack) => /* error */,
);
```

**Optional Cache Provider:**

```dart
cachedStoryDetailProvider  // In-memory cache
storyDetailCacheProvider   // Cache state
```

## Navigation

### Route Configuration

Located in `lib/core/router/app_router.dart`:

```dart
GoRoute(
  path: '/story/:storyId',
  name: 'story_detail',
  builder: (context, state) {
    final storyId = state.pathParameters['storyId'] ?? '';
    return StoryDetailScreen(storyId: storyId);
  },
),
```

### Navigation Flow

```
Explore Screen (tap story)
    ↓
pushNamed('story_detail', pathParameters: {'storyId': id})
    ↓
StoryDetailScreen(storyId: id)
    ↓
fetchStoryDetailProvider(id)
    ↓
API: GET /truyen/get-one?id={id}
```

### From Story List

```dart
context.pushNamed(
  'story_detail',
  pathParameters: {'storyId': story.id},
);
```

## UI Integration

### StoryDetailScreen (ConsumerStatefulWidget)

**Features:**
- Real-time data binding from Riverpod
- Three loading states:
  - **Loading**: Skeleton loader
  - **Data**: Full story detail UI
  - **Error**: Error state with retry button
- Tab view with 3 sections:
  1. **Giới thiệu**: Description, latest chapters, author
  2. **Danh sách chương**: Chapter list (placeholder)
  3. **Bình luận**: Comments section (empty state)

**Key UI Elements:**
- Header with blurred background and Hero animation
- Genre chips dynamically rendered from API
- Author section with follow button
- Action buttons (Read, Download)
- Tab-based content sections

### Data Binding

```dart
@override
Widget build(BuildContext context, WidgetRef ref) {
  final storyDetailAsync = ref.watch(fetchStoryDetailProvider(widget.storyId));

  return storyDetailAsync.when(
    data: (storyDetail) {
      // Bind storyDetail fields to UI components
      Text(storyDetail.title);
      Text(storyDetail.author);
      Text(storyDetail.description);
      storyDetail.genres.map((g) => GenreChip(g.ten));
    },
    loading: () => _buildLoadingState(),
    error: (error, stack) => _buildErrorState(context, error),
  );
}
```

## Error Handling

### Network Errors

- Connection timeout: Displays error message
- 404 Not Found: "Story not found" message
- 5xx Server error: Generic error message
- JSON parsing error: "Invalid response format"

### Validation Errors

- Empty story ID: Throws before API call
- Missing required fields: Shows error state
- Empty description: Shows placeholder text

### Retry Mechanism

```dart
ElevatedButton.icon(
  onPressed: () {
    ref.refresh(fetchStoryDetailProvider(widget.storyId));
  },
  icon: const Icon(Icons.refresh),
  label: const Text('Thử lại'),
);
```

## Performance Optimization

### Caching Strategy

1. **Memory Cache**: `cachedStoryDetailProvider` stores fetched details
2. **Family Providers**: Each story ID is cached separately
3. **Lazy Loading**: Only fetches when screen is viewed

### Best Practices

- Use `ConsumerStatefulWidget` to access Riverpod refs
- Watch providers with `.family()` for parameterized fetches
- Refresh providers on error for retry logic
- Avoid unnecessary rebuilds with proper state watching

## Testing

To test the feature:

1. Update base URL to real API in `AppConstants`
2. Navigate to Explore screen
3. Tap on any story
4. Observe loading → success → detail display flow

To test error handling:

1. Use invalid story ID: See 404 error
2. Use empty story ID: See validation error
3. Set timeout value: See timeout error
4. Tap retry button: Re-fetch data

## Future Enhancements

- [ ] Persist cache to disk
- [ ] Implement rating system
- [ ] Add comments functionality
- [ ] Chapter reading list with pagination
- [ ] Reading progress tracking
- [ ] Bookmark/favorite feature
- [ ] Share story functionality

## Dependencies

- `flutter_riverpod: ^2.4.0` - State management
- `go_router: ^13.0.0` - Navigation
- `http: ^1.6.0` - HTTP client

## Related Files

- `lib/services/api/http_client.dart` - HTTP client
- `lib/core/constants/app_constants.dart` - API configuration
- `lib/features/story_api/presentation/providers/story_api_provider.dart` - Shared providers
- `lib/core/router/app_router.dart` - Route configuration

## Key Code Patterns

### Fetching Data

```dart
// In provider
final storyDetailAsync = ref.watch(fetchStoryDetailProvider(storyId));
```

### Handling States

```dart
storyDetailAsync.when(
  loading: () => LoadingWidget(),
  data: (data) => ContentWidget(data: data),
  error: (error, stack) => ErrorWidget(error: error),
);
```

### Retry Logic

```dart
ref.refresh(fetchStoryDetailProvider(storyId));
```

## Design Principles

✓ Clean architecture
✓ Separation of concerns
✓ Type-safe data mapping
✓ Proper error handling
✓ Responsive UI states
✓ Efficient caching
✓ Null-safe code
✓ Comprehensive logging
