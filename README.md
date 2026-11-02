<<<<<<< HEAD
Excelerate Mobile App
A clean, responsive mobile application built with Flutter that provides learners with a seamless platform to discover programs, register for professional development workshops, track event schedules, and submit session feedback.
Table of Contents
 * Project Overview
 * Key Features
 * Tech Stack
 * Folder Structure
 * Setup and Installation
 * Screenshots
 * Contribution Log
Project Overview
The Excelerate Mobile App centralizes career development opportunities for ambitious learners. The application eliminates manual administrative overhead by enabling automated registration and feedback tracking via a dedicated REST API integration.
Key Features
 * User Authentication: Login interface with validation for learner accounts.
 * Learner Dashboard: Overview metrics showing registered programs, upcoming events, and submitted feedback.
 * Program Catalog & Filtering: Dynamic course listings filterable by category (Leadership, Tech Skills, Wellness, Career).
 * Program Details: In-depth view of program schedules, providers, and eligibility criteria.
 * Registration & Feedback Forms: Interactive tabbed interface supporting real-time data submission to Mock API endpoints.
Tech Stack
 * Framework: Flutter (Dart)
 * API Integration: http package connected to RESTful Mock API endpoints
 * Version Control: Git & GitHub
Folder Structure
lib/
├── models/
├── navigations/
├── screens/
│   ├── home_screen.dart
│   ├── login_screen.dart
│   ├── program_details_screen.dart
│   ├── program_listing_screen.dart
│   ├── registration_feedback_screen.dart
│   └── stats_screen.dart
├── theme/
├── widgets/
└── main.dart

Setup and Installation
Prerequisites
 * Flutter SDK (latest stable release)
 * Dart SDK
 * Android Studio, VS Code, or Xcode (for iOS builds)
Steps
 * Clone the repository:
   git clone https://github.com/sandilendroi-oss/Spend_wise_app.git
cd Spend_wise_app
=======
# Excelerate — Program Discovery & Registration App

> **A Flutter mobile application that helps learners discover, explore, and register for professional development programs.**

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?logo=dart)](https://dart.dev)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

---

## 📖 Table of Contents

1. [Project Overview](#-project-overview)
2. [Key Features](#-key-features)
3. [Screenshots & Navigation Flow](#-navigation-flow)
4. [Tech Stack](#-tech-stack)
5. [Project Structure](#-project-structure)
6. [Data Models](#-data-models)
7. [Services & API](#-services--api)
8. [Theme & Design System](#-theme--design-system)
9. [Getting Started](#-getting-started)
10. [Configuration](#-configuration)
11. [Roadmap](#-roadmap)
12. [Team](#-team)

---

## 🎯 Project Overview

**Excelerate** is a cross-platform Flutter mobile app built to bridge the gap between learners and professional development opportunities. Users can browse upcoming programs across categories like **Leadership**, **Tech Skills**, **Wellness**, and **Career Development**, view full program details including schedules and eligibility criteria, and register directly from the app.

The app also includes a **Feedback Form** so participants can rate and review programs after attending.

> **Current Status:** Week 3 — Core screens are fully built with live mock-API integration. Registration and feedback forms POST data to a real REST API endpoint.

---

## ✨ Key Features

| Feature | Description |
|---|---|
| 🔐 **Secure Login** | Email/password form with validation. Simulates network authentication with a loading state. |
| 🗂️ **Program Listing** | Scrollable card list of all available programs, fetched from a REST API. Pull-to-refresh supported. |
| 🔍 **Search & Filter** | Real-time search by program title or provider. Category filter chips (All, Leadership, Tech Skills, Wellness, Career). |
| 📋 **Program Details** | Full-page view with hero image, description, provider, schedule, eligibility criteria, and a Register CTA. |
| 📝 **Registration Form** | Collect Name, Email, Phone, and Experience Level. Submits via HTTP POST to the Mock API. Success/error dialogs. |
| 💬 **Feedback Form** | Satisfaction rating (dropdown) + free-text comments. Submits via HTTP POST to the same API. |
| ⚠️ **Error Handling** | Friendly error screens with retry buttons for network failures, timeouts, and bad JSON responses. |
| 🎨 **Brand Design System** | Consistent Excelerate color palette (coral → pink → magenta gradient), reusable widgets and card components. |

---

## 🧭 Navigation Flow

```mermaid
flowchart TD
    A[🔑 Login Screen] -->|Valid credentials| B[📋 Program Listing]
    B -->|Tap a program card| C[📄 Program Details]
    B -->|Pull to refresh| B
    C -->|Tap Register| D[📝 Registration & Feedback Hub]
    D -->|Tab: Registration| E[Registration Form]
    D -->|Tab: Feedback| F[Feedback Form]
    E -->|Submit| G[✅ Success Dialog → back to listing]
    F -->|Submit| H[✅ Success Dialog → reset form]
```

**In plain words:**

1. The user opens the app on the **Login** screen and enters their credentials.
2. After login they land on **Program Listing**, which loads programs from the API with a loading spinner. A pull-down gesture refreshes the list.
3. From the listing screen, they can **search** by keyword or **filter by category** using the chip row.
4. Tapping a program card opens **Program Details**, showing the full description, schedule, and eligibility criteria.
5. Tapping **Register** opens the **Forms Hub**, a tabbed screen that hosts both the Registration Form and the Feedback Form.
6. Submitting either form sends a POST request to the API and shows a confirmation dialog.

---

## 🛠 Tech Stack

| Layer | Technology |
|---|---|
| **Framework** | Flutter 3 / Dart 3 |
| **HTTP Client** | [`http ^1.2.2`](https://pub.dev/packages/http) |
| **API** | MockAPI REST (`https://mockapi.io`) |
| **State Management** | Flutter built-in `StatefulWidget` + `FutureBuilder` |
| **Design** | Material 3, custom `AppTheme`, `AppColors` |
| **Platform targets** | Android · iOS · Web · macOS · Linux · Windows |

---

## 📁 Project Structure

```
lib/
├── main.dart                          # App entry point; wires theme + initial route
│
├── screens/
│   ├── login_screen.dart              # Email/password login with form validation
│   ├── program_listing_screen.dart    # Browseable list with search & category filters
│   ├── program_details_screen.dart    # Full program info + Register button
│   └── registration_feedback_screen.dart  # Tabbed Registration & Feedback forms
│
├── models/
│   ├── program.dart                   # Program data class + fromJson / toJson
│   ├── event.dart                     # Event data class (proposed, future use)
│   ├── expense.dart                   # Expense data class (legacy, future use)
│   ├── spend_category.dart            # SpendCategory data class (legacy)
│   └── json_helpers.dart              # readString / readStringList helpers
│
├── services/
│   ├── api_service.dart               # Generic HTTP client, error handling, parsing
│   └── program_service.dart           # Provides mock program data (simulates API)
│
├── widgets/
│   └── bottom_nav_bar.dart            # Shared bottom navigation bar widget
│
└── theme/
    ├── app_colors.dart                # Brand color constants + gradient
    └── app_theme.dart                 # MaterialTheme light configuration
```

---

## 🗄️ Data Models

### `Program`

The central model representing a learning program. All fields are parsed defensively — only `title` is required; all others fall back to an empty string so a single bad record cannot crash the UI.

| Field | Type | Description |
|---|---|---|
| `id` | `String` | Unique identifier from the API |
| `title` | `String` | Program name *(required)* |
| `date` | `String` | Date range or single session date |
| `category` | `String` | `Leadership`, `Tech Skills`, `Wellness`, `Career` |
| `image` | `String` | URL to the program cover image |
| `provider` | `String` | Organization or team running the program |
| `description` | `String` | Full description of program content |
| `schedule` | `String` | Days and time slots |
| `eligibility` | `List<String>` | Bullet list of participation requirements |

### `Event` *(Proposed — future use)*

| Field | Type | Description |
|---|---|---|
| `id` | `String` | Unique identifier |
| `title` | `String` | Event name *(required)* |
| `description` | `String` | Short summary |
| `date` | `String` | Date string |
| `location` | `String` | Venue or online link |
| `programId` | `String?` | Optional link to a parent program |

---

## 🔌 Services & API

### `ApiService`

A generic, injectable HTTP client that handles the full lifecycle of an API call:

1. **Request** — GET with `Accept: application/json`, 10 s timeout.
2. **HTTP status check** — throws `ApiException` for any non-2xx status.
3. **JSON decoding** — decodes `utf8` bytes, validates the response is a `List`.
4. **Model parsing** — passes each item to a caller-supplied `fromJson` factory; any `FormatException` becomes an `ApiException` with the item index.

The base URL is configurable at build time:

```bash
flutter run --dart-define=API_BASE_URL=https://your-api.mockapi.io/api/v1
```

**Error type:** `ApiException(message, {statusCode?})` — always a human-readable English message, safe to display directly in the UI.

### `ProgramService`

A thin wrapper used by the Program Listing screen. Currently returns **mock data** with a simulated 2-second network delay. Swap in `ApiService.fetchPrograms()` to go live.

### Mock API Endpoint

| Method | URL | Purpose |
|---|---|---|
| `GET` | `/api/v1/programs` | Fetch all programs |
| `POST` | `/api/v1/programs` | Submit registration or feedback |

Base URL: `https://6adc37259cae184827ad0d2b.mockapi.io/api/v1`

---

## 🎨 Theme & Design System

### Color Palette

| Token | Hex | Usage |
|---|---|---|
| `orangeColor` | `#EA7553` | Icons, loading indicators |
| `coralColor` / `primaryColor` | `#EB684B` | Login background, primary buttons |
| `pinkColor` | `#D9508A` | Category chips (selected), icons |
| `magentaColor` / `secondaryColor` | `#CC43B3` | Gradient end color |
| `backgroundColor` | `#FFF7F4` | Warm off-white page background |
| `cardWhiteColor` | `#FFFFFF` | Card surfaces, form fields |
| `textColor` | `#2B2B33` | Body text, labels |

### Brand Gradient

A four-stop linear gradient (orange → coral → pink → magenta) applied to app bar headers and primary action buttons throughout the app.

```dart
AppColors.brandGradient  // LinearGradient([orangeColor, coralColor, pinkColor, magentaColor])
```

---

## 🚀 Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) ≥ 3.x  
- Dart SDK ≥ 3.x  
- An emulator, simulator, or physical device (or Chrome for web)

Run `flutter doctor` to verify your setup.

### Installation

```bash
# 1. Clone the repository
git clone <repository-url>
cd Speed_wise_app
>>>>>>> 2752416 ( i have updated the Readme to me more detailed)

 * Install dependencies:
   flutter pub get

<<<<<<< HEAD
 * Run the application:
   flutter run

Team and Workflow
Team 3 (0510 SLU MAD)

Shimaa Kamal M
Adeniyi Adeyinka
Ange Mukundente
Sabikun Naher Meem
Chaudhary Siddhant Baliyan
Emama
Eseosa Ogolo
Kevin Okhale
Sandile Ndroi
Shariana Dee
Mohana Aswath
Git workflow: Each contributor works on a separate branch, commits with clear messages, and opens a pull request into main.
=======
# 3. Run on your target device
flutter run

# Run on Chrome (web)
flutter run -d chrome

# Build a release APK
flutter build apk --release
```

---
>>>>>>> 2752416 ( i have updated the Readme to me more detailed)

## ⚙️ Configuration

| Variable | How to set | Default |
|---|---|---|
| `API_BASE_URL` | `--dart-define=API_BASE_URL=<url>` | MockAPI placeholder |

Example with a custom API:

```bash
flutter run --dart-define=API_BASE_URL=https://my-real-api.com/api/v1
```

---

## 🗺️ Roadmap

- [x] Week 1 — Project proposal, wireframes, repository setup  
- [x] Week 2 — UI prototype with navigation and sample data  
- [x] Week 3 — Mock API integration, registration & feedback forms  
- [ ] Week 4 — Real authentication (Firebase Auth or JWT)  
- [ ] Week 4 — Persistent local storage (Hive / SQLite)  
- [ ] Later — Push notifications for upcoming programs  
- [ ] Later — User profile & registration history  
- [ ] Later — Monthly analytics & spending reports (legacy SpendWise features)  

---

## 👥 Team

**Team 3 — 0510 SLU MAD**

| Name | Role |
|---|---|
| Shimaa Kamal M | Team Lead / UI |
| Adeniyi Adeyinka | Developer |
| Ange Mukundente | Developer |
| Sabikun Naher Meem | Developer |
| Chaudhary Siddhant Baliyan | Developer |
| Emama | Developer |
| Eseosa Ogolo | Developer |
| Kevin Okhale | Developer |
| Sandile Ndroi | Developer |
| Shariana Dee | Developer |
| Mohana Aswath | Developer |

**Git workflow:** Each contributor works on a separate feature branch, commits with descriptive messages, and opens a pull request into `main` for review before merging.

---

> Built as part of a mobile app development internship · Powered by Flutter & Dart
