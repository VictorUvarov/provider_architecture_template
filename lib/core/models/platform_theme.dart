import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformThemeData {
  ThemeData materialThemeData;
  CupertinoThemeData cupertinoThemeData;

  PlatformThemeData({
    this.materialThemeData,
    this.cupertinoThemeData,
  });
}
