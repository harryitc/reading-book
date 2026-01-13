# Firebase Cloud Messaging Implementation Tasks

## 📋 TỔNG QUAN
Tích hợp Firebase Cloud Messaging (FCM) để nhận và hiển thị thông báo push từ admin.

---

## ✅ CHECKLIST CÁC TASK CẦN LÀM

### **PHASE 1: Setup Core Services**

- [ ] **Task 1.1**: Tạo Firebase Messaging Service
  - File: `lib/services/notification/firebase_messaging_service.dart`
  - Chức năng:
    - Initialize Firebase Messaging
    - Request notification permissions (iOS/Android 13+)
    - Get FCM token
    - Handle token refresh
    - Setup message handlers (foreground, background, terminated)
    - Save token to local storage

- [ ] **Task 1.2**: Tạo Local Notification Service (Optional - nâng cao)
  - File: `lib/services/notification/local_notification_service.dart`
  - Package cần thêm: `flutter_local_notifications`
  - Chức năng:
    - Hiển thị notification local khi app ở foreground
    - Custom notification style
    - Notification channels (Android)
    - Sound, vibration, LED

---

### **PHASE 2: Data Models & State Management**

- [ ] **Task 2.1**: Tạo Notification Model
  - File: `lib/features/notifications/domain/models/app_notification.dart`
  - Properties:
    - id, title, body, timestamp
    - isRead status
    - data payload (for navigation)
    - notificationType (optional)
  - Methods: toJson, fromJson, copyWith

- [ ] **Task 2.2**: Tạo Notification Repository
  - File: `lib/features/notifications/data/repositories/notification_repository.dart`
  - Chức năng:
    - Lưu notifications vào local storage
    - Lấy danh sách notifications
    - Đánh dấu đã đọc/chưa đọc
    - Xóa notifications
    - Get unread count

- [ ] **Task 2.3**: Tạo Notification Provider (Riverpod)
  - File: `lib/features/notifications/presentation/providers/notification_provider.dart`
  - State management:
    - Danh sách notifications
    - Unread count
    - Loading state
    - Add/remove/update notifications
    - Mark as read/unread

---

### **PHASE 3: UI Components**

- [ ] **Task 3.1**: Tạo Notifications Screen
  - File: `lib/features/notifications/presentation/screens/notifications_screen.dart`
  - Features:
    - AppBar với title "Thông báo"
    - ListView notifications
    - Empty state
    - Pull to refresh
    - Mark all as read button

- [ ] **Task 3.2**: Tạo Notification Item Widget
  - File: `lib/features/notifications/presentation/widgets/notification_item.dart`
  - Features:
    - Display title, body, time
    - Visual indicator cho unread
    - Tap to navigate
    - Swipe to delete (optional)

- [ ] **Task 3.3**: Tạo Notification Badge Widget
  - File: `lib/features/notifications/presentation/widgets/notification_badge.dart`
  - Features:
    - Badge hiển thị số thông báo chưa đọc
    - Có thể dùng cho icon trong AppBar/BottomNav

---

### **PHASE 4: Integration & Configuration**

- [ ] **Task 4.1**: Thêm route cho Notifications Screen
  - File: `lib/core/router/app_router.dart`
  - Add route: `/notifications`

- [ ] **Task 4.2**: Update Main.dart
  - File: `lib/main.dart`
  - Initialize Firebase Messaging Service
  - Setup notification handlers
  - Request permissions
  - Get and save FCM token

- [ ] **Task 4.3**: Cấu hình Android Native
  - **File 4.3.1**: `android/app/src/main/AndroidManifest.xml`
    - Thêm permissions:
      ```xml
      <uses-permission android:name="android.permission.INTERNET"/>
      <uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>
      ```
    - Thêm metadata cho default notification icon/color
    - Thêm intent-filter cho notification click
  
  - **File 4.3.2**: `android/app/build.gradle` (kiểm tra)
    - Verify google-services plugin
    - Check minSdkVersion >= 21
  
  - **File 4.3.3**: `android/app/google-services.json`
    - Verify file tồn tại và đúng project

- [ ] **Task 4.4**: Cấu hình iOS Native
  - **File 4.4.1**: `ios/Runner/AppDelegate.swift`
    - Import UserNotifications
    - Request authorization
    - Register for remote notifications
    - Handle notification response
  
  - **File 4.4.2**: Xcode Configuration
    - Open `ios/Runner.xcworkspace` in Xcode
    - Select Runner target
    - Enable "Push Notifications" capability
    - Enable "Background Modes" → Check "Remote notifications"
  
  - **File 4.4.3**: `ios/Runner/Info.plist`
    - Add notification permission usage description

---

### **PHASE 5: Backend Integration (Phía Admin)**

- [ ] **Task 5.1**: API để lưu FCM Token
  - Endpoint: `POST /api/users/{userId}/fcm-token`
  - Body: `{ "token": "fcm_token_here", "platform": "android|ios" }`
  - Gửi token lên server mỗi khi:
    - App được cài đặt lần đầu
    - Token bị refresh
    - User login

- [ ] **Task 5.2**: Admin Panel - Send Notification
  - Admin cần có giao diện để:
    - Chọn target users (all, specific, topic)
    - Nhập title, body
    - Nhập data payload (for navigation)
    - Send notification qua Firebase Cloud Messaging API
  - API Key: Lấy từ Firebase Console → Project Settings → Cloud Messaging

- [ ] **Task 5.3**: Server-side FCM Integration
  - Backend cần tích hợp Firebase Admin SDK
  - Gửi notification qua FCM API:
    ```
    POST https://fcm.googleapis.com/v1/projects/{project_id}/messages:send
    ```

---

### **PHASE 6: Advanced Features (Optional)**

- [ ] **Task 6.1**: Topic Subscription
  - Subscribe users to topics (e.g., "all", "promotions", "updates")
  - Allow users to manage subscriptions in settings

- [ ] **Task 6.2**: Notification Filtering/Categories
  - Different types: system, promotion, update, message
  - User preferences cho từng loại

- [ ] **Task 6.3**: Rich Notifications
  - Images trong notification
  - Action buttons (e.g., "View", "Dismiss")
  - Big text style

- [ ] **Task 6.4**: Analytics
  - Track notification delivery rate
  - Track open rate
  - Track actions taken

- [ ] **Task 6.5**: Scheduled Local Notifications
  - Reminder notifications
  - Daily reading reminders

---

## 📦 PACKAGES CẦN THÊM (Optional)

```yaml
dependencies:
  firebase_messaging: ^16.1.0  # ✅ Đã có
  flutter_local_notifications: ^17.0.0  # For local notifications (optional)
  permission_handler: ^11.0.0  # For better permission handling (optional)
```

---

## 🔐 PERMISSIONS REQUIRED

### Android (API 33+)
- `POST_NOTIFICATIONS` - Runtime permission required for Android 13+

### iOS
- Push Notifications capability
- Background fetch capability
- Remote notifications background mode

---

## 📱 NOTIFICATION PAYLOAD FORMAT

### From Firebase Console/Admin:
```json
{
  "notification": {
    "title": "Tiêu đề thông báo",
    "body": "Nội dung thông báo"
  },
  "data": {
    "type": "story_update|system|promotion",
    "targetScreen": "/story/123",
    "storyId": "123",
    "customKey": "customValue"
  },
  "token": "user_fcm_token_here"
}
```

---

## 🧪 TESTING CHECKLIST

- [ ] Test nhận notification khi app ở foreground
- [ ] Test nhận notification khi app ở background
- [ ] Test nhận notification khi app bị terminated
- [ ] Test tap notification → navigate đúng màn hình
- [ ] Test unread badge count
- [ ] Test mark as read
- [ ] Test notification history
- [ ] Test iOS permissions
- [ ] Test Android 13+ permissions
- [ ] Test token refresh
- [ ] Test multiple devices

---

## 🚀 IMPLEMENTATION ORDER (Recommended)

1. **Day 1**: Tasks 1.1, 2.1, 4.2 (Core service + basic integration)
2. **Day 2**: Tasks 2.2, 2.3 (State management)
3. **Day 3**: Tasks 3.1, 3.2, 4.1 (UI)
4. **Day 4**: Tasks 4.3, 4.4 (Native configuration)
5. **Day 5**: Task 5.1, Testing
6. **Day 6+**: Optional advanced features

---

## 📚 RESOURCES

- [Firebase Cloud Messaging Documentation](https://firebase.google.com/docs/cloud-messaging)
- [FlutterFire FCM Documentation](https://firebase.flutter.dev/docs/messaging/overview)
- [Android FCM Setup](https://firebase.google.com/docs/cloud-messaging/android/client)
- [iOS FCM Setup](https://firebase.google.com/docs/cloud-messaging/ios/client)

---

## ⚠️ NOTES & BEST PRACTICES

1. **Token Management**: Always save FCM token locally và sync với server
2. **Error Handling**: Handle permission denied gracefully
3. **Background Handler**: Must be top-level function (not inside class)
4. **iOS Simulator**: Push notifications không work trên simulator, cần real device
5. **Data-only Messages**: Dùng "data" payload nếu muốn custom logic hoàn toàn
6. **Token Refresh**: Listen to `onTokenRefresh` và update server
7. **Privacy**: Request permission at appropriate time, explain why
8. **Performance**: Đừng lưu quá nhiều notifications locally (limit 50-100 gần nhất)

---

## 🎯 SUCCESS CRITERIA

✅ Admin có thể gửi notification từ backend/Firebase Console  
✅ Mobile app nhận được notification ở mọi trạng thái (foreground/background/terminated)  
✅ Notification hiển thị đúng title, body  
✅ Tap notification navigate đúng màn hình  
✅ Có UI hiển thị lịch sử notifications  
✅ Có badge đếm số notifications chưa đọc  
✅ User có thể đánh dấu đã đọc/xóa notifications  
✅ Works on both iOS and Android  

---

**Tạo bởi**: GitHub Copilot  
**Ngày tạo**: January 12, 2026  
**Dự án**: Truyện Hay - Reading Book App
