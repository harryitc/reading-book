#!/bin/bash
# Script to enable required Firebase APIs

# Enable Firebase Cloud Messaging API
echo "Enabling Firebase Cloud Messaging API..."
echo "Visit: https://console.cloud.google.com/apis/library/fcm.googleapis.com?project=reading-books-d328a"

# Enable Firebase Installations API
echo "Enabling Firebase Installations API..."
echo "Visit: https://console.cloud.google.com/apis/library/firebaseinstallations.googleapis.com?project=reading-books-d328a"

# Enable FCM Registration API
echo "Enabling FCM Registration API..."
echo "Visit: https://console.cloud.google.com/apis/library/fcmregistrations.googleapis.com?project=reading-books-d328a"

echo ""
echo "Hoặc enable tất cả tự động bằng gcloud CLI:"
echo "gcloud services enable fcm.googleapis.com --project=reading-books-d328a"
echo "gcloud services enable firebaseinstallations.googleapis.com --project=reading-books-d328a"
echo "gcloud services enable fcmregistrations.googleapis.com --project=reading-books-d328a"
