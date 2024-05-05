import 'package:flutter/material.dart';
import 'package:nurbs_driving_test/const/constant.dart';
import 'package:nurbs_driving_test/const/theme_setting.dart';
import 'package:provider/provider.dart';

class Styles {
  static ThemeData themeData(BuildContext context) {
    final themeSate = Provider.of<ThemeSetting>(context).currentTheme;
    var isLight = themeSate.brightness == Brightness.light;

    return ThemeData(
      primaryColor: Colors.white,
      //  textTheme: TextTheme(),
      colorScheme: ThemeData().colorScheme.copyWith(
            brightness: isLight ? Brightness.light : Brightness.dark,
          ),
      scaffoldBackgroundColor: isLight
          ? Colors.grey.shade200
          : const Color.fromARGB(255, 15, 27, 65),
      appBarTheme: AppBarTheme(
          backgroundColor: isLight
              ? Colors.grey.shade200
              : const Color.fromARGB(255, 15, 27, 65),
          elevation: 0,
          foregroundColor: isLight ? Colors.black : Colors.white),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: greenDark, foregroundColor: Colors.white),
      drawerTheme: DrawerThemeData(
          backgroundColor: isLight ? Colors.grey.shade200 : blueDark,
          surfaceTintColor: isLight ? Colors.grey.shade700 : Colors.white),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: isLight
            ? Colors.grey.shade200
            : const Color.fromARGB(255, 15, 27, 65),
      ),
    );
  }
}
