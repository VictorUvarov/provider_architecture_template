import 'package:flutter/widgets.dart';
import 'package:provider_start/core/enums/view_state.dart';

/// Class for view models to extend from. Keeps track
/// of [ViewState] and exposes a function to change the
/// state of the view.
class BaseViewModel extends ChangeNotifier {
  ViewState _state = ViewState.Idle;
  ViewState get state => _state;

  bool _disposed = false;

  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

  @override
  void notifyListeners() {
    if (_disposed) return;
    super.notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
