import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../config/palette.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      final brightness = SchedulerBinding.instance.window.platformBrightness;
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
  static final darkTheme = ThemeData.dark().copyWith(
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: Palette.white),
      textTheme: TextTheme(
        headline6: TextStyle(
          color: Palette.white,
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
        ),
      ),
      centerTitle: false,
      elevation: 16.0,
      color: Palette.primary,
    ),
    tabBarTheme: TabBarTheme(
      labelColor: Palette.white,
      unselectedLabelColor: Palette.lightGrey,
      labelPadding: EdgeInsets.only(top: 4),
      indicatorSize: TabBarIndicatorSize.tab,
    ),
    scaffoldBackgroundColor: Palette.darkMode.withOpacity(.6),
    iconTheme: IconThemeData(
      color: Palette.primary,
      opacity: 0.8,
    ),
    colorScheme: ColorScheme.dark().copyWith(
      // primary: Palette.lose,
      // secondary: Palette.secondary,
      // error: Palette.lose,
    ),
    cardTheme: CardTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
      elevation: 5,
      color: Palette.darkMode,
      margin: EdgeInsets.symmetric(vertical: 7, horizontal: 6),
    ),
    dataTableTheme: DataTableThemeData(
      columnSpacing: 20,
      horizontalMargin: 10,
      headingRowHeight: 36,
      headingRowColor:
          MaterialStateColor.resolveWith((states) => Palette.primary),
      dataRowColor:
          MaterialStateColor.resolveWith((states) => Palette.darkMode),
      headingTextStyle: TextStyle(
        // color: Palette.primary,
        color: Palette.white,
        fontWeight: FontWeight.w700,
        fontSize: 18,
      ),
    ),
  );

  static final lightTheme = ThemeData(
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(
        color: Palette.white,
      ),
      textTheme: TextTheme(
        headline6: TextStyle(
          color: Palette.white,
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
        ),
      ),
      centerTitle: false,
      elevation: 16.0,
      color: Palette.primary,
    ),
    tabBarTheme: TabBarTheme(
      labelColor: Palette.white,
      unselectedLabelColor: Palette.lightGrey,
      labelPadding: EdgeInsets.only(top: 4),
      indicatorSize: TabBarIndicatorSize.tab,
    ),
    scaffoldBackgroundColor: Palette.white,
    iconTheme: IconThemeData(color: Palette.white),
    colorScheme: ColorScheme.light(
      primary: Palette.primary,
      // secondary: Palette.secondary,
      // error: Palette.lose,
    ),
    cardTheme: CardTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
      elevation: 5,
      color: Palette.lightGrey,
      margin: EdgeInsets.symmetric(vertical: 7, horizontal: 6),
    ),
    dataTableTheme: DataTableThemeData(
      columnSpacing: 20,
      horizontalMargin: 10,
      headingRowHeight: 36,
      headingRowColor:
          MaterialStateColor.resolveWith((states) => Palette.primary),
      dataRowColor:
          MaterialStateColor.resolveWith((states) => Palette.lightGrey),
      headingTextStyle: TextStyle(
        color: Palette.white,
        fontWeight: FontWeight.w700,
        fontSize: 18,
      ),
    ),
  );
}
