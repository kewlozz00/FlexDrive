# FlexDrive Project Concept

## App idea

FlexDrive is a mobile carsharing app for students and young city users.  
The user can browse available cars, search by model or location, open a car details page, switch between light and dark themes, and read basic app information.

The visual style will be modern and minimalist:

- clean layout
- large cards
- soft colors
- simple icons
- no overloaded screens

## Why this topic fits the assignment

The topic is realistic for a mobile app and gives enough space to show:

- list screen
- details screen
- validated input
- settings screen
- local JSON data
- state management
- navigation
- tests

## Planned screens

### 1. Home screen

Main screen with:

- app bar
- tab bar or bottom navigation
- scrollable list of available cars
- custom list cards with image, name, price, and location
- search field with validation

This screen will satisfy these requirements:

- first screen with menu
- first screen with scrollable list view
- custom widgets for list tiles
- validated input field

### 2. Car details screen

Details of the selected car:

- large image
- model name
- price
- battery or fuel info
- seats
- transmission
- short description
- booking button mockup

This screen will satisfy the details screen requirement.

### 3. Settings screen

Screen for:

- switching between light and dark theme
- saving the theme in shared preferences

This screen will satisfy:

- theme switching
- settings stored locally

### 4. About screen

Simple screen with:

- app description
- student name
- email or contact details

This helps satisfy the requirement for extra screens if needed.

## Data source

For the first version, data will come from a local JSON file in `assets`.

Each car will have:

- id
- brand
- model
- location
- price
- image
- availability
- short description

This is simple and safe for a student project.

## Architecture

We will follow the layered structure required by the assignment:

```text
lib/
  models/
  services/
  providers/
  screens/
  widgets/
```

Planned approach:

- `models` for car and app settings models
- `services` for JSON loading and shared preferences access
- `providers` for Riverpod state management
- `screens` for full pages
- `widgets` for reusable UI blocks

## Technical choices

- Flutter
- Riverpod for state management
- Shared Preferences for theme settings
- local JSON in assets for car data
- named routes for navigation

## Design direction

The app should look modern but still believable as a student project.

We will aim for:

- minimal interface
- calm green or neutral palette
- rounded cards
- clear typography
- simple animations only if needed

## Development strategy

We will build the project in small commits.

Suggested order:

1. project concept
2. clean Flutter project
3. folder structure and routes
4. home screen with sample layout
5. JSON data and model
6. state management for car list
7. details screen
8. settings and theme
9. tests
10. README

