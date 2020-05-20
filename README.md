# provider_start

A production ready flutter application template for the provider architecture.

## Inspiration

- This project is a starting point for a Flutter application using the provider architecture.
- This project heavily uses the flutter tutorials and snippets of the filled stacks YouTube channel.
- Feel free to send in Pull Requests to improve the application.

Filled Stacks Links:

- [Filled Stacks Website](https://www.filledstacks.com/)
- [Filled Stacks Github Tutorials](https://github.com/FilledStacks/flutter-tutorials)
- [Filled Stacks YouTube](https://www.youtube.com/channel/UC2d0BYlqQCdF9lJfydl_02Q)
- [Filled Stacks Slack](https://filledstacks.slack.com/join/shared_invite/enQtNjY0NTQ3MTYwMzEwLTJjZmU0ODRhOTA5ZGE3MTUxOTUzODdlNzFjMDg0ZGU4ZDQzMzVlMDQ0MzYxZWNhOWViOGI1NjZiZDE1YTQ3NGM)

## Setup

Generate your platform specific folders

```bash
flutter create .
```

Since this project uses 3 locales add this to your info.plist

```plist
<key>CFBundleLocalizations</key>
<array>
    <string>es</string>
    <string>ru</string>
    <string>en</string>
</array>
```

Generate the launcher icon (optional)

```bash
flutter pub get flutter && pub run flutter_launcher_icons:main
```

## Folder structure

```bash
.
├── core
│   ├── constant
│   ├── data_sources
│   ├── enums
│   ├── exceptions
│   ├── localization
│   ├── managers
│   ├── mixins
│   ├── models
│   ├── repositories
│   ├── services
│   ├── utils
│   └── view_models
└── ui
    ├── shared
    ├── views
    └── widgets
```

## Features

### Master branch

- [x] bottom navigation bar
- [x] intuitive UI router
- [x] script for auto formatting on commits
- [x] localization
- [x] validation mixin for forms
- [x] json serialization
- [x] auth service example
- [x] dialog service
- [x] connectivity service
- [x] hardware info service
- [x] http service
- [x] navigation service
- [x] key storage service
- [x] local storage service (NoSQL)
- [x] system light/dark theme support
- [x] platform adaptive widgets
- [x] life cycle manager to start/stop background services
- [x] app settings launcher
- [x] custom fonts
- [x] custom app icons
- [x] custom native splash screen
- [x] snack bar service
- [ ] responsive views
- [ ] unit tests

### Geolocator branch

- [x] location service
- [x] location permission service

## Example pages included

- Home View (Renders a list of posts fetched from JSON place holder API)
- Login View (Form that simulates user login and form validation)
- Main View (View that handles tab navigation)
- Splash View (Initial loading screen that uses flare animations)
- Post Details (Dynamic view that loads the post's user information)
- Settings View (Example view that launches app settings and signs out user)

## Getting started

- run `chmod +x ./format.sh && ./format.sh` to setup git pre commit formatting or
- run `chmod +x ./manual_format.sh` and run `./manual_format.sh` whenever you want to format the dart code
- run `flutter packages pub run build_runner build --delete-conflicting-outputs` if you plan to add/change any serializers once
- run `flutter packages pub run build_runner watch --delete-conflicting-outputs` if you plan to add/change any serializers multiple times

## Adding support for another language

- Find the language local code from here [codes](https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes)
- Inside of `lib/local_setup.dart` add the local code to `supportedLocalCodes`
- Add the local code to the `CFBundleLocalizations` array in `ios/Runner/Info.plist`
- Create a `<local>.json` file under assets/lang/ and fill out every value for your language
- Run `flutter clean` inside you lib apps directory if flutter complains
- There is also a different way to implement locals using the [intl](https://pub.dev/packages/intl) package. An example on how to do so can be found [here](https://github.com/flutter/website/tree/master/examples/internationalization/intl_example)

## Adding app icon

- Change icon `assets/images/logo.png` to another image
- If new icon has a different path update `flutter_icons:` in the `pubspec.yaml` file
- Run `flutter pub get` and then `flutter pub run flutter_launcher_icons:main`

## Adding another model

### Simple model

- Create a `<YOUR_MODEL>.dart` under `core/models/<YOUR_MODEL>/<YOUR_MODEL>.dart`
- Copy the `AlertRequest` from `core/models/alert_request/alert_request.dart` and replace all the class model names with `<YOUR_MODEL>`
- Add your own custom getter values.
- Add a part file. Ex: `<YOUR_MODEL>.g.dart` above the class
- Run `flutter packages pub run build_runner build --delete-conflicting-outputs` to build your new model

### Serializable model

- Create a `<YOUR_MODEL>.dart` under `core/models/<YOUR_MODEL>/<YOUR_MODEL>.dart`
- Copy the `User` from `core/models/user/user.dart` and replace all the class model names with `<YOUR_MODEL>`
- Add your own custom getter values.
- Add `<YOUR_MODEL>` to the list in `@SerializersFor` class constructor found under `core/models/serializer.dart`
- Run `flutter packages pub run build_runner build --delete-conflicting-outputs` to build your new model

### Testing

- Currently Hive does not override the hashcode and == operator for a class. This causes mock tests to fail. To fix this issue simply override the two getters like in the post_h.g.dart file example.
