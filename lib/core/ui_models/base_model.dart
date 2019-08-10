import 'package:flutter/widgets.dart';
import 'package:provider_start/core/enums/view_state.dart';

class BaseModel extends ChangeNotifier {
  ViewState _state = ViewState.Idle;

  ViewState get state => _state;

  bool disposed = false;

  void setState(ViewState viewState) {
    _state = viewState;

    // make sure the model hasn't been disposed
    if (disposed) return;

    notifyListeners();
  }

  @override
  void dispose() {
    disposed = true;
    super.dispose();
  }
}
