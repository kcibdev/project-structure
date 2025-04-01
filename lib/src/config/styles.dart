import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFFFAB32F);
const Color darkerPrimaryColor = Color(0xFF5D7F08);
const Color secondaryColor = Color(0xFF00AFEF);
const Color backgroundColor = Color(0xFFFEFEFE);
const Color errorColor = Color.fromARGB(255, 187, 52, 52);
const Color successColor = Color(0xFF28A75B);
const Color textColor = Color(0xFF080808);
const Color lightTextColor = Color(0xFF888888);
const Color lightSecondaryColor = Color(0xFF9D9D9D);
const Color lightBgColor = Color(0xFFFCFCFF);
const Color lightColor = Color(0xFFF6F6FF);

//Transaction icons background color group
const Color electricityColor = Color(0xFF9D9D9D);
const Color billsColor = Color(0xFF9D9D9D);
const Color transferColor = Color(0xFF9D9D9D);

// Transaction Status color group
const Color pendingColor = Color(0xFFC57F4C);
const Color completedColor = successColor;
const Color failedColor = Color(0xFFC54C4C);

ThemeData theme = ThemeData(
    primaryColor: primaryColor,
    useMaterial3: false,
    scaffoldBackgroundColor: backgroundColor,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: primaryColor,
      onPrimary: darkerPrimaryColor,
      secondary: secondaryColor,
      onSecondary: Color(0xFF262626),
      error: errorColor,
      onError: errorColor,
      surface: backgroundColor,
      onSurface: lightTextColor,
      surfaceContainer: textColor,
      tertiary: textColor,
      onTertiary: lightTextColor,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: backgroundColor,
      foregroundColor: textColor,
    ));

ColorScheme cl(BuildContext context) => Theme.of(context).colorScheme;

FontWeight getWeight(int? weight) {
  switch (weight) {
    case 100:
      return FontWeight.w100;
    case 200:
      return FontWeight.w200;
    case 300:
      return FontWeight.w300;
    case 400:
      return FontWeight.w400;
    case 500:
      return FontWeight.w500;
    case 600:
      return FontWeight.w600;
    case 700:
      return FontWeight.w700;
    case 800:
      return FontWeight.w800;
    case 900:
      return FontWeight.w900;
    case 1000:
      return FontWeight.bold;
    default:
      return FontWeight.w400;
  }
}
