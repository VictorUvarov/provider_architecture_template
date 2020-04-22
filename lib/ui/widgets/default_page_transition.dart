import 'package:flutter/widgets.dart';

class DefaultPageTransition extends PageRouteBuilder {
  final Widget child;

  DefaultPageTransition({@required this.child})
      : super(pageBuilder: (context, animation, animation2) {
          return child;
        });
}
