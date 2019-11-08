import 'package:provider_start/core/enums/connectivity_status.dart';
import 'package:provider_start/core/services/stoppable_service.dart';

abstract class ConnectivityService implements StoppableService {
  Stream<ConnectivityStatus> get connectivity$;

  Future<bool> isConnected();
}
