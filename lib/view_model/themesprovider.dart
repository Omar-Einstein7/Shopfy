// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shopfy/theme/dark_theme_colors.dart';
// import 'package:shopfy/theme/light_theme_colors.dart';
// import 'package:shopfy/theme/util.dart';

// class ThemeProvider with ChangeNotifier {
//    bool isLightTheme;

//   getCurrentStatusNavBarColor() {
//     if (isLightTheme) {
//       SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//         statusBarColor: Colors.transparent,
//         statusBarBrightness: Brightness.light,
//         statusBarIconBrightness: Brightness.dark,
//         systemNavigationBarColor: Colors.white,
//         systemNavigationBarIconBrightness: Brightness.dark,
//       ));
//     } else {
//       SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//         statusBarColor: Colors.transparent,
//         statusBarBrightness: Brightness.dark,
//         statusBarIconBrightness: Brightness.light,
//         systemNavigationBarColor: Colors.black,
//         systemNavigationBarIconBrightness: Brightness.light,
//       ));
//     }
//   }

//   Future<void>toggleThemeData() async {
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     if (isLightTheme) {
//       sharedPreferences.setBool(Spref.isLight, true);
//       isLightTheme = !isLightTheme;
//       getCurrentStatusNavBarColor();
//     themeData();
//       notifyListeners();
//     } else {
//       sharedPreferences.setBool(Spref.isLight, false);
//       isLightTheme = !isLightTheme;
//       getCurrentStatusNavBarColor();
//     themeData();
//       notifyListeners();
//     }
//     getCurrentStatusNavBarColor();
//     notifyListeners();
//   }

//   ThemeProvider({required this.isLightTheme});

//   ThemeData themeData() {
//     return ThemeData(
//         brightness: isLightTheme ? Brightness.light : Brightness.dark,
//         scaffoldBackgroundColor: isLightTheme
//             ? LightThemeColors.backgroundColor
//             : DarkThemeColors.backgroundColor,
//         textTheme: TextTheme(
//             displayLarge: TextStyle(
//                 color: isLightTheme ? Colors.green : Colors.red,
//                 fontSize: 40)));
//   }

//   ThemeMode themeMode() {
//     return ThemeMode(
//       Background: isLightTheme
//           ? LightThemeColors.backgroundColor
//           : DarkThemeColors.backgroundColor,
//       widget: isLightTheme
//           ? LightThemeColors.primaryColor
//           : DarkThemeColors.primaryColor,
//       swithbgcolor: isLightTheme
//           ? LightThemeColors.backgroundColor
//           : DarkThemeColors.backgroundColor,
//       arrow: isLightTheme
//           ? LightThemeColors.accentColor
//           : DarkThemeColors.accentColor,
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopfy/theme/dark_theme_colors.dart';
import 'package:shopfy/theme/light_theme_colors.dart';

class ThemeProvider with ChangeNotifier {
  late bool _isLightTheme;
  late SharedPreferences _prefs;

  ThemeProvider() {
    _isLightTheme = true; // Set default theme
    _loadThemeFromPrefs();
  }

  bool get isLightTheme => _isLightTheme;

  ThemeData themeData() {
    return ThemeData(
        brightness: isLightTheme ? Brightness.light : Brightness.dark,
        scaffoldBackgroundColor: isLightTheme
            ? LightThemeColors.backgroundColor
            : DarkThemeColors.backgroundColor,
        textTheme: TextTheme(
            displayLarge: TextStyle(
                color: isLightTheme ? Colors.green : Colors.red,
                fontSize: 40)));
  }

  void toggleTheme() {
    _isLightTheme = !_isLightTheme;
    _saveThemeToPrefs();
    notifyListeners();
  }

  ThemeMode themeMode() {
    return ThemeMode(
      Background: isLightTheme
          ? LightThemeColors.backgroundColor
          : DarkThemeColors.backgroundColor,
      widget: isLightTheme
          ? LightThemeColors.primaryColor
          : DarkThemeColors.primaryColor,
      swithbgcolor: isLightTheme
          ? LightThemeColors.backgroundColor
          : DarkThemeColors.backgroundColor,
      arrow: isLightTheme
          ? LightThemeColors.accentColor
          : DarkThemeColors.accentColor,
    );
  }

  getCurrentStatusNavBarColor() {
    if (isLightTheme) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ));
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.light,
      ));
    }
  }

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> _loadThemeFromPrefs() async {
    await _initPrefs();
    _isLightTheme = _prefs.getBool('isLightTheme') ?? true;
    notifyListeners();
  }

  Future<void> _saveThemeToPrefs() async {
    await _initPrefs();
    await _prefs.setBool('isLightTheme', _isLightTheme);
  }
}

class ThemePreferences {
  static const String isLightThemeKey = 'isLightTheme';

  static Future<bool> isLightTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isLightThemeKey) ?? true;
  }

  static Future<void> setLightTheme(bool isLight) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(isLightThemeKey, isLight);
  }
}

class ThemeMode {
  List<Color>? gradiantcolor;
  Color? switchcolor;
  Color? Background;
  Color? swithbgcolor;
  Color? arrow;
  Color? widget;
  Color? nav;

  ThemeMode(
      {this.gradiantcolor,
      this.switchcolor,
      this.Background,
      this.swithbgcolor,
      this.arrow,
      this.widget,
      this.nav});
}
