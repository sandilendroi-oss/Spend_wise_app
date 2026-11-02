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

 * Install dependencies:
   flutter pub get

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

Built as part of a mobile app internship.
