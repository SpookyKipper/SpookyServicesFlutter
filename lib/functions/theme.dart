import 'package:flutter/material.dart';
import 'package:spookyservices/spookyservices.dart';

Color processColorLightDark(
  colorLight, colorDark
) {
  if (isDarkMode) {
    return colorLight;
  } else {
    return colorDark;
  }
}

get cLD => processColorLightDark;