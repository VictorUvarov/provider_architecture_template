import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:provider_start/core/enums/connectivity_status.dart';
import 'package:provider_start/core/services/connectivity/connectivity_service.dart';

class ConnectivityServiceImpl implements ConnectivityService {
  final _connectivityResultController = StreamController<ConnectivityStatus>();
  final _connectivity = Connectivity();

  StreamSubscription<ConnectivityResult> _subscription;
  ConnectivityResult _lastResult;
  bool _serviceStoped = false;

  @override
  Stream<ConnectivityStatus> get connectivity$ =>
      _connectivityResultController.stream;

  bool get serviceStopped => _serviceStoped;

  ConnectivityServiceImpl() {
    debugPrint('(TRACE) ConnectivityService started');
    _subscription =
        _connectivity.onConnectivityChanged.listen(_emitConnectivity);
  }

  Future<bool> isConnected() async {
    final result = await _connectivity.checkConnectivity();

    switch (result) {
      case ConnectivityResult.mobile:
      case ConnectivityResult.wifi:
        return true;
      case ConnectivityResult.none:
      default:
        return false;
    }
  }

  @override
  void start() async {
    debugPrint('(TRACE) ConnectivityService resumed');
    _serviceStoped = false;

    await _resumeSignal();
    _subscription.resume();
  }

  @override
  void stop() {
    debugPrint('(TRACE) ConnectivityService paused');
    _serviceStoped = true;

    _subscription.pause(_resumeSignal());
  }

  void _emitConnectivity(ConnectivityResult event) {
    if (event == _lastResult) return;

    debugPrint('(TRACE) Connectivity status changed to $event');
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
