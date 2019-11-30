import 'dart:async';

import 'package:flutter/foundation.dart' show debugPrint;
import 'package:geolocator/geolocator.dart';
import 'package:provider_start/core/models/user_location/user_location.dart';
import 'package:provider_start/core/services/location/location_service.dart';

class LocationServiceImpl implements LocationService {
  final _geolocator = Geolocator();

  final _locationOptions = LocationOptions(
    accuracy: LocationAccuracy.high,
    distanceFilter: 10,
  );

  final _permissionLevel = GeolocationPermission.locationWhenInUse;

  final _locationController = StreamController<UserLocation>();
  Stream<UserLocation> get location$ => _locationController.stream;

  bool _serviceStopped = false;
  bool get serviceStopped => _serviceStopped;

  StreamSubscription<Position> _subscription;

  LocationServiceImpl() {
    _tryToListenToLocationStream();
  }

  @override
  void start() async {
    _serviceStopped = false;

    if (_subscription == null) {
      await _tryToListenToLocationStream();
    } else {
      _subscription.resume();
    }

    debugPrint('Location Service Started ${!serviceStopped}');
  }

  @override
  void stop() {
    _serviceStopped = true;

    if (_subscription != null) {
      _subscription.pause();
    }

    debugPrint('Location Service Stopped $serviceStopped');
  }

  @override
  Future<UserLocation> getLocation() async {
    final position = await _geolocator.getCurrentPosition();
    return UserLocation(
      (loc) => loc
        ..longitude = position.latitude
        ..longitude = position.longitude,
    );
  }

  Future<void> _tryToListenToLocationStream() async {
    final status = await _geolocator.checkGeolocationPermissionStatus();
    debugPrint(status.toString());
    if (status == GeolocationStatus.denied) return;

    _subscription = _geolocator
        .getPositionStream(_locationOptions, _permissionLevel)
        .listen(_updateUserLocation);
  }

  void _updateUserLocation(Position position) {
    if (position == null) return;

    _locationController.add(UserLocation(
      (loc) => loc
        ..latitude = position.latitude
        ..longitude = position.longitude,
    ));
  }
}
