import 'package:flutter/widgets.dart' show GlobalKey, NavigatorState;
import 'package:provider_start/core/services/navigation/navigation_service.dart';

class NavigationServiceImpl implements NavigationService {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;
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
  bool pop({returnValue}) {
    return navigatorKey.currentState.pop(returnValue);
  }
}
