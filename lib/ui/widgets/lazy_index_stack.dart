import 'package:flutter/widgets.dart';

/// An indexed stack that lazily loads its children.
/// Used in the MainView to avoid loading the other views
/// that the user has not clicked on.
class LazyIndexedStack extends StatefulWidget {
  final AlignmentGeometry alignment;
  final TextDirection textDirection;
  final StackFit sizing;

  /// Current index of the stack
  final int index;

  /// number of views
  final int itemCount;

  /// Builder for the current index
  final IndexedWidgetBuilder itemBuilder;

  /// Reuse the created view
  final bool reuse;

  LazyIndexedStack({
    Key key,
    this.alignment = AlignmentDirectional.topStart,
    this.textDirection,
    this.sizing = StackFit.loose,
    this.index,
    this.reuse = true,
    @required this.itemBuilder,
    this.itemCount = 0,
  }) : super(key: key);

  @override
  _LazyIndexedStackState createState() => _LazyIndexedStackState();
}

class _LazyIndexedStackState extends State<LazyIndexedStack> {
  List<Widget> _children;
  List<bool> _loaded;

  @override
  void initState() {
    _loaded = [];
    _children = [];
    for (var i = 0; i < widget.itemCount; ++i) {
      if (i == widget.index) {
        _children.add(widget.itemBuilder(context, i));
        _loaded.add(true);
      } else {
        _children.add(Container());
        _loaded.add(false);
      }
    }
    super.initState();
  }

  @override
  void didUpdateWidget(LazyIndexedStack oldWidget) {
    for (var i = 0; i < widget.itemCount; ++i) {
      if (i == widget.index) {
        if (!_loaded[i]) {
          _children[i] = widget.itemBuilder(context, i);
          _loaded[i] = true;
        } else {
          if (widget.reuse) {
            return;
          }
          _children[i] = widget.itemBuilder(context, i);
        }
      }
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: widget.index,
      alignment: widget.alignment,
      textDirection: widget.textDirection,
      sizing: widget.sizing,
      children: _children,
    );
  }
}
