import 'package:flutter/material.dart';

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
