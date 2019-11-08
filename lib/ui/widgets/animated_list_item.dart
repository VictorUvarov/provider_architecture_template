import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider_start/core/ui_models/widgets/animated_list_item_model.dart';
import 'package:provider_start/ui/views/base_view.dart';

class AnimatedListItem extends StatelessWidget {
  final int index;

  const AnimatedListItem({Key key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final targetPlatform = Theme.of(context).platform;
    final color = targetPlatform == TargetPlatform.android
        ? Theme.of(context).primaryColor
        : CupertinoTheme.of(context).primaryColor;

    return BaseView<AnimatedListItemModel>(
      onModelReady: (model) => model.init(color),
      builder: (context, model, child) => GestureDetector(
        onTap: model.updateColor,
        child: AnimatedContainer(
          margin: const EdgeInsets.all(8.0),
          color: model.color,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          height: 100,
          child: Center(
            child: Text('$index'),
          ),
        ),
      ),
    );
  }
}
