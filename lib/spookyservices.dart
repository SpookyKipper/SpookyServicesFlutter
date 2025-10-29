import 'package:flutter/material.dart';
import 'package:spookyservices/helpers/shared_pref.dart';
import 'theme/colors.dart';

ColorScheme colorScheme = MaterialTheme.darkScheme();
int colorSetting = 0; // 0 = default, 1 = system
bool isDarkMode = true;

bool setDarkMode(bool darkMode) {
  isDarkMode = darkMode;
  if (colorSetting == 0) {
    colorScheme = (isDarkMode)
        ? MaterialTheme.darkScheme()
        : MaterialTheme.lightScheme();
  }
  return true;
}

bool setColorScheme(ColorScheme scheme) {
  colorScheme = scheme;
  return true;
}

bool setColorSetting(int setting) {
  colorSetting = setting;
  return true;
}

ColorScheme getColorScheme() {
  return colorScheme;
}

void initSharedPreferencesSpookySrv() async {
  SharedPreferencesFunctions.init();
}