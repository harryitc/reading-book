# 🔄 FCM Token Auto-Sync Guide

## 📖 GIẢI THÍCH WORKFLOW

### ❓ **Câu hỏi: "Mỗi lần start project phải lấy token thủ công?"**

**Trả lời: KHÔNG!** Token được xử lý tự động theo flow sau:

---

## 🎯 WORKFLOW THỰC TẾ

### **1️⃣ Khi User Mở App Lần Đầu:**
```
App Start
  ↓
Firebase Messaging Service Init (tự động)
  ↓
Request Permission (iOS/Android 13+)
  ↓
Lấy FCM Token (tự động)
  ↓
Gửi Token lên Backend API (tự động) ← CẦN IMPLEMENT
  ↓
Backend lưu: user_id → fcm_token
```

### **2️⃣ Khi User Đăng Nhập:**
```
User Login Success
  ↓
Lấy FCM Token hiện tại
  ↓
Gửi Token + User ID lên Backend
  ↓
Backend link token với user account
```

### **3️⃣ Khi Token Refresh (hiếm khi):**
```
Firebase tự động refresh token
  ↓
Listen onTokenRefresh stream
  ↓
Tự động gửi token mới lên Backend
  ↓
Backend update token
```

### **4️⃣ Khi User Logout:**
```
User Logout
  ↓
Xóa token trên Backend
  ↓
Xóa token local (optional)
```

---

## 💡 TOKEN CHỈ CẦN GỬI 1 LẦN

**Token không thay đổi thường xuyên.** Chỉ cần gửi lên backend trong các trường hợp:

✅ **User login lần đầu**  
✅ **User reinstall app**  
✅ **Token bị refresh (rất hiếm)**  
✅ **User clear app data**  

---

## 🔧 CÁCH SỬ DỤNG TOKEN SYNC SERVICE

### **Option 1: Sync After Login (Recommended)**

```dart
// In your login service
class AuthService {
  final FcmTokenSyncService _fcmSync = FcmTokenSyncService(
    FirebaseMessagingService()
  );

  Future<void> login(String email, String password) async {
    // 1. Login user
    final response = await api.login(email, password);
    final userId = response['user_id'];
    final authToken = response['token'];
    
    // 2. Auto-sync FCM token to backend
    await _fcmSync.syncTokenToBackend(
      userId: userId,
      authToken: authToken,
    );
    
    // 3. Setup auto-sync on token refresh
    _fcmSync.setupAutoSync(
      userId: userId,
      authToken: authToken,
    );
  }
}
```

### **Option 2: Sync in Main.dart (Immediate)**

```dart
// Ngay sau khi init FCM
final fcmService = FirebaseMessagingService();
await fcmService.initialize();

// Nếu user đã login
final currentUserId = await getCurrentUserId();
if (currentUserId != null) {
  final syncService = FcmTokenSyncService(fcmService);
  await syncService.syncTokenToBackend(userId: currentUserId);
}
```

### **Option 3: Sync on App Resume**

```dart
class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Check and sync token if needed
      _syncTokenIfNeeded();
    }
  }

  Future<void> _syncTokenIfNeeded() async {
    final userId = await getCurrentUserId();
    if (userId != null) {
      final syncService = FcmTokenSyncService(fcmService);
      await syncService.syncTokenToBackend(userId: userId);
    }
  }
}
```

---

## 🖥️ BACKEND API REQUIREMENTS

Backend cần có các endpoints:

### **1. Save/Update Token**
```
POST /api/users/:userId/fcm-token
Headers: Authorization: Bearer {token}
Body:
{
  "token": "fcm_token_string",
  "platform": "android|ios",
  "timestamp": "2026-01-12T10:30:00Z"
}

Response 200:
{
  "success": true,
  "message": "Token saved"
}
```

### **2. Delete Token (Logout)**
```
DELETE /api/users/:userId/fcm-token
Headers: Authorization: Bearer {token}

Response 204: No Content
```

### **3. Get User Tokens (Admin)**
```
GET /api/users/:userId/fcm-token
Headers: Authorization: Bearer {admin_token}

Response 200:
{
  "tokens": [
    {
      "token": "fcm_token_string",
      "platform": "android",
      "last_updated": "2026-01-12T10:30:00Z"
    }
  ]
}
```

---

## 💾 DATABASE SCHEMA EXAMPLE

```sql
CREATE TABLE fcm_tokens (
  id SERIAL PRIMARY KEY,
  user_id INTEGER NOT NULL,
  token TEXT NOT NULL UNIQUE,
  platform VARCHAR(10) NOT NULL, -- 'ios' or 'android'
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW(),
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Index for faster lookup
CREATE INDEX idx_fcm_tokens_user_id ON fcm_tokens(user_id);
CREATE INDEX idx_fcm_tokens_token ON fcm_tokens(token);
```

---

## 🔐 SECURITY BEST PRACTICES

### **1. Always Use Authentication**
```dart
await _fcmSync.syncTokenToBackend(
  userId: userId,
  authToken: authToken, // ← REQUIRED
);
```

### **2. Validate on Backend**
```javascript
// Backend validation
if (req.headers.authorization !== 'Bearer ' + validToken) {
  return res.status(401).json({ error: 'Unauthorized' });
}

// Verify user owns the token they're updating
if (req.params.userId !== req.user.id) {
  return res.status(403).json({ error: 'Forbidden' });
}
```

### **3. Rate Limiting**
```javascript
// Limit token updates to prevent abuse
const rateLimit = require('express-rate-limit');

const tokenUpdateLimiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 5, // Max 5 updates per 15 minutes
});

app.post('/api/users/:userId/fcm-token', tokenUpdateLimiter, handler);
```

---

## 🧪 TESTING TOKEN SYNC

### **Test 1: Manual Sync**
```dart
// In your test or debug screen
ElevatedButton(
  onPressed: () async {
    final syncService = FcmTokenSyncService(
      FirebaseMessagingService()
    );
    
    final success = await syncService.syncTokenToBackend(
      userId: 'test_user_123',
      authToken: 'your_auth_token',
    );
    
    print(success ? '✅ Synced' : '❌ Failed');
  },
  child: Text('Test Token Sync'),
)
```

### **Test 2: Check Backend**
```bash
# After sync, verify token in backend
curl -X GET \
  http://your-backend/api/users/test_user_123/fcm-token \
  -H "Authorization: Bearer YOUR_TOKEN"
```

---

## 📊 TOKEN LIFECYCLE

```
┌─────────────────────────────────────────────┐
│  App Install / First Launch                 │
│  ↓                                           │
│  Generate FCM Token                          │
│  ↓                                           │
│  Send to Backend                             │
│  ↓                                           │
│  Backend: Store (user_id → token)           │
└─────────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────────┐
│  Token Valid for Months/Years               │
│  (Rarely Changes)                            │
└─────────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────────┐
│  Token Refresh Event (Rare)                 │
│  ↓                                           │
│  onTokenRefresh Stream                       │
│  ↓                                           │
│  Auto-Send New Token to Backend             │
│  ↓                                           │
│  Backend: Update Token                       │
└─────────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────────┐
│  User Logout                                 │
│  ↓                                           │
│  Delete Token from Backend                   │
│  ↓                                           │
│  (Optional) Delete Local Token              │
└─────────────────────────────────────────────┘
```

---

## 🎯 TÓM TẮT

### ✅ **Đúng:**
- Token được lấy **TỰ ĐỘNG** khi app start
- Token được gửi lên backend **TỰ ĐỘNG** sau login
- Token được update **TỰ ĐỘNG** khi refresh
- Admin dùng backend API để push notification

### ❌ **SAI:**
- Copy token thủ công từ log
- Gửi token thủ công mỗi lần
- Dùng token trực tiếp từ mobile app

---

## 🚀 INTEGRATION CHECKLIST

- [ ] Tạo backend API endpoints (POST, DELETE token)
- [ ] Update `FcmTokenSyncService` với backend URL
- [ ] Call `syncTokenToBackend()` sau khi user login
- [ ] Setup `setupAutoSync()` để tự động update khi token refresh
- [ ] Call `deleteTokenFromBackend()` khi user logout
- [ ] Test sync token thành công
- [ ] Test nhận notification từ backend

---

## 💡 EXAMPLE: Complete Integration

```dart
// 1. In your AuthProvider/AuthService
class AuthProvider extends StateNotifier<AuthState> {
  final FcmTokenSyncService _fcmSync;
  
  AuthProvider(this._fcmSync) : super(AuthState.initial());

  Future<void> login(String email, String password) async {
    // Login
    final result = await _authApi.login(email, password);
    
    // Sync FCM token
    await _fcmSync.syncTokenToBackend(
      userId: result.userId,
      authToken: result.accessToken,
    );
    
    // Auto-sync on token refresh
    _fcmSync.setupAutoSync(
      userId: result.userId,
      authToken: result.accessToken,
    );
    
    state = AuthState.authenticated(result);
  }

  Future<void> logout() async {
    final userId = state.user?.id;
    
    // Delete token from backend
    if (userId != null) {
      await _fcmSync.deleteTokenFromBackend(userId: userId);
    }
    
    // Logout
    await _authApi.logout();
    state = AuthState.unauthenticated();
  }
}
```

---

**Kết luận:** Token được xử lý **HOÀN TOÀN TỰ ĐỘNG**, không cần copy-paste thủ công! 🎉
