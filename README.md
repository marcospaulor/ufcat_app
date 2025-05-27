# UFCAT Services - Mobile Application

UFCAT Services is a Flutter-based mobile application designed to streamline access to services and information from the Universidade Federal de Catalão (UFCAT). Aimed at both the academic and general community, the app provides an intuitive and centralized platform to engage with UFCAT's resources, enhancing communication and accessibility.

---

## 📖 Overview

As mobile applications become integral to modern communication, educational institutions like UFCAT are leveraging technology to improve user experience. The UFCAT Services app addresses the need for a unified, user-friendly platform to access critical university services, announcements, and resources. Built with Flutter for cross-platform compatibility, the app ensures a seamless experience on both iOS and Android devices.

---

## 🎯 Objectives

The primary goal of this project is to create a mobile application that:
- Centralizes UFCAT’s services and information for quick, intuitive access.
- Enhances usability by addressing limitations in existing platforms.
- Fosters community engagement by providing tools for interaction and feedback.
- Supports scalability for future features, such as academic calendar integration.

---

## ✨ Key Features

- **News, Events, and Notices**: Stay updated with the latest from the UFCAT website, including news, upcoming events, and official notices.
- **University Restaurant**: View the daily menu and submit meal evaluations.
- **Library Services**: Access information about library resources, availability, and services.
- **Campus Map**: Navigate the UFCAT campus with an interactive map highlighting buildings, classrooms, and key locations.
- **Calendar**: View important national dates (academic calendar integration in progress).
- **Service Requests**: Submit and track service orders directly within the app.
- **Security Reporting**: Report suspicious activities on campus via a dedicated form.

---

## 🛠 Technologies Used

- **Flutter**: Cross-platform framework for building the iOS and Android app.
- **Dart**: Programming language for Flutter development.
- **Firebase**: Backend for real-time data storage and synchronization (e.g., news, events, and notices).
- **REST APIs**: Integration with UFCAT’s website for fetching dynamic content.
- **Dependencies**:
  - `http` for API requests.
  - `provider` for state management.
  - Other packages listed in `pubspec.yaml`.

---

## 📂 Project Structure

The project follows a modular and maintainable architecture. Below is the structure of the `lib/` directory:

```plaintext
lib/
├── constants/              # API endpoints and app-wide constants (e.g., base URL getter)
├── data/                   # Static data lists (e.g., categories, places, service types)
├── features/               # Feature-specific widgets and screens (e.g., tab navigation)
├── models/                 # Data models for structured data handling
├── providers/              # State management using Provider
├── shared/                 # Reusable widgets, utilities, and search functionality
├── theme/                  # App theming and styling configurations
└── main.dart               # Entry point of the application
```

---

## 🚀 Getting Started

### Prerequisites

Ensure the following are installed:
- **Flutter SDK**: Version 3.0.0 or higher.
- **Dart**: Included with Flutter.
- **IDE**: Visual Studio Code or Android Studio with Flutter plugins.
- **Firebase Account**: For backend integration.
- **Git**: For cloning the repository.

### Installation

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/<your-repo>/ufcat-services.git
   cd ufcat-services
   ```

2. **Install Dependencies**:
   ```bash
   flutter pub get
   ```

3. **Configure Firebase**:
   - Set up a Firebase project and enable Realtime Database.
   - Add your `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) to the respective platform directories.
   - Ensure API endpoints are correctly set in `lib/constants/`.

4. **Run the App**:
   ```bash
   flutter run
   ```

### Deployment

The app can be built for production using:
```bash
flutter build apk  # For Android
flutter build ios  # For iOS
```

---

## 🗂 Data Structure

The app integrates with Firebase Realtime Database to store and retrieve dynamic content (e.g., news, events). Example data format:

```json
{
  "type": "news",
  "title": "UFCAT Announces New Program",
  "link": "https://ufcat.edu.br/noticia/exemplo",
  "date": "DD/MM/YYYY",
  "image_url": "https://ufcat.edu.br/image.jpg",
  "alt_text": "Image description"
}
```

---

## 🤝 Contributing

We welcome contributions from the community! To contribute:
1. Fork the repository.
2. Create a feature branch (`git checkout -b feature/your-feature`).
3. Commit your changes (`git commit -m "Add your feature"`).
4. Push to the branch (`git push origin feature/your-feature`).
5. Open a pull request.

Please report bugs or suggest improvements via GitHub Issues.

---

## ⚠️ Notes

- The app is tailored to UFCAT’s website structure. Changes to the website may require updates to API integrations.
- The academic calendar feature is under development and will be added in future releases.
- Ensure Firebase credentials are securely managed and not committed to the repository.

---

## 📜 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

## 📞 Contact

For questions, feedback, or support, reach out to the development team:

- **Marcos Paulo Rodrigues** ([GitHub](https://github.com/marcospaulor))  
  Email: dev.silva.marcos@gmail.com
- **Marcio Filho** ([GitHub](https://github.com/Marcio-F))

---

## 🏆 Acknowledgments

Thank you to the UFCAT community for inspiring this project and to all contributors who help improve this tool for students, faculty, and staff.
