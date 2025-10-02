import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff564bc1),
      surfaceTint: Color(0xff584dc3),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff6f65dc),
      onPrimaryContainer: Color(0xfffffdff),
      secondary: Color(0xff5d5988),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffcec9ff),
      onSecondaryContainer: Color(0xff565381),
      tertiary: Color(0xff973489),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffb44ea4),
      onTertiaryContainer: Color(0xfffffdff),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfffcf8ff),
      onSurface: Color(0xff1c1b22),
      onSurfaceVariant: Color(0xff474553),
      outline: Color(0xff787584),
      outlineVariant: Color(0xffc8c4d5),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff312f37),
      inversePrimary: Color(0xffc5c0ff),
      primaryFixed: Color(0xffe4dfff),
      onPrimaryFixed: Color(0xff140067),
      primaryFixedDim: Color(0xffc5c0ff),
      onPrimaryFixedVariant: Color(0xff3f32aa),
      secondaryFixed: Color(0xffe4dfff),
      onSecondaryFixed: Color(0xff191540),
      secondaryFixedDim: Color(0xffc6c1f6),
      onSecondaryFixedVariant: Color(0xff45426e),
      tertiaryFixed: Color(0xffffd7f2),
      onTertiaryFixed: Color(0xff390034),
      tertiaryFixedDim: Color(0xffffaceb),
      onTertiaryFixedVariant: Color(0xff7c1a71),
      surfaceDim: Color(0xffdcd8e3),
      surfaceBright: Color(0xfffcf8ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff6f2fd),
      surfaceContainer: Color(0xfff0ecf7),
      surfaceContainerHigh: Color(0xffebe6f1),
      surfaceContainerHighest: Color(0xffe5e1eb),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff2e1c99),
      surfaceTint: Color(0xff584dc3),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff675cd3),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff34315c),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff6c6897),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff67005f),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffaa469b),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcf2c27),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffcf8ff),
      onSurface: Color(0xff111017),
      onSurfaceVariant: Color(0xff363542),
      outline: Color(0xff53515f),
      outlineVariant: Color(0xff6e6b7a),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff312f37),
      inversePrimary: Color(0xffc5c0ff),
      primaryFixed: Color(0xff675cd3),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff4e42b9),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff6c6897),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff53507d),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xffaa469b),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff8d2b81),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffc8c5cf),
      surfaceBright: Color(0xfffcf8ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff6f2fd),
      surfaceContainer: Color(0xffebe6f1),
      surfaceContainerHigh: Color(0xffdfdbe6),
      surfaceContainerHighest: Color(0xffd4d0da),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff230790),
      surfaceTint: Color(0xff584dc3),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff4235ac),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff2a2752),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff474471),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff56004f),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff7f1e74),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff600004),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff98000a),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffcf8ff),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff2c2b38),
      outlineVariant: Color(0xff494855),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff312f37),
      inversePrimary: Color(0xffc5c0ff),
      primaryFixed: Color(0xff4235ac),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff2a1696),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff474471),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff312d59),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff7f1e74),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff610059),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffbbb7c1),
      surfaceBright: Color(0xfffcf8ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff3effa),
      surfaceContainer: Color(0xffe5e1eb),
      surfaceContainerHigh: Color(0xffd7d3dd),
      surfaceContainerHighest: Color(0xffc8c5cf),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffc5c0ff),
      surfaceTint: Color(0xffc5c0ff),
      onPrimary: Color(0xfa6f65dc),
      primaryContainer: Color(0xff1b1b1b),
      onPrimaryContainer: Color(0xfffffdff),
      secondary: Color(0xffc6c1f6),
      onSecondary: Color(0xff2e2b56),
      secondaryContainer: Color(0xff474471),
      onSecondaryContainer: Color(0xffb8b3e7),
      tertiary: Color(0xffffaceb),
      onTertiary: Color(0xff5d0056),
      tertiaryContainer: Color(0xffb44ea4),
      onTertiaryContainer: Color(0xfffffdff),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff100f10),
      onSurface: Color(0xffe5e1eb),
      onSurfaceVariant: Color(0xffc8c4d5),
      outline: Color(0xff928f9f),
      outlineVariant: Color(0xff474553),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe5e1eb),
      inversePrimary: Color(0xff584dc3),
      primaryFixed: Color(0xffe4dfff),
      onPrimaryFixed: Color(0xff140067),
      primaryFixedDim: Color(0xffc5c0ff),
      onPrimaryFixedVariant: Color(0xff3f32aa),
      secondaryFixed: Color(0xffe4dfff),
      onSecondaryFixed: Color(0xff191540),
      secondaryFixedDim: Color(0xffc6c1f6),
      onSecondaryFixedVariant: Color(0xff45426e),
      tertiaryFixed: Color(0xffffd7f2),
      onTertiaryFixed: Color(0xff390034),
      tertiaryFixedDim: Color(0xffffaceb),
      onTertiaryFixedVariant: Color(0xff7c1a71),
      surfaceDim: Color(0xff13131a),
      surfaceBright: Color(0xff3a3840),
      surfaceContainerLowest: Color(0xff0e0d14),
      surfaceContainerLow: Color(0xff1c1b22),
      surfaceContainer: Color(0xff201f26),
      surfaceContainerHigh: Color(0xff2a2931),
      surfaceContainerHighest: Color(0xff35343c),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffddd8ff),
      surfaceTint: Color(0xffc5c0ff),
      onPrimary: Color(0xff1d0083),
      primaryContainer: Color(0xff1b1b1b),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffddd8ff),
      onSecondary: Color(0xff23204b),
      secondaryContainer: Color(0xff908bbd),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffffcef0),
      onTertiary: Color(0xff4b0044),
      tertiaryContainer: Color(0xffd46ac2),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff13131a),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffdedaeb),
      outline: Color(0xffb3b0c0),
      outlineVariant: Color(0xff918e9e),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe5e1eb),
      inversePrimary: Color(0xff4033ab),
      primaryFixed: Color(0xffe4dfff),
      onPrimaryFixed: Color(0xff0c0049),
      primaryFixedDim: Color(0xffc5c0ff),
      onPrimaryFixedVariant: Color(0xff2e1c99),
      secondaryFixed: Color(0xffe4dfff),
      onSecondaryFixed: Color(0xff0e0a35),
      secondaryFixedDim: Color(0xffc6c1f6),
      onSecondaryFixedVariant: Color(0xff34315c),
      tertiaryFixed: Color(0xffffd7f2),
      onTertiaryFixed: Color(0xff270024),
      tertiaryFixedDim: Color(0xffffaceb),
      onTertiaryFixedVariant: Color(0xff67005f),
      surfaceDim: Color(0xff13131a),
      surfaceBright: Color(0xff45434c),
      surfaceContainerLowest: Color(0xff07070d),
      surfaceContainerLow: Color(0xff1e1d24),
      surfaceContainer: Color(0xff28272f),
      surfaceContainerHigh: Color(0xff33323a),
      surfaceContainerHighest: Color(0xff3e3d45),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xfff2eeff),
      surfaceTint: Color(0xffc5c0ff),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffc1bbff),
      onPrimaryContainer: Color(0xff070039),
      secondary: Color(0xfff2eeff),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffc2bdf2),
      onSecondaryContainer: Color(0xff080330),
      tertiary: Color(0xffffeaf6),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffffa5eb),
      onTertiaryContainer: Color(0xff1d001a),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff13131a),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xfff2eeff),
      outlineVariant: Color(0xffc4c0d1),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe5e1eb),
      inversePrimary: Color(0xff4033ab),
      primaryFixed: Color(0xffe4dfff),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffc5c0ff),
      onPrimaryFixedVariant: Color(0xff0c0049),
      secondaryFixed: Color(0xffe4dfff),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffc6c1f6),
      onSecondaryFixedVariant: Color(0xff0e0a35),
      tertiaryFixed: Color(0xffffd7f2),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffffaceb),
      onTertiaryFixedVariant: Color(0xff270024),
      surfaceDim: Color(0xff13131a),
      surfaceBright: Color(0xff514f58),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff201f26),
      surfaceContainer: Color(0xff312f37),
      surfaceContainerHigh: Color(0xff3c3a43),
      surfaceContainerHighest: Color(0xff47464e),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.background,
     canvasColor: colorScheme.surface,
  );


  List<ExtendedColor> get extendedColors => [
  ];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
