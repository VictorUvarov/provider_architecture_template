import 'package:flutter/widgets.dart';

import 'package:provider_start/core/enums/view_state.dart';

class StateResponsive extends StatelessWidget {
  final ViewState state;
  final Widget idleWidget;
  final Widget busyWidget;
  final Widget dataFetchedWidget;
  final Widget noDataAvailableWidget;
  final Widget errorWidget;
  final Widget successWidget;
  final Widget waitingForInputWidget;

  // returns a widget based on the provided ViewState
  const StateResponsive({
    Key key,
    @required this.state,
    @required this.idleWidget,
    this.busyWidget,
    this.errorWidget,
    this.dataFetchedWidget,
    this.noDataAvailableWidget,
    this.successWidget,
    this.waitingForInputWidget,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    switch (state) {
      case ViewState.Idle:
        return idleWidget;
      case ViewState.Busy:
        return busyWidget ?? idleWidget;
      case ViewState.DataFetched:
        return dataFetchedWidget ?? idleWidget;
      case ViewState.NoDataAvailable:
        return noDataAvailableWidget ?? idleWidget;
      case ViewState.Error:
        return errorWidget ?? idleWidget;
      case ViewState.Success:
        return successWidget ?? idleWidget;
      default:
        return idleWidget;
    }
  }
}
