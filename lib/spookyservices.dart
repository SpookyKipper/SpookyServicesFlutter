import 'package:flutter/material.dart';
import 'theme/colors.dart';

ColorScheme colorScheme = MaterialTheme.darkScheme();
int colorSetting = 0; // 0 = default, 1 = system
bool isDarkMode = true;

bool setDarkMode(bool darkMode) {
  isDarkMode = darkMode;
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