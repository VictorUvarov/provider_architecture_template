import 'package:flutter/widgets.dart' show GlobalKey, NavigatorState;
import 'package:get/get.dart';
import 'package:logging/logging.dart';
import 'package:provider_start/core/services/navigation/navigation_service.dart';

class NavigationServiceImpl implements NavigationService {
  final _log = Logger('NavigationServiceImpl');

  @override
  GlobalKey<NavigatorState> get navigatorKey => Get.key;

  @override
  Future<dynamic> pushNamed(String routeName, {Object arguments}) {
    _log.finest('pushNamed: route:$routeName arguments:$arguments');
    return navigatorKey.currentState.pushNamed(routeName, arguments: arguments);
  }

  @override
  Future<dynamic> pushReplacementNamed(String routeName, {Object arguments}) {
    _log.finest('pushReplacementNamed: route:$routeName arguments:$arguments');
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
    _log.finest('popAllAndPushNamed: route:$routeName arguments:$arguments');
    return navigatorKey.currentState.pushNamedAndRemoveUntil(
      routeName,
      (_) => false,
      arguments: arguments,
    );
  }

  @override
  void pop({returnValue}) {
    _log.finest('pop: returnValue:$returnValue');
    navigatorKey.currentState.pop(returnValue);
  }
}
