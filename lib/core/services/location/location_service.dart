import 'package:provider_start/core/models/user_location/user_location.dart';
import 'package:provider_start/core/services/stoppable_service.dart';

abstract class LocationService implements StoppableService {
  Stream<UserLocation> get location$;

  /// Fetch the current location | `null` is permission was denied
  Future<UserLocation> getLocation();
}
