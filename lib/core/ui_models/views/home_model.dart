import 'package:provider_start/core/enums/view_state.dart';
import 'package:provider_start/core/ui_models/base_model.dart';

class HomeModel extends BaseModel {
  Future<void> init() async {
    setState(ViewState.Busy);

    setState(ViewState.Idle);
  }
}
