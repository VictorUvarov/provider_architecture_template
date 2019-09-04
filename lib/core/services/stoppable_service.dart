import 'package:flutter/material.dart';

/// Abstract class that defines that a stoppable service
///   - Stoppable service must be able to start
///   - Stoppable service must be able to stop
abstract class StoppableService {
  bool _serviceStoped = false;
  bool get serviceStopped => _serviceStoped;

  @mustCallSuper
  void stop() {
    _serviceStoped = true;
  }

  @mustCallSuper
  void start() {
    _serviceStoped = false;
  }
}
