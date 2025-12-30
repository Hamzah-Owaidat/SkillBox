# SkillBox Mobile 📱

A comprehensive Flutter mobile application for the SkillBox digital marketing services platform. This mobile app provides seamless access to all SkillBox features, connecting clients with skilled professionals through an intuitive and modern mobile interface.

> **Note:** This mobile application connects to the [SkillBox Backend API](https://github.com/Hamzah-Owaidat/skillbox) - a PHP-based RESTful API. Make sure the backend server is running and properly configured before using this mobile app.

## 📋 Table of Contents

- [Features](#-features)
- [Screenshots](#-screenshots)
- [Tech Stack](#-tech-stack)
- [Project Structure](#-project-structure)
- [Prerequisites](#-prerequisites)
- [Installation](#-installation)
- [Configuration](#-configuration)
- [Running the App](#-running-the-app)
- [Building for Production](#-building-for-production)
- [API Integration](#-api-integration)
- [Features in Detail](#-features-in-detail)
- [Contributing](#-contributing)
- [License](#-license)

## ✨ Features

### 🔐 Authentication & User Management
- **User Registration** - Create new accounts with email validation
- **Secure Login** - JWT-based authentication with token persistence
- **Password Recovery** - Forgot password flow with email verification codes
- **Profile Management** - Update profile information and change passwords
- **Session Management** - Automatic token refresh and secure storage

### 📄 Portfolio Submission
- **CV/Portfolio Upload** - Submit portfolios with PDF file attachments
- **Portfolio Management** - Edit and update pending portfolio submissions
- **Role-Based Requests** - Apply to become a worker with role selection
- **Service Selection** - Choose relevant services when submitting portfolios
- **Status Tracking** - View portfolio submission status

### 🛍️ Services Discovery
- **Service Browsing** - Browse all available digital marketing services
- **Service Details** - View detailed information about each service
- **Worker Information** - See available workers for each service
- **Service Search** - Find services quickly and efficiently

### 💬 Real-Time Chat
- **Conversation Management** - View and manage all conversations
- **Real-Time Messaging** - Instant message delivery via Pusher WebSockets
- **File Attachments** - Send images, PDFs, and documents in chat
- **Unread Message Tracking** - Badge indicators for unread messages
- **Message History** - Scrollable message history with pagination
- **Read Receipts** - Track message read status

### 🤖 AI Chatbot Assistant
- **Intelligent Recommendations** - AI-powered service and worker suggestions
- **Natural Language Processing** - Chat naturally with the AI assistant
- **Service Matching** - Get personalized service recommendations
- **Worker Suggestions** - Find the best worker for your needs

### 🔔 Real-Time Notifications
- **Push Notifications** - Receive real-time notifications via Pusher
- **Notification Center** - View all notifications in one place
- **Unread Badges** - Visual indicators for unread notifications
- **Notification Management** - Mark as read, delete, or mark all as read
- **Notification Types** - Support for various notification types

### 🎨 Modern UI/UX
- **Material Design 3** - Beautiful, modern Material Design interface
- **Dark Mode Support** - Automatic dark/light theme based on system settings
- **Responsive Layout** - Optimized for various screen sizes
- **Smooth Animations** - Fluid transitions and animations
- **Intuitive Navigation** - Bottom navigation bar with role-based menus

### 👥 Role-Based Access
- **Client Features** - Browse services, chat with workers, submit portfolios
- **Worker Features** - Manage conversations, view profile
- **Dynamic Navigation** - Navigation adapts based on user role
- **Permission Management** - Features shown based on user permissions

## 🛠️ Tech Stack

### Framework & Language
- **Flutter** 3.9.2+ - Cross-platform mobile framework
- **Dart** - Programming language

### State Management
- **Provider** 6.1.5+1 - State management solution

### Networking & API
- **HTTP** 1.5.0 - RESTful API communication
- **Pusher Channels Flutter** 2.2.1 - Real-time WebSocket communication

### Storage & Persistence
- **Shared Preferences** 2.5.3 - Local data storage for tokens and settings
- **Flutter Dotenv** 5.1.0 - Environment variable management

### UI & Design
- **Material Design** - Google's Material Design components
- **Animated Text Kit** 4.2.2 - Text animations
- **Badges** 3.1.2 - Badge indicators for notifications
- **Flutter Toast** 8.2.4 - Toast notifications

### File Handling
- **Image Picker** 1.0.4 - Image selection from gallery/camera
- **File Picker** 8.0.5 - File selection for document uploads

### Utilities
- **URL Launcher** 6.2.5 - Open URLs and external links
- **Intl** 0.18.1 - Internationalization and date formatting

## 📁 Project Structure

```
skillbox-mobile/
├── android/                 # Android platform-specific code
│   ├── app/
│   │   └── src/
│   └── build.gradle.kts
├── ios/                     # iOS platform-specific code
│   ├── Runner/
│   └── Runner.xcodeproj
├── lib/
│   ├── app.dart            # Main app widget with providers
│   ├── main.dart           # Application entry point
│   ├── constants/          # App constants
│   ├── models/             # Data models
│   │   ├── chat.dart
│   │   ├── conversation.dart
│   │   ├── notification.dart
│   │   ├── role.dart
│   │   ├── service.dart
│   │   └── user.dart
│   ├── providers/          # State management providers
│   │   ├── notification_provider.dart
│   │   └── user_provider.dart
│   ├── screens/            # UI screens
│   │   ├── auth/          # Authentication screens
│   │   │   ├── login_screen.dart
│   │   │   ├── register_screen.dart
│   │   │   └── forgot_password_screen.dart
│   │   ├── chat/          # Chat screens
│   │   │   ├── chat_screen.dart
│   │   │   └── conversations_screen.dart
│   │   ├── chatbot/       # AI chatbot screen
│   │   │   └── chatbot_screen.dart
│   │   ├── home/          # Home screen
│   │   │   └── home_screen.dart
│   │   ├── notification/  # Notifications screen
│   │   │   └── notification_screen.dart
│   │   ├── portfolio/     # Portfolio submission
│   │   │   └── portfolio_submit_screen.dart
│   │   ├── profile/       # User profile
│   │   │   └── profile_screen.dart
│   │   └── services/      # Services screens
│   │       ├── services_screen.dart
│   │       └── service_details_screen.dart
│   ├── services/          # Business logic services
│   │   ├── api_service.dart
│   │   ├── chat_service.dart
│   │   ├── chatbot_service.dart
│   │   ├── notification_service.dart
│   │   ├── pusher_service.dart
│   │   └── services_service.dart
│   ├── theme/             # App theming
│   │   ├── app_theme.dart
│   │   ├── colors.dart
│   │   ├── dark_theme.dart
│   │   └── light_theme.dart
│   ├── utils/             # Utility functions
│   └── widgets/           # Reusable widgets
│       ├── launcher.dart
│       ├── scaffold_with_nav.dart
│       └── welcome_text.dart
├── assets/                # App assets
│   ├── fonts/            # Custom fonts
│   ├── images/           # Images and icons
│   │   ├── backgrounds/
│   │   ├── icons/
│   │   └── logos/
│   └── sounds/           # Sound files
├── test/                  # Unit and widget tests
│   └── widget_test.dart
├── .env                   # Environment variables (not in repo)
├── pubspec.yaml          # Flutter dependencies
└── README.md             # This file
```

## 📋 Prerequisites

Before you begin, ensure you have the following installed:

- **Flutter SDK** 3.9.2 or higher ([Install Flutter](https://flutter.dev/docs/get-started/install))
- **Dart SDK** (comes with Flutter)
- **Android Studio** or **VS Code** with Flutter extensions
- **Android SDK** (for Android development)
- **Xcode** (for iOS development, macOS only)
- **Git** for version control
- **Backend API Server** - The [SkillBox Backend](https://github.com/Hamzah-Owaidat/skillbox) must be running and accessible

### Verify Flutter Installation

```bash
flutter doctor
```

Ensure all required components are installed and configured.

## 🚀 Installation

### Step 1: Clone the Repository

```bash
git clone https://github.com/Hamzah-Owaidat/skillbox-mobile.git
cd skillbox-mobile
```

### Step 2: Install Dependencies

```bash
flutter pub get
```

### Step 3: Configure Environment Variables

Create a `.env` file in the root directory:

```env
# API Configuration
API_BASE_URL=http://your-backend-api-url.com/skillbox/public

# Pusher Configuration (for real-time features)
PUSHER_APP_KEY=your-pusher-app-key
PUSHER_CLUSTER=your-pusher-cluster
PUSHER_AUTH_ENDPOINT=http://your-backend-api-url.com/skillbox/public/api/pusher/auth
```

**Important:** 
- Replace `your-backend-api-url.com` with your actual backend server URL
- Get Pusher credentials from your [Pusher Dashboard](https://dashboard.pusher.com/)
- The `.env` file should be added to `.gitignore` (never commit it)

### Step 4: Platform-Specific Setup

#### Android Setup

1. Open `android/app/build.gradle.kts`
2. Update `minSdkVersion` if needed (minimum 21 recommended)
3. Update `applicationId` if needed
4. Ensure internet permission is enabled in `AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.CAMERA" />
```

#### iOS Setup

1. Open `ios/Runner.xcworkspace` in Xcode
2. Update `Bundle Identifier` if needed
3. Ensure permissions are configured in `Info.plist`:
   - `NSPhotoLibraryUsageDescription`
   - `NSCameraUsageDescription`
   - `NSMicrophoneUsageDescription` (if needed)

## ⚙️ Configuration

### API Base URL

The app uses the `API_BASE_URL` from your `.env` file. Make sure it points to your running backend server.

**Development Example:**
```env
API_BASE_URL=http://192.168.1.100/skillbox/public
```

**Production Example:**
```env
API_BASE_URL=https://api.skillbox.com/public
```

### Pusher Configuration

1. Sign up at [Pusher](https://pusher.com/)
2. Create a new Channels app
3. Copy your App Key and Cluster from the dashboard
4. Add them to your `.env` file
5. Configure the backend to use the same Pusher credentials

### Network Security (Android)

For Android 9+ (API 28+), you may need to configure network security if using HTTP (not HTTPS):

Create `android/app/src/main/res/xml/network_security_config.xml`:

```xml
<?xml version="1.0" encoding="utf-8"?>
<network-security-config>
    <domain-config cleartextTrafficPermitted="true">
        <domain includeSubdomains="true">your-backend-domain.com</domain>
    </domain-config>
</network-security-config>
```

Then reference it in `AndroidManifest.xml`:

```xml
<application
    android:networkSecurityConfig="@xml/network_security_config"
    ...>
```

## 🏃 Running the App

### Development Mode

```bash
# Run on connected device/emulator
flutter run

# Run on specific device
flutter devices                    # List available devices
flutter run -d <device-id>         # Run on specific device

# Run in debug mode with hot reload
flutter run --debug
```

### Available Devices

- **Android Emulator** - Start from Android Studio
- **iOS Simulator** - Start from Xcode (macOS only)
- **Physical Device** - Connect via USB and enable USB debugging

### Hot Reload & Hot Restart

- Press `r` in the terminal for hot reload
- Press `R` for hot restart
- Press `q` to quit

## 📦 Building for Production

### Android APK

```bash
# Build debug APK
flutter build apk --debug

# Build release APK
flutter build apk --release

# Build app bundle for Play Store
flutter build appbundle --release
```

### iOS

```bash
# Build for iOS (requires macOS and Xcode)
flutter build ios --release

# Then archive and upload via Xcode
```

### Build Configuration

Update `android/app/build.gradle.kts` for release builds:

```kotlin
android {
    signingConfigs {
        release {
            keyAlias = 'your-key-alias'
            keyPassword = 'your-key-password'
            storeFile = file('path/to/keystore.jks')
            storePassword = 'your-store-password'
        }
    }
    buildTypes {
        release {
            signingConfig = signingConfigs.release
        }
    }
}
```

## 🔌 API Integration

This mobile app connects to the SkillBox Backend API. The backend must be running and accessible.

### API Endpoints Used

#### Authentication
- `POST /api/register` - User registration
- `POST /api/login` - User login (returns JWT token)
- `GET /api/me` - Get current user info
- `PUT /api/profile` - Update user profile
- `POST /api/forgot-password` - Request password reset
- `POST /api/verify-reset-code` - Verify reset code
- `POST /api/reset-password` - Reset password

#### Services
- `GET /api/services` - List all services
- `GET /api/services/{id}` - Get service details

#### Portfolios
- `POST /api/portfolios` - Submit portfolio
- `GET /api/portfolios/{id}` - Get portfolio
- `PUT /api/portfolios/{id}` - Update portfolio

#### Chat
- `GET /api/chat/conversations` - Get conversations
- `POST /api/chat/start` - Start conversation
- `GET /api/chat/messages/{id}` - Get messages
- `POST /api/chat/send` - Send message
- `GET /api/chat/unread-count` - Get unread count

#### Notifications
- `GET /api/notifications` - Get notifications
- `GET /api/notifications/unread-count` - Get unread count
- `POST /api/notifications/{id}/read` - Mark as read
- `POST /api/notifications/mark-all-read` - Mark all as read

#### Chatbot
- `POST /api/chatbot/query` - Query AI chatbot

### Authentication Flow

1. User logs in via `POST /api/login`
2. Backend returns JWT token
3. Token is stored in `SharedPreferences`
4. All subsequent requests include token in `Authorization: Bearer {token}` header
5. Token is automatically included in API service calls

### Real-Time Features

Real-time features use **Pusher Channels**:

- **Chat Messages** - Real-time message delivery
- **Notifications** - Instant notification updates
- **Conversation Updates** - New conversation notifications

The app subscribes to private channels based on user ID:
- `private-user-{userId}` - User-specific notifications and messages

## 📱 Features in Detail

### Authentication System

- Secure JWT token-based authentication
- Automatic token persistence across app restarts
- Token validation and refresh handling
- Secure logout with token cleanup

### Real-Time Chat

- **Pusher Integration** - WebSocket-based real-time messaging
- **Message Types** - Text messages and file attachments
- **Conversation Management** - View all conversations with unread indicators
- **Message History** - Paginated message loading
- **File Support** - Send images, PDFs, and documents

### AI Chatbot

- **Natural Language** - Chat naturally with the AI assistant
- **Service Recommendations** - Get personalized service suggestions
- **Worker Matching** - Find the best worker for your needs
- **Intelligent Responses** - Powered by Hugging Face AI models

### Portfolio Management

- **File Upload** - Upload CV/Portfolio as PDF
- **Form Validation** - Comprehensive input validation
- **Role Selection** - Choose desired role when applying
- **Service Selection** - Select relevant services
- **Edit Capability** - Update pending portfolios

### Notification System

- **Real-Time Updates** - Instant notification delivery
- **Badge Indicators** - Unread count badges
- **Notification Center** - Centralized notification management
- **Mark as Read** - Individual and bulk read operations

## 🧪 Testing

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage
```

## 🐛 Troubleshooting

### Common Issues

#### 1. API Connection Failed
- Verify `API_BASE_URL` in `.env` is correct
- Ensure backend server is running
- Check network connectivity
- Verify CORS settings on backend

#### 2. Pusher Connection Issues
- Verify Pusher credentials in `.env`
- Check backend Pusher configuration
- Ensure proper channel authorization

#### 3. Build Errors
```bash
# Clean build
flutter clean
flutter pub get
flutter run
```

#### 4. Token Issues
- Clear app data and re-login
- Verify token format from backend
- Check token expiration settings

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. **Fork the repository**
2. **Create a feature branch** (`git checkout -b feature/AmazingFeature`)
3. **Commit your changes** (`git commit -m 'Add some AmazingFeature'`)
4. **Push to the branch** (`git push origin feature/AmazingFeature`)
5. **Open a Pull Request**

### Coding Standards

- Follow [Flutter Style Guide](https://flutter.dev/docs/development/ui/widgets-intro)
- Use meaningful variable and function names
- Add comments for complex logic
- Write clear commit messages
- Ensure code is properly formatted (`dart format .`)

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👥 Authors

- **Hamzah Owaidat** - *Initial work* - [Hamzah-Owaidat](https://github.com/Hamzah-Owaidat)

## 🙏 Acknowledgments

- [Flutter Team](https://flutter.dev/) - Amazing cross-platform framework
- [Pusher](https://pusher.com/) - Real-time WebSocket infrastructure
- [Hugging Face](https://huggingface.co/) - AI models for chatbot
- [Material Design](https://material.io/) - Design system
- All contributors and users of SkillBox Mobile

## 🔗 Related Projects

- [SkillBox Backend API](https://github.com/Hamzah-Owaidat/skillbox) - The backend API this mobile app connects to

---

**Made with ❤️ using Flutter**

