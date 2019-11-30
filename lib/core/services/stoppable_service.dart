import 'package:flutter/material.dart';

/// Abstract class that defines that a stoppable service
///   - Stoppable service must be able to start
///   - Stoppable service must be able to stop
abstract class StoppableService {
  bool _serviceStopped = false;
  bool get serviceStopped => _serviceStopped;

  @mustCallSuper
  void stop() {
    _serviceStopped = true;
  }

  @mustCallSuper
  void start() {
    _serviceStopped = false;
  }
}
