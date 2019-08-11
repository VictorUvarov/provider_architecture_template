import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_start/core/models/user_location.dart';
import 'package:provider_start/core/services/location_service.dart';
import 'package:provider_start/core/services/theme_service.dart';
import 'package:provider_start/locator.dart';

List<SingleChildCloneableWidget> providers = [
  ...independentServices,
  ...dependentServices,
  ...uiConsumableProviders
];

List<SingleChildCloneableWidget> independentServices = [];

List<SingleChildCloneableWidget> dependentServices = [];

List<SingleChildCloneableWidget> uiConsumableProviders = [
  StreamProvider<UserLocation>(
    builder: (context) => locator<LocationService>().locationStream,
  ),
  StreamProvider<ThemeData>(
      builder: (context) => locator<ThemeService>().theme),
];
