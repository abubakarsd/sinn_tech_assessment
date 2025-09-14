Flutter Practical Assessment
This repository contains a mobile application developed in Flutter as a practical assessment for the SINNTS Tech LTD Flutter Developer position.

The application demonstrates key skills in mobile development, including UI design, state management, and API integration.

Features
User List: Displays a paginated list of users fetched from a public API.

Pull-to-Refresh: Allows the user to manually refresh the list.

Lazy Loading: Fetches new users as the user scrolls down, for efficient data handling.

User Profile View: Tapping on a user card navigates to a detailed profile screen.

State Handling: Gracefully handles different states, showing loading indicators, error messages, and a "no data" view.

Search: Includes a search bar to filter users by their name or email.

Dark Mode: Supports a toggle for switching between light and dark themes.

Technical Architecture
The project is built using Clean Architecture to ensure a clear separation of concerns, making the code maintainable, scalable, and testable. The application is structured into the following layers:

Presentation Layer: Manages the user interface and application state using the BLoC state management pattern. It contains all the widgets, pages, and the BLoC files.

Domain Layer: This layer is framework-independent and contains the core business logic. It defines the entities and use cases.

Data Layer: Responsible for fetching data from external sources. It includes the API service, data models, and the repository implementation.

Setup and Installation
Follow these steps to get the project up and running on your local machine.

Prerequisites
Flutter SDK: Ensure you have the Flutter SDK installed on your system.

IDE: An IDE such as VS Code or Android Studio with the Flutter and Dart plugins.

Git: Git is required to clone the repository.

Step 1: Clone the Repository
Open your terminal or command prompt and run the following command to clone the project:

git clone [repository_link]

Step 2: Navigate to the Project Directory
Move into the project folder using the cd command:

cd sinn_tech_assessment

Step 3: Install Dependencies
Fetch all the required packages by running the following command:

flutter pub get

Step 4: Run the Application
You can now run the application on an emulator, a physical device, or a web browser.

To run on a connected device or emulator:

flutter run

To run on the web:

flutter run -d web-server

Final Note
This project was developed within the given time constraints, focusing on meeting all the specified requirements while adhering to software development best practices.