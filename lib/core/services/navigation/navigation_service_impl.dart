import 'package:flutter/widgets.dart' show GlobalKey, NavigatorState;
import 'package:get/get.dart';

import 'navigation_service.dart';

class NavigationServiceImpl implements NavigationService {
  @override
  GlobalKey<NavigatorState> get navigatorKey => Get.key;

  @override
  Future<dynamic> pushNamed(String routeName, {Object arguments}) {
    return navigatorKey.currentState.pushNamed(routeName, arguments: arguments);
  }

  @override
  Future<dynamic> pushReplacementNamed(String routeName, {Object arguments}) {
    return navigatorKey.currentState.pushReplacementNamed(
      routeName,
      arguments: arguments,
    );
  }

  @override
  Future<dynamic> popAllAndPushNamed(
    String routeName, {
    Object arguments,
  }) {
    return navigatorKey.currentState.pushNamedAndRemoveUntil(
      routeName,
      (_) => false,
      arguments: arguments,
    );
  }

  @override
  void pop({returnValue}) {
    navigatorKey.currentState.pop(returnValue);
  }
}
