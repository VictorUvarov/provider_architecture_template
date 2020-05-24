import 'package:flutter/widgets.dart';

/// A widget to fade in its child widget when inserted into the widget tree
///
/// Example:
/// {@tool snippet}
/// ```dart
/// FadeIn(
///   child: HomeView(),
/// ),
/// ```
/// {@end-tool}
class FadeIn extends StatefulWidget {
  final Widget child;

  /// How long it takes to fade in
  final Duration duration;

  const FadeIn({
    Key key,
    @required this.child,
    this.duration = const Duration(milliseconds: 500),
  })  : assert(child != null),
        super(key: key);

  @override
  _FadeInState createState() => _FadeInState();
}

class _FadeInState extends State<FadeIn> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _animation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(_controller);
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: widget.child,
    );
  }
}
