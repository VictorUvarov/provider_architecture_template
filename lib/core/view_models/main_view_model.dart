import 'package:provider_start/core/view_models/base_view_model.dart';

class MainViewModel extends BaseViewModel {
  int _index = 0;
  int get index => _index;

  void changeTab(int index) {
    _index = index;
    notifyListeners();
  }
}
