# 📝 Flutter To-Do List App

A sleek and efficient **To-Do List app** built with **Flutter** to help users manage tasks seamlessly. Features include task creation, **1-hour prior notifications**, and fast, lightweight storage using **Hive**. The app offers a clean, responsive UI for Android and iOS.

---

## 🚀 Features

- ✅ Create, edit, and delete tasks with ease
- ⏰ Set optional reminders for tasks
- 🔔 Local notifications 1 hour before task deadlines
- 🗃️ Fast, offline task storage using **Hive** (NoSQL database)
- 🧼 Clean, responsive, and minimalist UI

---

## 📸 Screenshots

![WhatsApp Image 2025-07-10 at 22 02 19_fd7a48e4](https://github.com/user-attachments/assets/9ac30539-c3c3-4d98-b631-06eb91859792)
![WhatsApp Image 2025-07-10 at 22 02 18_82b30883](https://github.com/user-attachments/assets/0ffc75d7-8857-46a7-9105-3a6528b40186)
![WhatsApp Image 2025-07-10 at 22 02 18_a1d325fb](https://github.com/user-attachments/assets/f1daf79c-ceab-4719-be42-c68d4da67bc7)
![WhatsApp Image 2025-07-10 at 22 02 17_b40ae907](https://github.com/user-attachments/assets/c133e171-f5df-4a86-93a1-b1e9f1c9f41c)
![WhatsApp Image 2025-07-10 at 22 02 17_746abe08](https://github.com/user-attachments/assets/509dec2d-e01e-4ca7-a1e8-441045f86c91)
![WhatsApp Image 2025-07-10 at 22 02 16_715e9232](https://github.com/user-attachments/assets/237b2e52-579e-4e42-ac90-47eb78e3a811)

---

## 🧑‍💻 Tech Stack

- **Flutter**: Cross-platform UI framework
- **Dart**: Programming language
- **Hive**: Lightweight, NoSQL database for local storage
- **flutter_local_notifications**: For local notifications
- **timezone**: For timezone-aware notification scheduling

---

## 📦 Installation

### Prerequisites

- Flutter SDK (3.22 or later)
- Android Studio, VS Code, or another IDE
- Android/iOS emulator or physical device

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

### 🔐 Hive Setup Notes

- Initialize Hive in `main.dart` with `Hive.initFlutter()`
- Register the `TaskAdapter` using `Hive.registerAdapter(TaskAdapter())`
- Task data is stored in a local `.hive` box (e.g., named "tasks")

### 🔔 Notifications Setup

- Uses `flutter_local_notifications` for local alerts
- **Android**: Notification permissions are handled automatically
- **iOS**: Enable notification permissions and background modes in `Info.plist`
- Test notifications on a physical device for best results

---

## 🗂️ Folder Structure

```
lib/
├── models/         # Task model and Hive adapters
├── screens/        # UI screens (Home, Add/Edit Task)
├── services/       # NotificationService, HiveService
├── widgets/        # Reusable UI components (e.g., TaskCard)
└── main.dart       # App entry point
```

---

## 🛠️ Future Improvements

- Add task categories or tags
- Support recurring tasks
- Implement dark mode
- Integrate Firebase for cloud backup

---

## 📃 License

This project is licensed under the MIT License.

---

## 🙌 Contributing

Contributions are welcome! Fork the repository, make your changes, and submit a pull request. For major updates, please open an issue to discuss your ideas.

---

## 👤 Author

**Prabanjan Raj**\
