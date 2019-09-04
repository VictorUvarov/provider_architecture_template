import 'package:provider_start/core/services/stoppable_service.dart';

/// An example service that implements [StoppableService]
class BackgroundFetchService extends StoppableService {
  @override
  void start() {
    super.start();

    // Start listeneing
    print('BackgroundFetchService Started $serviceStopped');
  }

  @override
  void stop() {
    super.stop();

    // stop listening
    print('BackgroundFetchService Stopped $serviceStopped');
  }
}
