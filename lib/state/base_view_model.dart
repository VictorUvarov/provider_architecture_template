import 'package:flutter/widgets.dart';

class BaseViewModel<T> extends ChangeNotifier {
  T _state;
  T get state => _state;

  bool _disposed = false;

  void setInitialState(T viewState) {
    _state = viewState;
  }

  void setState(T viewState) {
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
