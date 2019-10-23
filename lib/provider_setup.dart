import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_start/core/enums/connectivity_status.dart';
import 'package:provider_start/core/services/connectivity/connectivity_service.dart';
import 'package:provider_start/locator.dart';

/// List of providers that provider transforms into a widget tree
/// with the main app as the child of that tree, so that the entire
/// app can use these streams anywhere there is a [BuildContext]
List<SingleChildCloneableWidget> providers = [
  ...independentServices,
  ...dependentServices,
  ...uiConsumableProviders
];

List<SingleChildCloneableWidget> independentServices = [];

List<SingleChildCloneableWidget> dependentServices = [];

List<SingleChildCloneableWidget> uiConsumableProviders = [
  StreamProvider<ConnectivityStatus>(
    builder: (context) => locator<ConnectivityService>().connectivity$,
  ),
];
