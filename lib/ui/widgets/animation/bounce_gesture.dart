import 'package:flutter/widgets.dart';

class BounceGesture extends StatefulWidget {
  final Widget child;
  final VoidCallback onPressed;
  final Duration duration;

  BounceGesture({
    Key key,
    @required this.child,
    @required this.onPressed,
    this.duration = const Duration(milliseconds: 200),
  })  : assert(child != null),
        super(key: key);

  @override
  _BounceGestureState createState() => _BounceGestureState();
}

class _BounceGestureState extends State<BounceGesture>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
      lowerBound: 0.0,
      upperBound: 0.05,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
    widget.onPressed?.call();
  }

  void _onTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: widget.child,
      builder: (BuildContext context, Widget child) {
        return GestureDetector(
          onTapDown: _onTapDown,
          onTapUp: _onTapUp,
          onTapCancel: _onTapCancel,
          child: Transform.scale(
            scale: 1 - _controller.value,
            child: widget.child,
          ),
        );
      },
    );
  }
}
