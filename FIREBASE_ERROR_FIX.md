# 🔥 Firebase Messaging Error - Troubleshooting Guide

## ❌ LỖI HIỆN TẠI

```
E/FirebaseMessaging: Failed to get FIS auth token
E/FirebaseMessaging: com.google.firebase.installations.FirebaseInstallationsException: 
Firebase Installations Service is unavailable. Please try again later.
```

---

## 🔍 NGUYÊN NHÂN

Lỗi này xảy ra khi **Firebase Installations Service** không thể tạo FIS (Firebase Installations) auth token. Các nguyên nhân phổ biến:

### 1. **Firebase APIs chưa được enable** ⚠️ (Nguyên nhân chính)
   - Cloud Messaging API
   - Firebase Installations API
   - FCM Registration API

### 2. **Vấn đề về cấu hình Firebase**
   - `google-services.json` không đúng
   - Package name không khớp
   - API key không hợp lệ

### 3. **Vấn đề về network**
   - Không có kết nối internet
   - Firewall block Firebase services
   - Emulator không có Google Play Services

### 4. **Firebase Project chưa setup đúng**
   - Project chưa được tạo đầy đủ
   - Cloud Messaging chưa được enable

---

## ✅ CÁCH KHẮC PHỤC

### **BƯỚC 1: Enable Firebase APIs (QUAN TRỌNG NHẤT)**

Bạn cần enable các APIs sau trong Google Cloud Console:

#### **Option A: Enable qua Web Console** (Khuyến nghị)

1. **Firebase Cloud Messaging API:**
   ```
   https://console.cloud.google.com/apis/library/fcm.googleapis.com?project=reading-books-d328a
   ```
   → Click **"ENABLE"**

2. **Firebase Installations API:**
   ```
   https://console.cloud.google.com/apis/library/firebaseinstallations.googleapis.com?project=reading-books-d328a
   ```
   → Click **"ENABLE"**

3. **FCM Registration API:**
   ```
   https://console.cloud.google.com/apis/library/fcmregistrations.googleapis.com?project=reading-books-d328a
   ```
   → Click **"ENABLE"**

4. **Cloud Messaging (Legacy):**
   ```
   https://console.cloud.google.com/apis/library/googlecloudmessaging.googleapis.com?project=reading-books-d328a
   ```
   → Click **"ENABLE"**

#### **Option B: Enable qua gcloud CLI**

```bash
# Set project
gcloud config set project reading-books-d328a

# Enable APIs
gcloud services enable fcm.googleapis.com
gcloud services enable firebaseinstallations.googleapis.com
gcloud services enable fcmregistrations.googleapis.com
gcloud services enable googlecloudmessaging.googleapis.com

# Verify enabled
gcloud services list --enabled
```

---

### **BƯỚC 2: Kiểm tra Firebase Console**

1. Vào Firebase Console:
   ```
   https://console.firebase.google.com/project/reading-books-d328a
   ```

2. **Check Cloud Messaging:**
   - Sidebar → **Build** → **Cloud Messaging**
   - Nếu thấy "Get started", click vào để enable
   - Nếu đã enable, bạn sẽ thấy dashboard

3. **Check Project Settings:**
   - Click ⚙️ icon → **Project settings**
   - Tab **General**: Verify project info
   - Tab **Cloud Messaging**: 
     - Copy **Server key** (nếu có)
     - Check **Firebase Cloud Messaging API (V1)** is enabled

---

### **BƯỚC 3: Verify google-services.json**

File hiện tại của bạn có vẻ OK, nhưng để chắc chắn:

1. Vào Firebase Console → Project settings → Your apps
2. Chọn Android app: `com.example.reading_book`
3. Download lại `google-services.json` mới nhất
4. Replace file tại:
   ```
   android/app/google-services.json
   ```

**Lưu ý:** Package name phải khớp: `com.example.reading_book`

---

### **BƯỚC 4: Kiểm tra Package Name**

Package name trong 3 file phải giống nhau:

1. **android/app/build.gradle.kts:**
   ```kotlin
   applicationId = "com.example.reading_book"
   ```
   ✅ Đã đúng

2. **android/app/src/main/AndroidManifest.xml:**
   ```xml
   <manifest xmlns:android="http://schemas.android.com/apk/res/android">
   ```
   ✅ OK (auto-generated)

3. **google-services.json:**
   ```json
   "package_name": "com.example.reading_book"
   ```
   ✅ Đã đúng

---

### **BƯỚC 5: Clean và Rebuild**

```bash
# Clean Flutter
flutter clean

# Clean Android
cd android
./gradlew clean
cd ..

# Get dependencies
flutter pub get

# Rebuild
flutter run
```

---

### **BƯỚC 6: Nếu đang dùng Emulator**

**Vấn đề:** Android Emulator có thể không có Google Play Services đầy đủ.

**Giải pháp:**

1. **Dùng Emulator có Google Play:**
   - Trong Android Studio → AVD Manager
   - Chọn device image có **Play Store** icon
   - Hoặc tạo mới: Pixel 4 API 33 (Google Play)

2. **Hoặc test trên Real Device:**
   ```bash
   # Enable USB debugging trên phone
   # Kết nối USB
   flutter devices
   flutter run -d <device-id>
   ```

---

### **BƯỚC 7: Kiểm tra Internet Connection**

```bash
# Test Firebase connectivity từ emulator/device
adb shell ping -c 4 firebaseinstallations.googleapis.com
adb shell ping -c 4 fcm.googleapis.com
```

Nếu không ping được → vấn đề về network/firewall.

---

## 🔄 SAU KHI ENABLE APIs

**Đợi 5-10 phút** để APIs được propagate, sau đó:

```bash
# 1. Clean project
flutter clean

# 2. Rebuild
flutter pub get
flutter run

# 3. Check logs
# Bạn sẽ thấy:
# ✅ Firebase initialized successfully
# ✅ FCM Token: [token_here]
```

---

## 🧪 TEST

Sau khi fix, bạn sẽ thấy trong logs:

```
✅ Firebase Messaging initialized successfully
🔑 FCM Token: ey...  (long token string)
📲 Notification permission status: authorized
```

---

## ⚠️ LƯU Ý QUAN TRỌNG

### **1. APIs mất 5-10 phút để activate**
Sau khi enable APIs, đợi một chút trước khi rebuild app.

### **2. Dùng Real Device để test**
iOS Simulator và một số Android Emulators không support push notifications đầy đủ.

### **3. Check Billing (nếu cần)**
Firebase Cloud Messaging cần project có Blaze plan (pay-as-you-go) cho một số features, nhưng FCM cơ bản là free.

### **4. API Restrictions**
Nếu API key bị restrict, bạn cần allow FCM APIs:
```
Google Cloud Console → APIs & Services → Credentials
→ Chọn API key → API restrictions → Allow FCM APIs
```

---

## 📞 NẾU VẪN LỖI

### **Kiểm tra chi tiết hơn:**

```bash
# Enable verbose logging
adb shell setprop log.tag.FirebaseMessaging DEBUG
adb shell setprop log.tag.FirebaseInstanceId DEBUG

# Run app và check logs
flutter run
```

### **Verify APIs status:**

```bash
# Check if APIs are enabled
gcloud services list --enabled --project=reading-books-d328a | grep -E "fcm|firebase"
```

### **Common issues:**

1. **"SERVICE_NOT_AVAILABLE"** → APIs chưa enable hoặc chưa propagate
2. **"API_KEY_INVALID"** → Download lại google-services.json
3. **"MISSING_INSTANCEID_SERVICE"** → Google Play Services outdated trên device

---

## 🎯 TÓM TẮT NHANH

**Để fix lỗi này:**

1. ✅ Enable 4 APIs trong Google Cloud Console (links ở trên)
2. ✅ Đợi 5-10 phút
3. ✅ `flutter clean && flutter pub get && flutter run`
4. ✅ Test trên real device hoặc emulator có Google Play
5. ✅ Check logs xem có token không

**Link nhanh enable APIs:**
- FCM API: https://console.cloud.google.com/apis/library/fcm.googleapis.com?project=reading-books-d328a
- Firebase Installations: https://console.cloud.google.com/apis/library/firebaseinstallations.googleapis.com?project=reading-books-d328a
- FCM Registration: https://console.cloud.google.com/apis/library/fcmregistrations.googleapis.com?project=reading-books-d328a

---

**Priority:** Enable APIs → Wait 5-10 mins → Clean & Rebuild → Test

Chúc may mắn! 🚀
