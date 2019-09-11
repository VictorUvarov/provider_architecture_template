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
- [x] script for autoformatting on commits
- [x] localization
- [x] validation mixin
- [x] json serialization
- [x] functional widgets
- [x] http service
- [x] navigation service
- [x] key storage service
- [x] dialog service
- [x] api service
- [x] dynamic theme switcher
- [x] platform adaptive widgets
- [x] life cycle manager
- [x] app settings
- [x] custom fonts
- [ ] local storage service
- [ ] network sensitive ui
- [ ] graphQL api service
- [ ] app icons

### Geolocator branch

- [x] location service
- [x] location permission service

## Starting pages included

- Tab Container
- Home View
- Settings View
- Login View

## Installation

- run `./format.sh` to setup git pre commit formatting
- run `flutter packages pub run build_runner build --delete-conflicting-outputs` if you plan to add/change any serializers once
- run `flutter packages pub run build_runner watch --delete-conflicting-outputs` if you plan to add/change any serializers multiple times
