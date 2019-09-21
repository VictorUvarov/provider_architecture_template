import 'package:flutter/material.dart';
import 'package:provider_start/core/managers/lifecycle_manager.dart';

class CoreManager extends StatelessWidget {
  final Widget child;

  const CoreManager({Key key, @required this.child})
      : assert(child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return LifeCycleManager(
      child: child,
    );
  }
}
