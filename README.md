# Flutter Developer Assessment

The project demonstrates various core Flutter concepts, including user authentication, persistent login, localization (English and Spanish), API integration, and local database handling using SQfLite. The architecture follows the MVVM pattern with Clean Architecture, and state management is handled with GetX.

<img src= "https://github.com/user-attachments/assets/65278f92-43ad-4e56-b65c-a15d2998b3ef" height="700"/>



## Overview
This Flutter project implements the following features with a focus on Clean Architecture and the MVVM pattern:

- `User Authentication:` A simple login screen with hardcoded credentials.
- `Persistent Login State:` The app saves the login state using SharedPreferences, ensuring users stay logged in between app sessions.
- `Localization:` Support for English and Spanish languages with persistent language preference.
- `API Integration:` Fetching and displaying data from an API, with filtering options for the doctor’s availability.
- `Local Database:` Storing contacts locally using SQfLite and displaying them on a dedicated Contacts screen.

## Dependencies

This project uses the following Flutter packages:

- `shared_preferences:` For storing login state and language preferences.
- `flutter_localizations:` For built-in Flutter localization support.
- `intl:` For managing and formatting translations.
- `Dio:` For making API calls to fetch data.
- `sqflite:` For SQfLite database integration to store contacts.
- `get:` For state management and navigation using GetX.
- `path_provider:` For accessing the file system to save SQfLite database locally.
- `path:` For working with file paths.
- `gap:` For managing consistent spacing between widgets in the UI.

## Features
- `MVVM Architecture:` The app uses the MVVM (Model-View-ViewModel) pattern, which separates concerns between the UI, business logic, and data.
- `State Management:` GetX is used to manage state and navigation across the app.
- `SharedPreferences:`
- - `Persistent Login:` Login credentials are stored in SharedPreferences so the user remains logged in even after the app restarts.
- - `Persistent Language Preferences:` The selected language (English or Spanish) is saved using SharedPreferences to retain user preferences across app sessions.
- `Localization:` Supports both English and Spanish, storing the language setting and persisting using SharedPreferences.
- `Persistent Login:` The app saves the login state using SharedPreferences, ensuring users are logged in between sessions.
- `API Integration:` The app fetches data from an external API, displays a list, and allows filtering based on doctor availability.
- `Local Database:` Uses SQLite (SQfLite package) to store and display contacts locally.

## Tasks Implemented

### Task 1: User Login
- Description: A login screen with TextField widgets for username and password, along with a Login button.
- Credentials: Hardcoded credentials for testing:
- Username: testuser
- Password: password123
- Navigation: Successful login navigates to the Home screen.
- Error Handling: Invalid credentials display an error message.
  
### Task 2: Persistent Login State
- Description: The app uses SharedPreferences to save the login state so users remain logged in after restarting the app.
- Implementation:
After a successful login, the app stores the user's login state in SharedPreferences.
On app launch, the login state is checked. If the user is logged in, they are redirected to the Home screen.
Redirection: If the user was logged in before, they are automatically redirected to the Home screen when the app is reopened.

### Task 3: Language Change Feature
- Description: A settings screen allows users to toggle between English and Spanish using the intl package and flutter_localizations.
- Persistent Language: The selected language is saved in SharedPreferences so that the preference persists across app sessions.
- UI: A simple toggle or dropdown allows users to select their preferred language.

### Task 4: Fetch and Display Data from API
- Description: The app connects to an API to fetch a list of doctors and displays the data in a ListView.
- Filtering: Users can toggle between viewing all doctors or only those who are available (based on the "availability": "Yes" field).
- Error Handling: Proper error handling is in place in case the API fails or no data is returned.
- Loading State: A loading indicator is displayed while the API is being queried.

### Task 5: Local Database Storage for Contacts
- Description: The app includes a Contacts screen where users can add new contacts, which are then saved into a local SQfLite database.
- Functionality:
- The floating action button opens a dialog to add a new contact’s name and number.
- The contact information is stored in a local SQfLite database.
- The Contacts screen displays the list of saved contacts and refreshes automatically when new contacts are added.

## Usage
- Launch the app.
- On the login screen, use the username testuser and password password123 to log in.
- After login, navigate to the Home screen.
- Use the Settings screen to toggle between English and Spanish.
- Visit the Contacts screen to add, view, and manage contacts stored in the local database.


## Getting Started

### Prerequisites
Before you begin, make sure you have Flutter installed on your system. If you need installation guidance, visit the official Flutter Website.
## Installation 

To launch the CraftyBay Application, follow these steps:

Clone this repository to your computer:
```bash
  git clone https://github.com/kazihabiba201/flutterapptask

```
Navigate to the project folder:
```bash
 cd flutterapptask

```
    
Install dependencies:
```bash
 flutter pub get
```

### Executing the Code

Follow these steps to connect your device or emulator and launch the app using the following command:

```bash
flutter run
```

## Flutter Task Screens

### Login Screen
<img src="https://github.com/user-attachments/assets/6bae94e6-67cc-46bb-b6c5-1d223b8cd840" height="500"/>
<img src="https://github.com/user-attachments/assets/9b917365-fd4b-4e47-930e-cc45896b6e9a" height="500"/>
<img src="https://github.com/user-attachments/assets/d9907c3f-ffcf-4c84-92ba-d446cd027eb1" height="500"/>

### Home Screen
<img src="https://github.com/user-attachments/assets/83cbf6ba-e8c5-488b-8810-d8b0459e19b3" height="500"/>
<img src="https://github.com/user-attachments/assets/90e413de-c7c9-4b1c-b241-96de242f16ab" height="500"/>


### Contact Screen
<img src="https://github.com/user-attachments/assets/721405af-5700-4906-b57c-84f69ac89844" height="500"/>
<img src="https://github.com/user-attachments/assets/b126615b-f758-4bc6-9b15-77f31faf0447" height="500"/>
<img src="https://github.com/user-attachments/assets/a806d7a0-365d-403c-8869-fcccc725027a" height="500"/>


### Setting Screen
<img src="https://github.com/user-attachments/assets/5a5547fa-6db4-4904-ac38-9bfd1f1a0eb0" height="500"/>
<img src="https://github.com/user-attachments/assets/900ac7d4-f7ce-4f7b-96a6-95e5a4d4f160" height="500"/>
<img src="https://github.com/user-attachments/assets/98ec1397-4e24-441b-be84-74d93cd8d41b" height="500"/>




