import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      final brightness = SchedulerBinding.instance!.window.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    primaryColor: Color(0xff23272A),
    colorScheme: ColorScheme.dark(),
    iconTheme: IconThemeData(color: Colors.white),
    accentColor: Color(0xff444756),
    accentTextTheme: TextTheme(headline1: TextStyle(color: Color(0xffFFFFFF)), headline2: TextStyle(color: Colors.white70)),
    canvasColor: Colors.white,
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.white,
    colorScheme: ColorScheme.light(),
    iconTheme: IconThemeData(color: Colors.white),
    accentColor: Colors.grey[200],
    canvasColor: Colors.black,
    accentTextTheme: TextTheme(headline1: TextStyle(color: Colors.black), headline2: TextStyle(color: Colors.black87)),
  );
}
