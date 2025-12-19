# API Integration Guide - Hot Stories

## Architecture Overview

Cấu trúc clean architecture với các layer rõ ràng:

```
Presentation Layer (UI)
        ↓
    Providers (Riverpod)
        ↓
Repository Layer
        ↓
Data Source (Remote/Local)
        ↓
HTTP Client / API
```

---

## File Structure

```
lib/features/home/
├── data/
│   ├── datasources/
│   │   └── story_remote_datasource.dart   # API calls
│   ├── models/
│   │   ├── hot_story_response.dart       # DTO (API response)
│   │   └── hot_story_response.g.dart     # JSON serialization
│   └── repositories/
│       └── story_repository.dart         # Business logic
├── domain/
│   └── models/
│       └── story.dart                    # Domain model (UI-ready)
└── presentation/
    └── providers/
        └── story_provider.dart           # Riverpod providers
```

---

## Data Flow

### 1. API Response (from API)
```json
{
  "id": "my-dung-su-xuyen-qua-lam-nong-phu-lam-giau-nuoi-con",
  "title": "Mỹ Dung Sư Xuyên Qua Làm Nông Phụ Làm Giàu Nuôi Con",
  "imageUrl": "https://lh3.googleusercontent.com/...",
  "imageAlt": "Mỹ Dung Sư Xuyên Qua Làm Nông Phụ Làm Giàu Nuôi Con",
  "is_full": true
}
```

### 2. DTO Model (`HotStoryResponse`)
```dart
@JsonSerializable()
class HotStoryResponse {
  final String id;
  final String title;
  final String imageUrl;
  final String imageAlt;
  final bool isFull;
}
```

### 3. Domain Model (`Story`)
```dart
class Story {
  final String id;
  final String title;
  final String author;              // "Unknown" (mặc định)
  final String? coverImageUrl;      // maps from imageUrl
  final StoryStatus status;         // FULL / ONGOING (từ is_full)
  final DateTime updatedAt;         // Set to now
  // ... other fields
}
```

---

## Layer Details

### RemoteDataSource (`story_remote_datasource.dart`)
**Responsibility**: Direct API communication

```dart
abstract class StoryRemoteDataSource {
  Future<List<HotStoryResponse>> getHotStories();
}

class StoryRemoteDataSourceImpl implements StoryRemoteDataSource {
  final http.Client httpClient;
  
  @override
  Future<List<HotStoryResponse>> getHotStories() async {
    // 1. Make HTTP call
    // 2. Handle status codes
    // 3. Parse JSON
    // 4. Return HotStoryResponse list
  }
}
```

**API Endpoint:**
- Base: `https://redbird-generous-alpaca.ngrok-free.app/webhook-test`
- Endpoint: `/dashboard-truyen-hot`
- Method: `GET`
- Timeout: 15 seconds

---

### Repository (`story_repository.dart`)
**Responsibility**: Business logic & data transformation

```dart
class StoryRepository {
  final StoryRemoteDataSource remoteDataSource;
  
  Future<List<Story>> fetchHotStories() async {
    // 1. Call datasource
    final responses = await remoteDataSource.getHotStories();
    
    // 2. Map HotStoryResponse → Story
    final stories = responses.map(_mapToStory).toList();
    
    // 3. Return domain model
    return stories;
  }
  
  Story _mapToStory(HotStoryResponse response) {
    // Map fields from API response to domain model
    return Story(
      id: response.id,
      title: response.title,
      author: 'Unknown',                    // Default value
      coverImageUrl: response.imageUrl,
      status: response.isFull ? 
        StoryStatus.full : StoryStatus.ongoing,
      // ... other mappings
    );
  }
}
```

---

### Providers (`story_provider.dart`)
**Responsibility**: State management & caching

```dart
// Data Source Provider
final storyRemoteDataSourceProvider = Provider<StoryRemoteDataSource>((ref) {
  return StoryRemoteDataSourceImpl(httpClient: http.Client());
});

// Repository Provider
final storyRepositoryProvider = Provider<StoryRepository>((ref) {
  final dataSource = ref.watch(storyRemoteDataSourceProvider);
  return StoryRepository(remoteDataSource: dataSource);
});

// Hot Stories Provider (with auto-caching)
final hotStoriesProvider = FutureProvider<List<Story>>((ref) async {
  final stories = await ref.watch(allStoriesProvider.future);
  return stories.take(5).toList();
});

// Main data provider (caches result)
final allStoriesProvider = FutureProvider<List<Story>>((ref) async {
  final repository = ref.watch(storyRepositoryProvider);
  try {
    return await repository.fetchHotStories();
  } catch (e) {
    // Fallback to mock data
    final notifier = ref.read(storyListProvider.notifier);
    await notifier.loadStories();
    return ref.watch(storyListProvider);
  }
});
```

---

## Data Mapping Rules

| API Field | Domain Field | Transformation |
|-----------|-------------|-----------------|
| `id` | `id` | Direct |
| `title` | `title` | Direct |
| `imageUrl` | `coverImageUrl` | Direct |
| `imageAlt` | `description` | Used as description |
| `is_full` | `status` | `true` → FULL, `false` → ONGOING |
| N/A | `author` | Set to "Unknown" |
| N/A | `rating` | Set to 4.5 (default) |
| N/A | `totalChapters` | Set to 0 (unknown) |
| N/A | `latestChapter` | Set to 0 (unknown) |
| N/A | `updatedAt` | Set to current time |
| N/A | `genres` | Set to empty list |

---

## Usage in Screens

```dart
class HomeScreen extends ConsumerStatefulWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch hot stories provider
    final hotStories = ref.watch(hotStoriesProvider);
    
    return hotStories.when(
      data: (stories) {
        // Show stories UI
        return ListView.builder(
          itemCount: stories.length,
          itemBuilder: (context, index) {
            return HorizontalStoryCard(
              story: stories[index],
              onTap: () => context.push('/reader/${stories[index].id}'),
            );
          },
        );
      },
      loading: () => CircularProgressIndicator(),
      error: (error, stack) => ErrorWidget(),
    );
  }
}
```

---

## Error Handling

### API Fails → Fallback to Mock Data
```dart
final allStoriesProvider = FutureProvider<List<Story>>((ref) async {
  final repository = ref.watch(storyRepositoryProvider);
  try {
    return await repository.fetchHotStories();  // Try API
  } catch (e) {
    // API failed, use mock data
    final notifier = ref.read(storyListProvider.notifier);
    await notifier.loadStories();
    return ref.watch(storyListProvider);
  }
});
```

### Error Scenarios:
- Network timeout → Use mock data
- HTTP error (4xx, 5xx) → Use mock data
- JSON parsing error → Use mock data
- No internet → Use mock data

---

## Future Enhancements

### 1. Add More Endpoints
```dart
// In datasource
Future<List<StoryResponse>> getRecentlyUpdated() async { }
Future<List<StoryResponse>> getCompletedStories() async { }
Future<List<GenreResponse>> getGenres() async { }

// In repository
Future<List<Story>> fetchRecentlyUpdated() async { }
Future<List<Story>> fetchCompletedStories() async { }
```

### 2. Caching Strategy
- Cache API responses locally (Hive/Floor)
- Invalidate cache after X minutes
- Support offline mode

### 3. Pagination
```dart
Future<List<Story>> fetchHotStories({
  int page = 1,
  int pageSize = 20,
}) async { }
```

### 4. Filtering & Sorting
```dart
Future<List<Story>> fetchHotStories({
  String? genre,
  String? sortBy,
  bool? completed,
}) async { }
```

---

## Testing

### Unit Tests - Repository
```dart
test('should map HotStoryResponse to Story correctly', () {
  final response = HotStoryResponse(
    id: 'test-id',
    title: 'Test Title',
    imageUrl: 'https://...',
    imageAlt: 'Alt text',
    isFull: true,
  );
  
  final story = repository.mapToStory(response);
  
  expect(story.id, 'test-id');
  expect(story.status, StoryStatus.full);
});
```

### Mock Tests - Provider
```dart
test('hotStoriesProvider returns first 5 stories', () async {
  final container = ProviderContainer();
  final stories = await container.read(hotStoriesProvider.future);
  
  expect(stories.length, lessThanOrEqualTo(5));
});
```

---

## Logging

All API calls are logged via `AppLogger`:

```dart
AppLogger.debug('Calling API: /dashboard-truyen-hot');
AppLogger.debug('Successfully fetched 10 hot stories from API');
AppLogger.error('Failed to fetch hot stories', exception);
```

Check logs in console for debugging.

---

## Environment Variables

Nếu cần thay đổi API endpoint, sửa trong `story_remote_datasource.dart`:

```dart
static const String baseUrl =
    'https://your-api.com/api';  // Change here
```

Hoặc đưa vào `AppConstants`:
```dart
static const String storyApiBaseUrl =
    'https://redbird-generous-alpaca.ngrok-free.app/webhook-test';
```

---

**Last Updated**: December 2024  
**Status**: Production Ready  
**API Version**: v1
