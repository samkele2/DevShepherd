>>>>>>> # DevShepherd 🐑

DevShepherd is a Flutter learning-goal tracker designed to help developers organise, track, and monitor their learning journey.

The project was built as part of my journey into software development, with a focus on learning **Dart, Flutter, Firebase, software architecture, and automated testing**.

## Features

### Authentication

* User registration with email and password
* User login with email and password
* Firebase Authentication integration
* Authenticated sessions persist between app launches
* User-friendly error messages for failed authentication

### Learning Goals

* Add learning goals
* View active learning goals
* View completed learning goals
* Mark goals as completed
* Delete learning goals
* Display progress toward completing goals
* Prevent empty learning goals from being added

### Data Storage

Learning goals are stored using **Cloud Firestore**.

The application uses a service-based architecture so that the UI does not communicate directly with Firestore.

```text
LearningGoalsPage
       ↓
LearningGoalService
       ↓
FirebaseLearningGoalService
       ↓
Cloud Firestore
```

This also makes the application easier to test because a fake service can be used instead of Firebase.

## Testing

Automated tests are an important part of DevShepherd.

The project currently contains **38 passing tests** covering areas including:

* Learning goal model behaviour
* Learning goal UI
* Adding goals
* Completing goals
* Deleting goals
* Active and completed goal sections
* Progress display
* Empty states
* Input validation
* Authentication UI
* Authentication failure handling
* Learning goal service behaviour

The project uses Flutter's testing framework:

```bash
flutter test
```

Static analysis can be run with:

```bash
flutter analyze
```

## Technologies

* **Dart**
* **Flutter**
* **Firebase Authentication**
* **Cloud Firestore**
* **Flutter Test**
* **Git / GitHub**

## Project Structure

```text
lib/
├── models/
│   └── learning_goal.dart
│
├── pages/
│   ├── auth_page.dart
│   └── learning_goals_page.dart
│
├── services/
│   ├── auth_service.dart
│   ├── firebase_auth_service.dart
│   ├── learning_goal_service.dart
│   └── firebase_learning_goal_service.dart
│
└── main.dart

test/
├── auth_page_test.dart
├── learning_goals_page_test.dart
├── learning_goal_service_test.dart
├── fake_auth_service.dart
└── fake_learning_goal_service.dart
```

## Architecture

DevShepherd uses a simple service abstraction to separate application logic from external services.

For example, authentication is defined through:

```dart
abstract class AuthService {
  Future<UserCredential> signUp(
    String email,
    String password,
  );

  Future<UserCredential> login(
    String email,
    String password,
  );
}
```

The application then provides a Firebase implementation:

```text
AuthPage
   ↓
AuthService
   ↓
FirebaseAuthService
   ↓
Firebase Authentication
```

The same approach is used for learning goals.

This allows tests to use fake implementations without requiring the application to connect to Firebase.

## Getting Started

### Prerequisites

You will need:

* Flutter SDK
* Dart SDK
* A Firebase project
* Android Studio or another Flutter-compatible IDE

### Installation

Clone the repository:

```bash
git clone <your-repository-url>
```

Navigate into the project:

```bash
cd dev_shepherd
```

Install dependencies:

```bash
flutter pub get
```

Run the application:

```bash
flutter run
```

### Run Tests

```bash
flutter test
```

### Run Static Analysis

```bash
flutter analyze
```

## Firebase Configuration

DevShepherd uses Firebase for:

* Authentication
* Cloud Firestore

Firebase configuration files are generated using the FlutterFire CLI.

Firebase credentials and other sensitive configuration should not be committed to source control.

## Current Status

DevShepherd is an active learning project.

The core authentication and learning-goal functionality is working, and the project currently has **38 passing automated tests**.

Testing and development are ongoing, with additional work planned around Firebase service testing, authentication validation, persistent goal updates, and end-to-end application flows.

## Learning Goals

This project is helping me develop practical experience with:

* Flutter application development
* Dart
* Object-oriented programming
* Firebase
* Cloud Firestore
* Authentication
* Dependency injection
* Service abstractions
* Unit testing
* Widget testing
* Testable application architecture
* Git and GitHub

## Author

**Samkele Njiva**

Aspiring software developer with a background in geology, currently developing practical software engineering skills through hands-on projects.
