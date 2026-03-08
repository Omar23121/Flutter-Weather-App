# Flutter Weather App

A modern Flutter weather application that allows users to search for any city and view real-time weather information. The app fetches live weather data using WeatherAPI and displays temperature, weather conditions, and daily temperature ranges with a dynamic user interface.

## Description

This project demonstrates how to build a mobile weather application using Flutter. Users can search for a city and instantly receive weather information including temperature, weather condition, and daily temperature range.

## Features

- Search weather by city name
- Quick access to major Saudi cities
- Display current temperature
- Show maximum and minimum temperatures
- Display weather condition and icon
- Show last updated time
- Dynamic UI colors based on weather conditions
- Error handling for invalid cities or network issues

## Technologies Used

- Flutter
- Dart
- Dio – HTTP client for API requests
- WeatherAPI – weather data provider

## Weather API

This application uses WeatherAPI to fetch real-time weather data.

API Documentation: [https://www.weatherapi.com/docs/](https://www.weatherapi.com/docs/)

## Project Structure


weather_app/
├── lib/
│ ├── main.dart
│ ├── weather_service.dart
│ └── weather_model.dart
├── test/
│ └── widget_test.dart
├── android/
├── ios/
├── pubspec.yaml
└── README.md


### Key Files

- **main.dart** → Main UI and application logic  
- **weather_service.dart** → Handles API requests and weather API communication  
- **weather_model.dart** → Data model and JSON parsing  
- **widget_test.dart** → Basic Flutter widget test  

## Getting Started

Follow these steps to run the project locally:

1. **Clone the repository**  
   ```bash
  git clone https://github.com/YOUR_USERNAME/flutter-weather-app.git

2. Navigate to the project folder
cd flutter-weather-app

3. Install dependencies
flutter pub get

4. Run the application
flutter run

## Future Improvements

- **Automatic weather detection using device location**

- **Multi-day weather forecast**

- **Display additional data such as humidity and wind speed**

- **Dark mode support**

- **Ability to save favorite cities**

## Author

Omar
