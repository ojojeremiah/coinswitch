import 'package:coinswitch/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemes {
  static final appLightTheme = ThemeData(
    hoverColor: AppColors.backgroundColor,
    brightness: Brightness.light,
    primaryColor: AppColors.primaryColor,
    canvasColor: AppColors.backgroundColor,
    scaffoldBackgroundColor: AppColors.backgroundColor,
    shadowColor: AppColors.backgroundColor,
    cardColor: AppColors.primaryColor,
    dividerColor: AppColors.primaryColor,
    highlightColor: AppColors.backgroundColor,
    splashColor: AppColors.backgroundColor,
    disabledColor: AppColors.backgroundColor,
    dialogBackgroundColor: AppColors.backgroundColor,
    indicatorColor: AppColors.backgroundColor,
    hintColor: AppColors.colorGrey,
    textTheme: GoogleFonts.getTextTheme(
      "Poppins",
      TextTheme(
        displayLarge: TextStyle(
          color: AppColors.primaryColor,
          fontSize: 34.sp,
          fontWeight: FontWeight.w600,
        ),
        displayMedium: TextStyle(
          color: AppColors.primaryColor,
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: TextStyle(
          color: AppColors.primaryColor,
          fontSize: 15.sp,
        ),
        titleSmall: TextStyle(
          color: AppColors.primaryColor,
          fontSize: 15.sp,
        ),
        bodyLarge: TextStyle(
          color: AppColors.primaryColor,
          fontSize: 14.sp,
        ),
      ),
    ),
    primaryTextTheme: GoogleFonts.getTextTheme(
        "Poppins",
        TextTheme(
          headlineSmall: TextStyle(
            color: AppColors.primaryColor,
            fontSize: 18.sp,
          ),
          titleMedium: TextStyle(
            color: AppColors.primaryColor,
            fontSize: 15.sp,
          ),
          titleSmall: TextStyle(
            color: AppColors.primaryColor,
            fontSize: 15.sp,
          ),
          bodyLarge: TextStyle(
            color: AppColors.primaryColor,
            fontSize: 14.sp,
          ),
          bodyMedium: TextStyle(
            color: AppColors.primaryColor,
            fontSize: 14.sp,
          ),
          bodySmall: TextStyle(
            color: AppColors.primaryColor,
            fontSize: 14.sp,
          ),
        )),
    iconTheme: IconThemeData(
      color: AppColors.primaryColor,
      opacity: 1,
      size: 30.w,
    ),
    primaryIconTheme: IconThemeData(
      color: AppColors.colorGrey,
      opacity: 1,
      size: 20.w,
    ),
    tabBarTheme: const TabBarTheme(
      indicatorSize: TabBarIndicatorSize.tab,
      labelColor: AppColors.colorGrey,
      unselectedLabelColor: AppColors.primaryColor,
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return null;
            }
            if (states.contains(MaterialState.selected)) {
              return AppColors.primaryColor;
            }
            return null;
          }),
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return null;
            }
            if (states.contains(MaterialState.selected)) {
              return AppColors.primaryColor;
            }
            return null;
          }),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return null;
            }
            if (states.contains(MaterialState.selected)) {
              return AppColors.primaryColor;
            }
            return null;
          }),
      trackColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return null;
            }
            if (states.contains(MaterialState.selected)) {
              return AppColors.primaryColor;
            }
            return null;
          }),
    ),
    bottomAppBarTheme:
    const BottomAppBarTheme(color: AppColors.backgroundColor, shadowColor: AppColors.backgroundColor),
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
        .copyWith(background: AppColors.primaryColor)
        .copyWith(error: Colors.red),
  );

  static final appDarkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryColor,
    canvasColor: AppColors.backgroundColor,
    scaffoldBackgroundColor: AppColors.backgroundColor,
    cardColor: AppColors.backgroundColor,
    dividerColor: AppColors.cardColor,
    highlightColor: AppColors.cardColor,
    splashColor: AppColors.cardColor,
    disabledColor: AppColors.cardColor,
    dialogBackgroundColor: AppColors.backgroundColor,
    indicatorColor: AppColors.primaryColor,
    hintColor: AppColors.primaryColor,
    textTheme: GoogleFonts.getTextTheme(
      "Poppins",
      TextTheme(
        headlineSmall: TextStyle(
          color: AppColors.primaryColor,
          fontSize: 18.sp,
        ),
        titleMedium: TextStyle(
          color: AppColors.primaryColor,
          fontSize: 15.sp,
        ),
        titleSmall: TextStyle(
          color: AppColors.primaryColor,
          fontSize: 15.sp,
        ),
        bodyLarge: TextStyle(
          color: AppColors.primaryColor,
          fontSize: 14.sp,
        ),
        bodyMedium: TextStyle(
          color: AppColors.primaryColor,
          fontSize: 14.sp,
        ),
        bodySmall: TextStyle(
          color: AppColors.primaryColor,
          fontSize: 13.sp,
        ),
      ),
    ),
    primaryTextTheme: GoogleFonts.getTextTheme(
      "Poppins",
      TextTheme(
        headlineSmall: TextStyle(
          color: AppColors.primaryColor,
          fontSize: 18.sp,
        ),
        titleMedium: TextStyle(
          color: AppColors.primaryColor,
          fontSize: 15.sp,
        ),
        titleSmall: TextStyle(
          color: AppColors.primaryColor,
          fontSize: 15.sp,
        ),
        bodyLarge: TextStyle(
          color: AppColors.primaryColor,
          fontSize: 14.sp,
        ),
        bodyMedium: TextStyle(
          color: AppColors.primaryColor,
          fontSize: 14.sp,
        ),
        bodySmall: TextStyle(
          color: AppColors.primaryColor,
          fontSize: 13.sp,
        ),
      ),
    ),
    iconTheme: IconThemeData(
      color: AppColors.primaryColor,
      opacity: 1,
      size: 30.sp,
    ),
    primaryIconTheme: IconThemeData(
      color: AppColors.primaryColor,
      opacity: 1,
      size: 30.sp,
    ),
    tabBarTheme: const TabBarTheme(
      indicatorSize: TabBarIndicatorSize.tab,
      labelColor: AppColors.primaryColor,
      unselectedLabelColor: AppColors.cardColor,
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return null;
            }
            if (states.contains(MaterialState.selected)) {
              return AppColors.primaryColor;
            }
            return null;
          }),
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return null;
            }
            if (states.contains(MaterialState.selected)) {
              return AppColors.primaryColor;
            }
            return null;
          }),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return null;
            }
            if (states.contains(MaterialState.selected)) {
              return AppColors.primaryColor;
            }
            return null;
          }),
      trackColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return null;
            }
            if (states.contains(MaterialState.selected)) {
              return AppColors.primaryColor;
            }
            return null;
          }),
    ),
    bottomAppBarTheme: const BottomAppBarTheme(color: AppColors.cardColor),
    colorScheme: ColorScheme.fromSwatch(
        primarySwatch: const MaterialColor(4280361249, {
          50: Color(0xfff2f2f2),
          100: Color(0xffe6e6e6),
          200: Color(0xffcccccc),
          300: Color(0xffb3b3b3),
          400: Color(0xff999999),
          500: Color(0xff808080),
          600: Color(0xff666666),
          700: Color(0xff4d4d4d),
          800: Color(0xff333333),
          900: Color(0xff191919)
        }))
        .copyWith(background: AppColors.primaryColor)
        .copyWith(error: Colors.red),
  );
}
