import 'package:provider_start/ui/shared/base_viewmodel_extension.dart';

class MainViewModel extends BaseViewModelExt {
  int _index = 0;
  int get index => _index;

  void changeTab(int index) {
    _index = index;
    notifyListeners();
  }
}
