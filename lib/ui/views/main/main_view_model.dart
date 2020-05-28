import 'package:provider_start/state/base_view_model.dart';
import 'package:provider_start/ui/views/main/main_view_state.dart';

class MainViewModel extends BaseViewModel<MainViewState> {
  MainViewModel() {
    setInitialState(MainViewState.initial(0));
  }

  void changeTab(int index) {
    setState(MainViewState.initial(index));
  }
}
