# 📝 Flutter To-Do List App

A sleek and intuitive **To-Do List app** built with **Flutter** to help users efficiently manage daily tasks. The app features task creation, reminders with **1-hour prior notifications**, and a clean, user-friendly interface.

---

## 🚀 Features

- ✅ Create, update, and delete tasks effortlessly
- ⏰ Set reminders for tasks with customizable deadlines
- 🔔 Receive local notifications 1 hour before task due time
- 📅 Intuitive date and time picker for scheduling
- 🧼 Minimalist and responsive UI with Flutter widgets
- 💾 Persistent local storage using `SharedPreferences` or `sqflite`

---

## 📸 Screenshots

*(Add your screenshots here, e.g., Home Screen, Task Creation, Notification Preview)*

---

## 🧑‍💻 Tech Stack

- **Flutter**: Cross-platform UI framework
- **Dart**: Programming language
- **flutter_local_notifications**: For task reminder notifications
- **provider**: For efficient state management *(if used)*
- **shared_preferences** or **sqflite**: For local data persistence

---

## 📦 Installation

### Prerequisites
- Flutter SDK (latest version)
- IDE: VS Code, Android Studio, or similar
- Android/iOS device or emulator for testing

### Steps to Run
1. Clone the repository:
   ```bash
   git clone https://github.com/Prabanjanraj/flutter-todo-list.git
   cd flutter-todo-list
   ```
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Run the app:
   ```bash
   flutter run
   ```

### 🔔 Notification Setup
- Uses `flutter_local_notifications` for task reminders
- Ensure notification permissions are enabled for Android and iOS
- Test notifications on a physical device for best results

---

## 🗂️ Folder Structure
```
lib/
├── models/         # Task data models
├── screens/        # UI screens (Home, Add Task, etc.)
├── services/       # Notification and storage services
├── widgets/        # Reusable UI components
└── main.dart       # App entry point
```

---

## 📃 License
This project is licensed under the [MIT License](LICENSE).

---

## 🙌 Contributing
Contributions are welcome! For major changes, please open an issue to discuss your ideas. Submit pull requests for bug fixes or enhancements.

---

## 👤 Author
**Prabanjan Raj**  
Connect with me on [LinkedIn](https://www.linkedin.com/in/your-profile) | [GitHub](https://github.com/Prabanjanraj)
