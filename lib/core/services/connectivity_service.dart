import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:provider_start/core/enums/connectivity_status.dart';
import 'package:provider_start/core/services/stoppable_service.dart';

class ConnectivityService extends StoppableService {
  final _connectivityResultController =
      StreamController<ConnectivityStatus>.broadcast();
  final _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _subscription;

  ConnectivityResult _lastResult;

  Stream<ConnectivityStatus> get stream => _connectivityResultController.stream;

  ConnectivityService() {
    print('(TRACE) ConnectivityService started');
    _subscription =
        _connectivity.onConnectivityChanged.listen(_emitConnectivity);
  }

  @override
  void start() async {
    print('(TRACE) ConnectivityService resumed');
    super.start();
    await _resumeSignal();
    _subscription.resume();
  }

  @override
  void stop() {
    print('(TRACE) ConnectivityService paused');
    super.stop();
    _subscription.pause(_resumeSignal());
  }

  void _emitConnectivity(ConnectivityResult event) {
    if (event == _lastResult) return;

    print('(TRACE) Connectivity status changed to $event');
    _connectivityResultController.add(_convertResult(event));
    _lastResult = event;
  }

  ConnectivityStatus _convertResult(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.mobile:
        return ConnectivityStatus.Cellular;
      case ConnectivityResult.wifi:
        return ConnectivityStatus.WiFi;
      case ConnectivityResult.none:
        return ConnectivityStatus.Offline;
      default:
        return ConnectivityStatus.Offline;
    }
  }

  Future<void> _resumeSignal() async => true;
}
