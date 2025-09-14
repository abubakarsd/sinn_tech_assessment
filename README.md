# Flutter Practical Assessment

This repository contains a mobile application developed in **Flutter** as a practical assessment for the **SINNTS Tech LTD Flutter Developer** position.

The application demonstrates key skills in mobile development, including UI design, state management, and API integration.

---

## Features

- **User List**: Displays a paginated list of users fetched from a public API.  
- **Pull-to-Refresh**: Allows the user to manually refresh the list.  
- **Lazy Loading**: Fetches new users as the user scrolls down, for efficient data handling.  
- **User Profile View**: Tapping on a user card navigates to a detailed profile screen.  
- **State Handling**: Gracefully handles different states, showing loading indicators, error messages, and a "no data" view.  
- **Search**: Includes a search bar to filter users by their name or email.  
- **Dark Mode**: Supports a toggle for switching between light and dark themes.  

---

## Technical Architecture

The project is built using **Clean Architecture** to ensure a clear separation of concerns, making the code maintainable, scalable, and testable.  
The application is structured into the following layers:

- **Core Layer**
  This layer contains the foundational components and shared utilities of the application. It includes generic services like the API client for handling network requests, constants for managing app-wide strings and URLs, and themes for defining the application's color schemes and styling. This layer is designed to be independent and highly reusable.
- **Data Layer**
Responsible for fetching data from external sources. It implements the abstractions defined in the Domain layer. This layer includes the remote data source that directly interacts with the API, data models that parse the JSON into Dart objects, and the repository implementation that serves as the single source of truth for the Domain layer.
- **Presentation Layer**  
  Manages the user interface and application state using the **BLoC** state management pattern.  
  It contains all the widgets, pages, and BLoC files.  

- **Domain Layer**  
  This layer is framework-independent and contains the core business logic.  
  It defines the entities and use cases.  

- **Data Layer**  
  Responsible for fetching data from external sources.  
  It includes the API service, data models, and the repository implementation.  

---

## Setup and Installation

Follow these steps to get the project up and running on your local machine.

### Prerequisites
- **Flutter SDK**: Ensure you have the Flutter SDK installed on your system.  
- **IDE**: An IDE such as VS Code or Android Studio with the Flutter and Dart plugins.  
- **Git**: Git is required to clone the repository.  

---

### Step 1: Clone the Repository

```bash
git clone https://github.com/abubakarsd/sinn_tech_assessment.git
```
### Step 2: Navigate to the Project Directory
```bash
cd sinn_tech_assessment
```

### Step 3: Install Dependencies
```bash
flutter pub get
```
### Step 4: Run the Application
To run on a connected device or emulator:
```bash
flutter run
