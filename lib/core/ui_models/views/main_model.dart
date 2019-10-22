import 'package:provider_start/core/ui_models/base_model.dart';

class MainModel extends BaseModel {
  int _index = 0;
  int get index => _index;

  void changeTab(int index) {
    _index = index;
    notifyListeners();
  }
}
