import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> nPushNamed(String routeName, {Object arguments}) {
    return navigatorKey.currentState.pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> nPopAndPushNamed(String routeName, {Object arguments}) {
    return navigatorKey.currentState.popAndPushNamed(
      routeName,
      arguments: arguments,
    );
  }

  Future<dynamic> nPushNamedAndRemoveUntil(
    String routeName, {
    Object arguments,
  }) {
    return navigatorKey.currentState.pushNamedAndRemoveUntil(
      routeName,
      (_) => false,
      arguments: arguments,
    );
  }

  bool nPop({returnValue}) {
    return navigatorKey.currentState.pop(returnValue);
  }
}
