# FlexDrive

FlexDrive is a Flutter mobile application about carsharing.  
The app was created as a university project for the Mobile Applications course and follows a layered architecture with separate models, services, providers, screens, and widgets.

## Features

- scrollable home screen with a custom car list
- car details screen with key information
- search field with validation
- light and dark theme switch
- saved theme preference with shared preferences
- Riverpod state management for the car list
- loading, error, and empty states

## Technical overview

The app uses local JSON data from `assets/data/cars.json` and displays it through a repository and Riverpod-based state management flow.

Project structure:

```text
lib/
  models/
  providers/
  screens/
  services/
  theme/
  utils/
  widgets/
```

## Main packages used

- `flutter_riverpod`
  Used for state management of the car list and search state.

- `shared_preferences`
  Used to save the selected light or dark theme locally on the device.

## Setup and run

Flutter version used in development:

```text
Flutter 3.41.6
Dart 3.11.4
```

Commands:

```bash
flutter pub get
flutter analyze
flutter test
flutter run
```

## Tests

The repository includes tests in the `test/` folder:

- model serialization tests for `Car`
- validator tests for search input
- repository/settings tests
- provider test for the car list state
- widget test for the details screen

## Screenshot

Add one screenshot of the running app here before final submission.

Suggested path:

```text
docs/screenshots/home.png
```

Example markdown after adding the file:

```md
![FlexDrive Home Screen](docs/screenshots/home.png)
```

## Author

- Name: `Your Name`
- Email: `your.email@example.com`

Replace the placeholder student details before submission.
