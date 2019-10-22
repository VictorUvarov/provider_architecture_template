import 'package:provider_start/core/enums/view_state.dart';
import 'package:provider_start/core/ui_models/base_model.dart';

class MainModel extends BaseModel {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  void changeTab(index) {
    setState(ViewState.Busy);
    _currentIndex = index;
    setState(ViewState.Idle);
  }
}
