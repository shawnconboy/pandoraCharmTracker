# Pandora Charm Tracker

Pandora Charm Tracker is a SwiftUI iOS app to manage your Pandora charm collection, wishlist, and friends, with a focus on gift-giving.

## Features
- Email/password authentication using FirebaseAuth
- Manage your charm collection and wishlist
- Add friends and view their public collections/wishlists
- Built with SwiftUI + Firebase + MVVM

## Firebase Setup

1. Create a Firebase project at [Firebase Console](https://console.firebase.google.com/)
2. Enable **Authentication** (Email/Password)
3. Enable **Cloud Firestore** (start in test mode)
4. Enable **Storage** (start in test mode)
5. Download your `GoogleService-Info.plist` from Firebase Console
6. Place `GoogleService-Info.plist` in the project root (`PandoraCharmTracker/PandoraCharmTracker/`)

### Firestore Collections
- `users`: user profiles
- `charms`: charm catalog
- `collectionItems`: user's owned charms
- `wishlistItems`: user's wishlisted charms
- `friendships`: friend requests and status

### Firebase Rules (Test Mode)
#### Firestore
```
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write: if true;
    }
  }
}
```

#### Storage
```
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    match /{allPaths=**} {
      allow read, write: if true;
    }
  }
}
```

## Charm Catalog
A sample catalog is provided in `Resources/charm_catalog.json`.

---

*Built with SwiftUI, Firebase, and MVVM.*
