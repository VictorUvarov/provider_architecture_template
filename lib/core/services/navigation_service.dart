import 'package:flutter/material.dart';

/// Service that is responsible for navigating around the app
class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> pushNamed(String routeName, {Object arguments}) {
    return navigatorKey.currentState.pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> popAndPushNamed(String routeName, {Object arguments}) {
    return navigatorKey.currentState.popAndPushNamed(
      routeName,
      arguments: arguments,
    );
  }

  Future<dynamic> pushNamedAndRemoveUntil(
    String routeName, {
    Object arguments,
  }) {
    return navigatorKey.currentState.pushNamedAndRemoveUntil(
      routeName,
      (_) => false,
      arguments: arguments,
    );
  }

  bool pop({returnValue}) {
    return navigatorKey.currentState.pop(returnValue);
  }
}
