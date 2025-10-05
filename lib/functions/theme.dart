import 'package:flutter/material.dart';
import 'package:spookyservices/spookyservices.dart';

Color processColorLightDark(
  colorLight, colorDark
) {
  if (isDarkMode) {
    return colorDark;
  } else {
    return colorLight;
  }
}

get cLD => processColorLightDark;