# Block Note App

A "Block Note" style note-taking application developed in Flutter, with offline support and automatic synchronization when there is an internet connection.

## Description

Block Note allows users to create, edit, and delete notes with custom icons. Notes are saved locally using Hive and synced with Firebase Firestore when a connection is available. A Wi-Fi icon is also displayed on notes awaiting syncing.

---

## Project Setup

1. **Clone the repository**
bash
git clone <repository-url>

cd block_note
Install dependencies

bash
Copy code
flutter pub get
Configure Firebase

Create a Firebase project.

Add Firebase for Android and iOS following the official documentation.

Download the google-services.json (Android) and GoogleService-Info.plist (iOS) files and place them in the corresponding directories.

Enable Authentication > Email/Password.
Create the notes collection in Firestore.
Configure Hive (local storage)
Initialize Hive in main.dart:
dart
Copy code
await Hive.initFlutter();
Hive.registerAdapter(BlockEntityAdapter());
await Hive.openBox<BlockEntity>('blocks');
How to run the app locally
bash
Copy code
flutter run
Select the emulator or physical device.

Notes created offline are saved locally and automatically synced when the device detects an internet connection.

2. **Database Schema**
Collection: notes (Firestore)
Field Type Description
id String Unique note ID
title String Note title
content String Note content
iconData int Code of the selected icon
userId String Owner user ID
createdAt Timestamp Creation date
updatedAt Timestamp Last modified date (optional)

3. *Local Storage (Hive)**
Box: blocks

The same information as Firestore is stored, plus a pending synchronization status handled in memory (pendingSyncIds).

4. **Authentication**
Firebase Authentication with email and password is used.

Login, registration, and logout are managed from the AuthViewModel.

Navigation depends on the user's authentication status: it automatically redirects to the login page or the notes list.

5. **Assumptions and trade-offs**
Offline notes are marked as pending synchronization and are automatically uploaded when a connection is available.

The synchronization status is not stored in Firestore, only in memory (pendingSyncIds).

Offline user experience and local data integrity were prioritized over immediate real-time consistency.

Hive is used for simplicity and performance for local storage.

The iconData of the blocks corresponds to the Material Icons.

6. **Next steps/improvements**
Display a clearer visual indicator for notes pending synchronization.

Handle conflicts if the same note is edited offline and online before syncing.

Support for multiple users within the same application, allowing for the creation of notes by a single group of users.

Add unit and integration tests to ensure proper offline/online synchronization.

7. **link to appstore**
