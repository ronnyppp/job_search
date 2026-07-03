# Job Search App

A Flutter mobile application for browsing and managing job listings.  
The app uses a GraphQL API powered by Apollo Server to fetch job data and uses SQLite for local data persistence.

## Features

- Browse available job listings
- Search jobs by title and company
- View detailed job information
- Favorite/unfavorite jobs
- Local job storage with SQLite
- GraphQL API integration
- State management using Riverpod
- Reusable Flutter widgets

## Tech Stack

### Frontend
- Flutter
- Dart
- Riverpod (State Management)
- SQLite / sqflite
- GraphQL Flutter

### Backend
- Node.js
- Apollo Server
- GraphQL

## Images

<p>
  <img width="200" alt="Screenshot_1782930877" src="https://github.com/user-attachments/assets/b5e4fa57-f4e0-4899-a634-1c5e58ed65ab" />
  <img width="200" alt="Screenshot_1782930897" src="https://github.com/user-attachments/assets/e22aaf30-4333-4921-95a4-017c31c9708d" />  
  <img width="200" alt="Screenshot_1782930881" src="https://github.com/user-attachments/assets/6d04225e-15e4-4b42-93a7-336cff979f73" />
</p>

## Running the Application

### Prerequisites

* Flutter SDK
* Dart SDK
* Node.js (v18 or later)
* Android Studio or Visual Studio Code
* Android Emulator or a physical Android device

### Installation

1. Clone the repository.

```bash
git clone https://github.com/ronnyppp/job_search.git
cd job_search
```

2. Install Flutter dependencies.

```bash
flutter pub get
```

3. Install the backend dependencies.

```bash
cd job-api
npm install
```

### Start the GraphQL Server

From the `job-api` directory, run:

```bash
node server.js
```

The Apollo GraphQL server will start on:

```text
http://localhost:4000/
```

### Run the Flutter Application

Open a new terminal, navigate to the Flutter project directory, and run:

```bash
flutter run
```
