import 'package:provider_start/core/enums/tab_view.dart';
import 'package:provider_start/core/ui_models/base_model.dart';

const HomeID = 0;
const SettingsID = 1;

class TabModel extends BaseModel {
  int _currentTab;
  int get currentTab => _currentTab;

  init(TabView view) {
    switch (view) {
      case TabView.Home:
        _currentTab = HomeID;
        break;
      case TabView.Settings:
        _currentTab = SettingsID;
        break;
      default:
        _currentTab = HomeID;
    }
  }

  void changeTab(int index) {
    _currentTab = index;
    notifyListeners();
  }
}
