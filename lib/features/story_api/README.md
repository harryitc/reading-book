# Story API Integration

Real API integration for fetching stories from `/truyen/query` endpoint.

## Overview

This feature replaces mock data with actual API calls to fetch story information. The implementation follows clean architecture principles with clear separation of concerns.

## Architecture Layers

```
API Response (JSON)
        ↓
   ApiDatasource (Network)
        ↓
   ApiRepository (Conversion)
        ↓
   Riverpod Provider (State)
        ↓
   UI Screen (Display)
```

## Data Flow

### 1. API Response Format

```json
{
  "id": "xuyen-den-thap-nien-70-ac-nu-ta-nguoc-tra-lam-giau",
  "image_src": "https://example.com/image.jpg",
  "image_alt": "Story title image alt",
  "title": "Story Title",
  "author": "Author Name",
  "badge": ["hot"],
  "latest_chapter": 680
}
```

### 2. Field Mapping

| API Field | Domain Field | Notes |
|-----------|--------------|-------|
| `id` | `id` | Story unique identifier |
| `image_src` | `coverImageUrl` | Story cover image URL |
| `image_alt` | - | Alt text (optional) |
| `title` | `title` | Story title |
| `author` | `author` | Story author |
| `badge` | status, genres | Parsed to determine story status |
| `latest_chapter` | `latestChapter` | Latest chapter number |

### 3. Badge Mapping

Badges from API are parsed to determine story metadata:

- `"hot"` → Rating: 4.7, Status: ongoing
- `"full"` → Status: completed, Rating: 4.5
- None → Default rating: 4.3, Status: ongoing

## File Structure

```
story_api/
├── data/
│   ├── datasources/
│   │   └── story_api_datasource.dart    # Network layer
│   ├── models/
│   │   └── api_story_response.dart      # API response model
│   └── repositories/
│       └── story_api_repository.dart    # Repository layer
└── presentation/
    └── providers/
        └── story_api_provider.dart      # Riverpod providers
```

## Components

### ApiStoryResponse Model

Maps API JSON response to Dart objects.

**Methods:**
- `fromJson()` - Parse API response
- `toJson()` - Convert to JSON
- `toDomainJson()` - Convert to domain model format

**Features:**
- Null-safe field handling
- Default values for required fields
- Badge parsing logic

```dart
final apiStory = ApiStoryResponse.fromJson(jsonData);
final story = apiStory.toDomainJson();
```

### StoryApiDatasource

Handles all network communication with the API.

**Methods:**
- `fetchStories()` - Fetch stories with optional filters

**Features:**
- HTTP client abstraction
- Error handling
- Response parsing
- Query parameter building
- Flexible response format handling

```dart
final stories = await datasource.fetchStories(
  limit: 20,
  offset: 0,
  searchQuery: 'truyện hay',
);
```

**Supported Response Formats:**

The datasource automatically handles multiple response formats:

1. Direct array: `[...]`
2. Wrapped in `data`: `{data: [...]}`
3. Wrapped in `stories`: `{stories: [...]}`
4. Wrapped in `items`: `{items: [...]}`
5. Wrapped in `results`: `{results: [...]}`

### StoryApiRepository

Bridges datasource and domain models.

**Methods:**
- `getAllStories()` - Get all stories (converts API to domain)

**Features:**
- Data transformation
- Error handling
- Clean interface

```dart
final stories = await repository.getAllStories();
// Returns: List<Story> (domain model)
```

### Riverpod Providers

State management using Riverpod.

**Providers:**

```dart
// HTTP Client instance
httpClientProvider

// API Datasource instance
storyApiDatasourceProvider

// Repository instance
storyApiRepositoryProvider

// Async provider for fetching stories
fetchStoriesProvider
  // Usage: ref.watch(fetchStoriesProvider)
  // Returns: AsyncValue<List<Story>>
  // States: loading, data, error

// Optional: Cached stories in memory
cachedStoriesProvider
```

**Usage in UI:**

```dart
final storiesAsync = ref.watch(fetchStoriesProvider);

storiesAsync.when(
  loading: () => LoadingWidget(),
  data: (stories) => StoriesList(stories: stories),
  error: (error, stack) => ErrorWidget(error: error),
);
```

## Integration with UI

### Explore Screen

Updated to use real API instead of mock data:

```dart
// Before: ref.watch(allStoriesProvider)
// After:
final storiesAsync = ref.watch(fetchStoriesProvider);
```

### Error Handling

Retry functionality implemented:

```dart
ElevatedButton.icon(
  onPressed: () {
    ref.refresh(fetchStoriesProvider);
  },
  icon: const Icon(Icons.refresh),
  label: const Text('Thử lại'),
);
```

### Loading State

Skeleton loader displayed while fetching:

```dart
storiesAsync.when(
  loading: () => _buildLoadingState(context),
  // ...
);
```

## Configuration

### Base URL

Set in `lib/core/constants/app_constants.dart`:

```dart
static const String baseApiUrl = 'https://api.storynest.local';
```

### Timeout

```dart
static const Duration apiTimeout = Duration(seconds: 30);
```

### Endpoint

```
GET /truyen/query
```

## Error Handling

### Network Errors

- Timeout: Caught and displayed in error state
- Connection: Displayed with retry option
- Invalid response: Partially parsed items are skipped

### Response Parsing

- Invalid JSON: Empty list returned
- Missing fields: Default values used
- Malformed items: Skipped with warning

## Performance Optimization

### Memory

- Async lazy loading (only loaded when accessed)
- Optional in-memory cache with `cachedStoriesProvider`
- No unnecessary rebuilds with Riverpod

### Network

- Single HTTP client instance (reused)
- Query parameter support for future pagination
- Error state preserves last successful data

## Testing

To test with real API:

1. Update base URL to actual API endpoint
2. Run the app and navigate to Explore screen
3. Check loading → success flow

To test error handling:

1. Set invalid base URL
2. Observe error state and retry functionality

## Future Enhancements

- [ ] Pagination support
- [ ] Search filtering
- [ ] Caching with disk storage
- [ ] Pull-to-refresh functionality
- [ ] Offline fallback with local cache
- [ ] API response caching with TTL
- [ ] Network state monitoring

## Code Quality

✓ Null-safe code
✓ Error handling
✓ Clean architecture
✓ Separation of concerns
✓ Type-safe conversions
✓ Comprehensive logging
✓ Comment documentation

## Dependencies

- `http: ^1.6.0` - HTTP client
- `flutter_riverpod: ^2.4.0` - State management

## Related Files

- `lib/services/api/http_client.dart` - HTTP client
- `lib/core/constants/app_constants.dart` - Configuration
- `lib/features/explore/presentation/screens/explore_screen.dart` - UI
- `lib/features/home/domain/models/story.dart` - Domain model
