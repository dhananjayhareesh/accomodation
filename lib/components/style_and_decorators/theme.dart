import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomThemeData {
  ThemeData? getThemeData(isLightMode) {
    return isLightMode
        ? ThemeData(
            visualDensity: VisualDensity.adaptivePlatformDensity,
            primaryColor: const Color(0xFFF8B62E),
            canvasColor: Colors.white, // For bottom sheets
            scaffoldBackgroundColor: const Color(0xFFFAFAFB),
            dialogBackgroundColor: Colors.white, // For dialogs
            bottomSheetTheme: const BottomSheetThemeData(
              backgroundColor: Colors.white, // For modal & persistent sheets
              modalBackgroundColor: Colors.white,
            ),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            textTheme: TextTheme(
              displayLarge: GoogleFonts.assistant(),
              headlineLarge: GoogleFonts.assistant(),
              displayMedium: GoogleFonts.assistant(),
              headlineMedium: GoogleFonts.assistant(),
              displaySmall: GoogleFonts.assistant(),
              headlineSmall: GoogleFonts.assistant(),
              bodySmall: GoogleFonts.assistant(
                fontSize: 14,
                color: const Color(0xFF868686),
                fontWeight: FontWeight.w500,
              ),
              titleSmall: GoogleFonts.assistant(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.black,
                textStyle: const TextStyle(
                  overflow: TextOverflow.visible,
                ),
              ),
              titleMedium: GoogleFonts.assistant(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              titleLarge: GoogleFonts.assistant(
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
              bodyMedium: GoogleFonts.assistant(),
              bodyLarge: GoogleFonts.assistant(),
              labelSmall: GoogleFonts.assistant(
                fontSize: 14,
                letterSpacing: 0.2,
                fontWeight: FontWeight.w400,
              ),
              labelMedium: GoogleFonts.assistant(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                textStyle: const TextStyle(
                  overflow: TextOverflow.visible,
                ),
              ),
              labelLarge: GoogleFonts.assistant(
                fontSize: 19,
                fontWeight: FontWeight.w400,
                textStyle: const TextStyle(
                  overflow: TextOverflow.visible,
                ),
              ),
            ),
            tabBarTheme: TabBarThemeData(
              labelStyle: GoogleFonts.assistant(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              unselectedLabelStyle: GoogleFonts.assistant(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(
                  color: Get.theme.primaryColor,
                  width: 3,
                  style: BorderStyle.solid,
                ),
              ),
              labelColor: Colors.black,
            ),
            appBarTheme: AppBarTheme(
              elevation: 0,
              color: const Color(0xFFF8B62E),
              centerTitle: false,
              titleTextStyle: GoogleFonts.assistant(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              iconTheme: const IconThemeData(
                color: Colors.white,
              ),
            ),
            bottomAppBarTheme: const BottomAppBarThemeData(
              color: Color(0xfff4f4f4),
              elevation: 5,
            ),
            cardTheme: CardThemeData(
              color: Colors.white,
              elevation: 4,
              shadowColor: const Color(0xffBDC8DF).withOpacity(0.7),
            ),
            shadowColor: const Color(0xffBDC8DF).withOpacity(0.7),
            textButtonTheme: TextButtonThemeData(
              style: ButtonStyle(
                foregroundColor: WidgetStateProperty.all<Color>(
                  const Color(0xFFF8B62E),
                ),
                textStyle: WidgetStateProperty.all<TextStyle>(
                  const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            radioTheme: RadioThemeData(
              fillColor: MaterialStateProperty.all<Color>(
                const Color(0xFFF8B62E),
              ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  const Color(0xFF781128),
                ),
                foregroundColor: MaterialStateProperty.all<Color>(
                  Colors.white,
                ),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  const StadiumBorder(),
                ),
                padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                ),
              ),
            ),
            colorScheme: const ColorScheme(
              brightness: Brightness.light,
              primary: Color(0xFF781128),
              onPrimary: Colors.white,
              secondary: Color(0xffF3E1FE),
              onSecondary: Colors.white,
              error: Colors.red,
              onError: Colors.white,
              background: Colors.white,
              onBackground: Colors.black,
              surface: Colors.white,
              onSurface: Colors.black,
              surfaceVariant: Colors.white, // Override to white
            ).copyWith(
              background: Colors.white,
            ),
          )
        : ThemeData(
            canvasColor: Colors.white,
            scaffoldBackgroundColor: Colors.black87,
            dialogBackgroundColor: Colors.white,
            bottomSheetTheme: const BottomSheetThemeData(
              backgroundColor: Colors.white,
              modalBackgroundColor: Colors.white,
            ),
            textTheme: TextTheme(
              titleSmall: TextStyle(
                fontSize: Get.height * 0.0193,
                color: Colors.green,
              ),
              titleMedium: TextStyle(
                fontSize: Get.height * 0.0201,
                fontWeight: FontWeight.w500,
              ),
              titleLarge: TextStyle(
                fontSize: Get.height * 0.0241,
                fontWeight: FontWeight.w500,
              ),
              labelSmall: TextStyle(
                fontSize: Get.height * 0.0101,
                fontWeight: FontWeight.w500,
                color: Colors.green,
              ),
            ),
            appBarTheme: const AppBarTheme(
              color: Colors.white,
              elevation: 0,
            ),
            bottomAppBarTheme: const BottomAppBarThemeData(
              color: Color(0xfff4f4f4),
              elevation: 5,
            ),
            shadowColor: const Color(0xffBDC8DF).withOpacity(0.7),
            cardTheme: CardThemeData(
              color: Colors.white,
              elevation: 4,
              shadowColor: const Color(0xffBDC8DF).withOpacity(0.7),
            ),
            textButtonTheme: TextButtonThemeData(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(
                  const Color(0xffFB8402),
                ),
              ),
            ),
            radioTheme: RadioThemeData(
              fillColor: MaterialStateProperty.all<Color>(
                const Color(0xffFB8402),
              ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Colors.black,
                ),
                foregroundColor: MaterialStateProperty.all<Color>(
                  Colors.white,
                ),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  const StadiumBorder(),
                ),
                padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                ),
              ),
            ),
            colorScheme: const ColorScheme(
              brightness: Brightness.light,
              primary: Colors.black,
              onPrimary: Colors.black,
              secondary: Colors.black,
              onSecondary: Colors.white,
              error: Colors.red,
              onError: Colors.white,
              background: Colors.white,
              onBackground: Colors.black,
              surface: Colors.white,
              onSurface: Colors.black,
              surfaceVariant: Colors.white,
            ).copyWith(
              background: const Color(0XFFBA5AF8),
            ),
          );
  }
}
