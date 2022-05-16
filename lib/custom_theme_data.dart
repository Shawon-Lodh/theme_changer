/*
    Created by Shawon Lodh on 16 May 2022
*/

import 'package:flutter/material.dart';

class CustomThemeData with ChangeNotifier {
  ThemeData? _themeData;

  CustomThemeData(this._themeData);

  getThemeData() => _themeData;

  setThemeData(ThemeData themeData) async {
    _themeData = themeData;
    notifyListeners();
  }
}