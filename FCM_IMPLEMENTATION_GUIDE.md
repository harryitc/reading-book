# 📚 Hướng dẫn sử dụng Firebase Cloud Messaging trong Truyện Hay

## ✅ IMPLEMENTATION COMPLETED

Firebase Cloud Messaging đã được tích hợp hoàn chỉnh vào ứng dụng Truyện Hay!

---

## 📦 CÁC FILE ĐÃ TẠO

### **1. Core Services**
- ✅ [`lib/services/notification/firebase_messaging_service.dart`](lib/services/notification/firebase_messaging_service.dart)
  - Firebase Messaging initialization
  - Permission handling (iOS/Android 13+)
  - FCM token management
  - Message handlers (foreground/background/terminated)
  - Topic subscription

### **2. Data Layer**
- ✅ [`lib/features/notifications/domain/models/app_notification.dart`](lib/features/notifications/domain/models/app_notification.dart)
  - Notification model với JSON serialization
  - Helper methods (timeAgo, formattedDateTime)
  
- ✅ [`lib/features/notifications/data/repositories/notification_repository.dart`](lib/features/notifications/data/repositories/notification_repository.dart)
  - Local storage operations
  - CRUD operations cho notifications
  - Unread count management

### **3. Presentation Layer**
- ✅ [`lib/features/notifications/presentation/providers/notification_provider.dart`](lib/features/notifications/presentation/providers/notification_provider.dart)
  - Riverpod state management
  - Notification state management
  
- ✅ [`lib/features/notifications/presentation/screens/notifications_screen.dart`](lib/features/notifications/presentation/screens/notifications_screen.dart)
  - UI hiển thị danh sách notifications
  - Pull to refresh
  - Mark all as read
  - Delete all
  
- ✅ [`lib/features/notifications/presentation/widgets/notification_item.dart`](lib/features/notifications/presentation/widgets/notification_item.dart)
  - Individual notification display
  - Swipe to delete
  - Unread indicator
  
- ✅ [`lib/features/notifications/presentation/widgets/notification_badge.dart`](lib/features/notifications/presentation/widgets/notification_badge.dart)
  - Badge widget cho unread count
  - NotificationIconButton helper

### **4. Integration**
- ✅ [`lib/main.dart`](lib/main.dart) - Updated
  - FCM service initialization
  - Notification listeners
  - In-app notification display
  - Navigation handling
  
- ✅ [`lib/core/router/app_router.dart`](lib/core/router/app_router.dart) - Updated
  - Added `/notifications` route

### **5. Native Configuration**
- ✅ [`android/app/src/main/AndroidManifest.xml`](android/app/src/main/AndroidManifest.xml) - Updated
  - Permissions: INTERNET, POST_NOTIFICATIONS
  - FCM metadata (icon, color, channel)
  - Intent filter for notification tap
  
- ✅ [`ios/Runner/AppDelegate.swift`](ios/Runner/AppDelegate.swift) - Updated
  - Notification permission request
  - UNUserNotificationCenter delegate
  - Foreground presentation
  - Notification tap handling
  - APNs registration
  
- ✅ [`ios/Runner/Info.plist`](ios/Runner/Info.plist) - Updated
  - UIBackgroundModes (remote-notification, fetch)
  - NSUserNotificationsUsageDescription

---

## 🚀 CÁCH SỬ DỤNG

### **1. Lấy FCM Token**
```dart
final fcmService = FirebaseMessagingService();
final token = await fcmService.getToken();
print('FCM Token: $token');
```

Token này cần được gửi lên backend để admin có thể gửi notification cho user cụ thể.

### **2. Subscribe vào Topic**
```dart
await fcmService.subscribeToTopic('all_users');
await fcmService.subscribeToTopic('promotions');
```

### **3. Thêm NotificationBadge vào UI**
```dart
// In AppBar
NotificationIconButton(
  onPressed: () {
    context.push('/notifications');
  },
)

// Custom badge
NotificationBadge(
  child: Icon(Icons.notifications),
)
```

### **4. Navigate đến Notifications Screen**
```dart
context.push('/notifications');
// hoặc
context.pushNamed('notifications');
```

---

## 📱 NOTIFICATION PAYLOAD FORMAT

Admin cần gửi notification theo format sau:

### **Từ Firebase Console:**
```json
{
  "notification": {
    "title": "Truyện mới cập nhật",
    "body": "Chương 123 của 'Tên Truyện' đã được cập nhật"
  },
  "data": {
    "type": "story_update",
    "targetScreen": "/story/123",
    "storyId": "123"
  },
  "token": "USER_FCM_TOKEN_HERE"
}
```

### **Từ Backend (Node.js example):**
```javascript
const admin = require('firebase-admin');

await admin.messaging().send({
  notification: {
    title: 'Thông báo hệ thống',
    body: 'Nội dung thông báo'
  },
  data: {
    type: 'system',
    targetScreen: '/notifications',
  },
  token: userFcmToken
});
```

### **Send to Topic:**
```javascript
await admin.messaging().send({
  notification: {
    title: 'Khuyến mãi đặc biệt',
    body: 'Giảm giá 50% cho tất cả truyện premium'
  },
  data: {
    type: 'promotion',
    targetScreen: '/main/explore',
  },
  topic: 'all_users'
});
```

---

## 🔐 BACKEND INTEGRATION

### **1. API để lưu FCM Token**
Admin cần tạo API endpoint để lưu token:

```javascript
// POST /api/users/:userId/fcm-token
{
  "token": "fcm_token_here",
  "platform": "android" // or "ios"
}
```

### **2. Gọi API từ Flutter khi có token:**
```dart
// In your auth service or after login
final token = await FirebaseMessagingService().getToken();
if (token != null) {
  // Send to your backend
  await api.saveFcmToken(userId, token, platform);
}
```

### **3. Firebase Admin SDK Setup (Backend)**
```javascript
const admin = require('firebase-admin');
const serviceAccount = require('./serviceAccountKey.json');

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});
```

---

## 🧪 TESTING

### **Test với Firebase Console:**
1. Vào Firebase Console → Cloud Messaging
2. Click "Send test message"
3. Nhập FCM token (lấy từ log khi chạy app)
4. Nhập title, body
5. Click "Test"

### **Test Cases:**
- ✅ App ở foreground → Hiển thị SnackBar
- ✅ App ở background → System notification
- ✅ App terminated → Tap notification mở app
- ✅ Tap notification → Navigate to target screen
- ✅ Badge count update
- ✅ Mark as read
- ✅ Delete notification
- ✅ Pull to refresh

### **Lấy FCM Token trong app:**
Token sẽ được in ra console khi app khởi động:
```
🔑 FCM Token: [your_token_here]
```

---

## 📊 NOTIFICATION TYPES

App hỗ trợ các loại notification sau (dựa vào `data.type`):

| Type | Icon | Color | Use Case |
|------|------|-------|----------|
| `story_update` | 📚 book | Blue | Truyện cập nhật chương mới |
| `system` | ℹ️ info | Orange | Thông báo hệ thống |
| `promotion` | 🎁 offer | Green | Khuyến mãi, giảm giá |
| `message` | 💬 message | Purple | Tin nhắn, comment |
| (default) | 🔔 notifications | Grey | Mặc định |

---

## ⚙️ CONFIGURATION

### **Android:**
- **minSdkVersion**: 21+ (đã có trong build.gradle)
- **Permissions**: Auto-granted for Android < 13, Runtime request for Android 13+
- **Notification Channel**: `high_importance_channel`

### **iOS:**
- **Deployment Target**: iOS 10+
- **Capabilities Required**:
  - ⚠️ Push Notifications (enable in Xcode)
  - ⚠️ Background Modes → Remote notifications (enable in Xcode)
- **APNs**: Required for iOS push notifications

### **⚠️ iOS SETUP IN XCODE (REQUIRED):**
```
1. Open ios/Runner.xcworkspace in Xcode
2. Select Runner target
3. Go to "Signing & Capabilities"
4. Click "+ Capability"
5. Add "Push Notifications"
6. Add "Background Modes"
7. Check "Remote notifications" in Background Modes
```

---

## 📈 FEATURES IMPLEMENTED

### ✅ Core Features:
- [x] Firebase Messaging initialization
- [x] Permission request (iOS/Android 13+)
- [x] FCM token generation and management
- [x] Token refresh handling
- [x] Foreground message handling
- [x] Background message handling
- [x] Terminated state handling
- [x] In-app notification display
- [x] Navigation from notification

### ✅ UI Features:
- [x] Notifications list screen
- [x] Notification badge with count
- [x] Unread indicator
- [x] Mark as read/unread
- [x] Mark all as read
- [x] Delete notification (swipe)
- [x] Delete all notifications
- [x] Pull to refresh
- [x] Empty state
- [x] Error handling
- [x] Loading state
- [x] Time ago formatting

### ✅ Data Features:
- [x] Local storage (SharedPreferences)
- [x] Notification history (last 100)
- [x] Unread count tracking
- [x] JSON serialization
- [x] State management (Riverpod)

---

## 🎯 NEXT STEPS (Optional Enhancements)

### **1. Send FCM Token to Backend**
Tạo API call để gửi token lên server sau khi login:
```dart
Future<void> syncFcmToken() async {
  final token = await FirebaseMessagingService().getToken();
  if (token != null) {
    await apiService.post('/users/me/fcm-token', {
      'token': token,
      'platform': Platform.isIOS ? 'ios' : 'android',
    });
  }
}
```

### **2. Add Notification Settings**
Cho phép user bật/tắt từng loại notification:
- Story updates
- System notifications
- Promotions
- Messages

### **3. Rich Notifications**
- Add images to notifications
- Action buttons (View, Dismiss)
- Big text style

### **4. Analytics**
- Track notification open rate
- Track delivery rate
- User engagement metrics

### **5. Scheduled Notifications**
- Daily reading reminders
- Subscription expiry alerts

---

## 🐛 TROUBLESHOOTING

### **Android:**
- **Notification không hiển thị**: Kiểm tra permission POST_NOTIFICATIONS
- **Token null**: Kiểm tra google-services.json đúng project
- **Background không work**: Verify background handler là top-level function

### **iOS:**
- **Notification không nhận**: 
  - Kiểm tra Push Notifications capability trong Xcode
  - Kiểm tra Background Modes enabled
  - Cần test trên real device (simulator không support push)
- **APNs token null**: Đợi 3-5 giây sau khi request permission

### **Common Issues:**
- **Token không update**: Listen to `onTokenRefresh` stream
- **Navigation không work**: Kiểm tra route đã được define trong router
- **Badge không update**: Verify provider được watch đúng cách

---

## 📞 SUPPORT

Nếu gặp vấn đề, check:
1. Firebase Console → Cloud Messaging → Verify project setup
2. Android: `android/app/google-services.json` exists
3. iOS: APNs certificate configured in Firebase
4. Logs: Check console for FCM token and error messages

---

## 📝 NOTES

- **Storage Limit**: App chỉ lưu 100 notifications gần nhất
- **Token Lifecycle**: Token có thể thay đổi khi reinstall app hoặc clear data
- **iOS Simulator**: Push notifications KHÔNG work trên simulator
- **Privacy**: Always explain why you need notification permission
- **Best Practice**: Request permission at appropriate time, not immediately on launch

---

## 🎉 SUMMARY

✅ Firebase Cloud Messaging đã được tích hợp hoàn chỉnh  
✅ Notification hiển thị ở mọi trạng thái app  
✅ UI đầy đủ với badge, list, và chi tiết  
✅ Native configuration cho cả Android và iOS  
✅ State management với Riverpod  
✅ Local storage cho notification history  
✅ Navigation handling từ notification  

**Bước tiếp theo**: Configure iOS capabilities in Xcode và test trên real devices!

---

**Created**: January 12, 2026  
**Project**: Truyện Hay - Reading Book App  
**Version**: 1.0.0
