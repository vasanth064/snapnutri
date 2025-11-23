# SnapNutri - AI Calorie Tracker

AI-powered calorie tracking app for Android using Gemini 1.5 Flash and Material You design.

## Features

### Core Functionality
- **Fire and Forget Workflow**: Capture food photos instantly, app closes, processing happens in background
- **Gemini AI Analysis**: Uses Gemini 1.5 Flash to analyze food images and extract nutritional data
- **Forced Review System**: Users must review and approve AI predictions before they're added to logs
- **Material You Design**: Dynamic colors that adapt to user's wallpaper
- **Local-First Privacy**: All data stored locally using Drift (SQLite)

### Implemented Components

#### ✅ Completed
1. **Project Setup**
   - Flutter 3.38.3 with Dart 3.10.1
   - All dependencies installed (Riverpod, Drift, Gemini AI, WorkManager, etc.)
   - Android configuration with necessary permissions

2. **Database Schema** (lib/core/database/)
   - User profiles table
   - Food entries with full macro/micro nutrients
   - Pending analysis queue for offline support
   - Chat messages for RAG chatbot
   - Daily nutrition summaries for analytics

3. **Gemini AI Service** (lib/services/gemini_service.dart)
   - System prompt forcing JSON-only responses
   - Rate limiting with exponential backoff (2s, 4s, 8s, 16s)
   - Structured output: food name, calories, macros, micros, health tips
   - Confidence scoring

4. **Material You Theme** (lib/core/theme/)
   - Dynamic color support from wallpaper
   - Light and dark mode themes
   - Material 3 components (cards, buttons, navigation)

5. **Core Constants** (lib/core/constants/)
   - RDA (Recommended Dietary Allowances) calculations
   - Deficiency detection thresholds
   - Personalized messages for nutrient deficiencies

6. **Onboarding Flow** (lib/features/onboarding/)
   - Collects age, weight, gender
   - Calculates daily calorie goals

7. **Home Dashboard** (lib/features/dashboard/)
   - Daily calorie ring progress indicator
   - Quick action buttons
   - Pending review notifications
   - Material You card-based layout

8. **Camera Capture Screen** (lib/features/camera/)
   - Instant camera launch with "Fire and Forget" workflow
   - Image compression (1920px max, 85% JPEG quality)
   - Gallery picker integration
   - Background queue integration

9. **Background Processing Service** (lib/services/background_processor.dart)
   - WorkManager integration for resilient background tasks
   - Rate limiting with exponential backoff
   - Automatic daily summary updates
   - Periodic hourly checks for pending items

10. **Review Screen** (lib/features/review/)
    - Slider-based portion control (50%-150%)
    - Live calorie/macro updates
    - Forced review mechanism blocks dashboard until approved
    - Multi-entry review queue

11. **Notification System** (lib/services/notification_service.dart)
    - "Food analyzed. Tap to review" notifications
    - Low confidence warnings
    - Analysis failure alerts
    - Nutrient deficiency notifications

12. **Analytics Dashboard** (lib/features/analytics/)
    - Macro pie chart (protein, carbs, fat)
    - Micronutrient traffic lights (🟢🟡🔴)
    - Weekly deficiency detection
    - Visual nutrient status indicators

13. **RAG-Powered Chatbot** (lib/features/chatbot/)
    - Context-aware AI coach
    - Queries local database for personalized advice
    - Chat history persistence
    - Real-time nutritional guidance

14. **Deficiency Detection Service** (lib/services/deficiency_detector.dart)
    - Weekly analysis vs RDA
    - 3-level severity system (critical, moderate, mild)
    - Personalized recommendations
    - Actionable health tips

## Tech Stack

| Component | Technology |
|-----------|-----------|
| Framework | Flutter 3.38.3 |
| Language | Dart 3.10.1 |
| State Management | Riverpod |
| Local Database | Drift (SQLite) |
| AI Model | Gemini 1.5 Flash |
| Background Tasks | WorkManager |
| UI Design | Material 3 with Dynamic Color |
| Charts | fl_chart |

## Setup Instructions

### 1. Prerequisites
- Flutter 3.38.3 or higher
- Android SDK
- Gemini API key from [Google AI Studio](https://makersuite.google.com/app/apikey)

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Generate Database Code
```bash
dart run build_runner build --delete-conflicting-outputs
```

### 4. Configure Gemini API Key
Edit `lib/services/gemini_service.dart`:
```dart
static const String _apiKey = 'YOUR_ACTUAL_API_KEY_HERE';
```

### 5. Run the App
```bash
flutter run
```

## Key Features

- **Gemini AI**: gemini-1.5-flash model with structured JSON output
- **Rate Limiting**: 15 requests/min with exponential backoff retry
- **Material You**: Adapts to system wallpaper colors (Android 12+)
- **Local-First**: All data stays on device, no cloud sync
- **Offline Support**: Queue system for when network is unavailable

## License

MIT License
