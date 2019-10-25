# provider_start

A Flutter Skeleton application for the provider architecture.

## Inspiration

- This project is a starting point for a Flutter application using the provider architecture.
- This project heavily uses the flutter tutorials and snippets of the filled stacks youtube channel.
- Feel free to send in Pull Requests to improve the application.

Filled Stacks Links:

- [Filled Stacks Website](https://www.filledstacks.com/)
- [Filled Stacks Github Tutorials](https://github.com/FilledStacks/flutter-tutorials)
- [Filled Stacks Youtube](https://www.youtube.com/channel/UC2d0BYlqQCdF9lJfydl_02Q)
- [Filled Stacks Slack](https://filledstacks.slack.com/join/shared_invite/enQtNjY0NTQ3MTYwMzEwLTJjZmU0ODRhOTA5ZGE3MTUxOTUzODdlNzFjMDg0ZGU4ZDQzMzVlMDQ0MzYxZWNhOWViOGI1NjZiZDE1YTQ3NGM)

## Features

### Master branch

- [x] custom routing
- [x] script for auto formatting on commits
- [x] localization
- [x] validation mixin
- [x] json serialization
- [x] functional widgets
- [x] http service
- [x] navigation service
- [x] key storage service
- [x] dialog service
- [x] api service
- [x] connectivity service
- [x] system light/dark theme support
- [x] platform adaptive widgets
- [x] life cycle manager
- [x] app settings
- [x] custom fonts
- [x] app icons
- [x] local storage service (NoSQL)
- [ ] graphQL api service
- [ ] responsive views
- [ ] continuous scrolling
- [ ] unit tests

### Geolocator branch

- [x] location service
- [x] location permission service

## Example pages included

- Login View
- Splash View
- Post Details
- Home View
- Settings View

## Installation

- run `./format.sh` to setup git pre commit formatting
- run `flutter packages pub run build_runner build --delete-conflicting-outputs` if you plan to add/change any serializers once
- run `flutter packages pub run build_runner watch --delete-conflicting-outputs` if you plan to add/change any serializers multiple times

## Adding support for another language

- Find the language local code for here [codes](https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes)
- Inside of `lib/local_setup.dart` add the local code to `supportedLocales` and `supportedLocalCodes`
- Create a `<local>.json` file under assets/lang/ and fill out every value for your language
- Run `flutter clean` inside you lib apps directory if flutter complains
- There is also a different way to implement locals using the [intl](https://pub.dev/packages/intl) package. An example on how to do so can be found [here](https://github.com/flutter/website/tree/master/examples/internationalization/intl_example)

## Adding app icon

- Change icon `assets/images/logo.png` another image
- If new icon has a different path update `flutter_icons:` in the `pubspec.yaml` file
- Run flutter `flutter pub get` and then `flutter pub run flutter_launcher_icons:main`
