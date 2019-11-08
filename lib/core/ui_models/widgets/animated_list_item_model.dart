import 'package:flutter/material.dart';
import 'package:provider_start/core/enums/view_state.dart';
import 'package:provider_start/core/ui_models/base_model.dart';

class AnimatedListItemModel extends BaseModel {
  Color _color;
  Color get color => _color;

  void init(Color color) {
    _color = color;
    setState(ViewState.DataFetched);
  }

  void updateColor() {
    _color = Colors.red;
    setState(ViewState.DataFetched);
  }
}
