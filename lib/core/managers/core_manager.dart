import 'package:flutter/material.dart';
import 'package:provider_start/core/managers/lifecycle_manager.dart';

/// A Widget that will wrap all the managers into one widget
///   - to add another manager just wrap the widget
///     or add the new widget as a child of the current widget(s)
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
