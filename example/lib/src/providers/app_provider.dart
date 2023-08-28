import 'package:flutter/material.dart';

class AppProvider with ChangeNotifier {
  static final AppProvider _instance = AppProvider._constructor();

  factory AppProvider() {
    return _instance;
  }

  AppProvider._constructor();

  init() async {}
}
