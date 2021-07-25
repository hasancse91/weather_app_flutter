# Basic Flutter (Android + iOS) App (Dart + Dio) - Weather App

This is a very beginning friendly project of Flutter. A simple weather forecast App using Open Weather Map API.
I have used `StatefulWidget` for state management. For network calls I used the popular Flutter package `Dio`.

<img src="https://raw.githubusercontent.com/hasancse91/weather_app_flutter/master/data/screenshot.jpg" width="250" height="444" />

### Prerequisite
Basic understanding of Dart programming language. Have to familiar with REST API and network calls with HTTP protocol.

### Project Description
We will develop a weather forecast Android Application with Flutter. The UI will be as like as above screenshot. There is a `DropdownButton` with some `City` name. After selection a city, user need to hit the `View Weather` button. Then App will send request to Open Weather web API and show the weather information in the UI.

### Open Weather API
We will use [Open Weather Map API](https://openweathermap.org/api) for collecting weather information. To get the real weather information of a city, you need to sign up and get your own `APP ID`. Otherwise you can test the API with their sample `BASE URL` and sample `APP ID` without creating account.

### Project Setup
Clone the project and open it using Android Studio. Then create a file `config.json` inside `assets` folder. Add `baseUrl` and `appId` JSON field inside the parent JSON object.

<img src="https://raw.githubusercontent.com/hasancse91/weather_app_flutter/master/data/screenshot_1.png" width="672" height="261" />

#### Use Sample API without creating account
Add below lines at your `config.json` file. Then run the project. You'll get dummy or static API response from Open Weather API.
```
{
  "baseUrl": "https://samples.openweathermap.org/data/2.5",
  "appId": "b6907d289e10d714a6e88b30761fae22"
}
```
#### Use Real APP ID after sign up and activation of your APP ID
After Sign up at the website collect your own `APP ID` from their [API Keys page](https://home.openweathermap.org/api_keys). Then add your `APP ID` in `config.json` file like below.
```
{
  "baseUrl": "http://api.openweathermap.org/data/2.5",
  "appId": "<YOUR WON APP ID>"
}
```
The BASE URL and APP ID will be fetched from `main.dart` file and will be stored it in our local configuration file.

**Note:** The free version of Open Weather API allows maximum 60 API calls per minute.
### Run the project
Run `flutter pub get` to sync the packages. Then run the app to your real device or emulator.
### Disclaimer
This is my first project in Flutter. So there are lots of things to improve. It is not guaranteed about the best practices and Flutter convention in this project. Please don't use this project as a reference or as a boilerplate of your other project.
Feel free to create issues for improvement.Thanks.