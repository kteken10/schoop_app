# 📱 Media Blur Mobile App (Demo Version)

## 🔍 Overview
**Media Blur** is a proof-of-concept mobile application demonstrating a privacy-oriented screen blur feature. This demo version showcases the main functionalities and design concept of the app, providing a practical glimpse into how the final product could operate.

---

## 🎯 Objective of the Demo
To provide an operational demonstration of the core functionalities of the **Media Blur Application**, including:
- Real-time blur effect
- Minimalist user interface
- Toggle switch integration for service activation
- Basic permission handling
- Preview of admin access interface

---

## 🚀 Key Features

### 1. Basic UI/UX Interface
- 🏠 Simple home screen with branding
- 🔘 Toggle switch to enable/disable blur effect
- 👤 Placeholder login/subscription screen (mock interface only)

### 2. Real-Time Blur Feature (Core Demo)
- 🖼️ Blur effect applied on screen overlays or selected apps
- 🔄 Basic live testing: Blur is visible when images/videos are viewed (outside Gallery)
- 🔧 Blur intensity fixed or limited to 1-2 levels

### 3. Notification Bar Toggle
- 📲 Persistent notification with interactive toggle
- 📴 Click to activate/deactivate the blur service
- 📡 Status text updates dynamically to indicate whether the blur is ON or OFF

### 4. Permission Handling
- 🔐 Automatic prompts for Android permissions:
  - Accessibility permission
  - Overlay permission

### 5. Basic Admin Access (Optional Preview)
- 🔑 Admin login interface (non-functional in demo)
- 📊 Mock UI with:
  - User count placeholder
  - Subscription toggle preview

### 6. Logs and Monitoring (Internal Testing)
- 🧪 Console logs include:
  - Blur application events
  - User interactions
  - Toggle activity

---

## 🛠️ Tech Stack
- Flutter (cross-platform framework)
- Dart (programming language)
- Android SDK (native permissions & overlays)

---

## 📁 Project Structure (Demo)
```
lib/
├── models/               # Data models
├── providers/            # State management
├── screens/              # UI Screens (Login, Home, Admin)
├── services/             # Logic and services (blur service, permissions)
└── constants/            # App colors and styles
```

---

## 📌 Disclaimer
This version is a **demo** and does not reflect the final, production-level security or features. It is built to validate the feasibility of real-time blur application and user interaction flow.

---

## 🧑‍💻 Author
Dissang Kevin – Keyce Informatique, Douala, Cameroon