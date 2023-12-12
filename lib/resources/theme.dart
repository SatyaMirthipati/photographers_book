import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

class AppTheme {
  static ThemeData get theme {
    var typography = Typography.material2021(platform: defaultTargetPlatform);
    var textTheme = typography.black.apply(
      fontFamily: 'Poppins',
      bodyColor: Colors.black,
      displayColor: Colors.black,
    );

    var titleLarge = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w800,
      fontFamily: 'Poppins',
      color: Colors.black,
      height: 25 / 16,
      letterSpacing: 0,
    ); // Done

    var titleMedium = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      fontFamily: 'Poppins',
      height: 20 / 14,
      color: Colors.black,
      letterSpacing: 0,
    ); // Done

    var titleSmall = const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      fontFamily: 'Poppins',
      height: 17 / 14,
      color: Colors.black,
      letterSpacing: 0,
    ); // Done

    var labelLarge = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      fontFamily: 'Poppins',
      height: 1,
      color: Colors.black,
      letterSpacing: 0,
    ); // Done

    var labelSmall = TextStyle(
      fontSize: 12,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w400,
      height: 15 / 12,
      color:  Colors.black.withOpacity(0.7),
      letterSpacing: 0,
    );

    var bodyLarge = const TextStyle(
      fontFamily: 'ReadexPro',
      fontWeight: FontWeight.w600,
      fontSize: 16,
      height: 1,
      color: Colors.black,
      fontStyle: FontStyle.normal,
      letterSpacing: 0,
    );

    var bodyMedium = TextStyle(
      fontFamily: 'ReadexPro',
      fontWeight: FontWeight.w500,
      fontSize: 12,
      height: 1,
      color: Colors.black.withOpacity(0.7),
      fontStyle: FontStyle.normal,
      letterSpacing: 0,
    );

    var bodySmall = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      fontFamily: 'ReadexPro',
      letterSpacing: 0,
      height: 1,
      color: Colors.black,
    );

    var headlineMedium = const TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w600,
      fontSize: 18,
      height: 27 / 18,
      color: Colors.black,
      fontStyle: FontStyle.normal,
      letterSpacing: 0,
    ); // Done

    var headlineSmall = const TextStyle(
      fontSize: 30,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w600,
      height: 38 / 30,
      color: Colors.black,
      letterSpacing: 0,
      fontStyle: FontStyle.normal,
    );

    textTheme = textTheme.copyWith(
      headlineMedium: headlineMedium,
      headlineSmall: headlineSmall,
      titleLarge: titleLarge,
      titleMedium: titleMedium,
      titleSmall: titleSmall,
      bodyLarge: bodyLarge,
      bodyMedium: bodyMedium,
      bodySmall: bodySmall,
      labelLarge: labelLarge,
      labelSmall: labelSmall,
    );

    var border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: MyColors.border, width: 1),
    );

    return ThemeData(
      fontFamily: 'Albert Sans',
      scaffoldBackgroundColor: MyColors.background,
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: Colors.black,
        selectionColor: primaryColor.withOpacity(0.3),
        selectionHandleColor: primaryColor,
      ),
      primaryColor: primaryColor,
      indicatorColor: primaryColor,
      canvasColor: Colors.white,
      textTheme: textTheme,
      primaryTextTheme: textTheme,
      typography: typography,
      cardTheme: CardTheme(
        elevation: 0,
        margin: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        clipBehavior: Clip.antiAlias,
      ),
      appBarTheme: AppBarTheme(
        elevation: 4,
        titleSpacing: 0,
        backgroundColor: MyColors.background,
        systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: Colors.white,
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: false,
        titleTextStyle: titleLarge.copyWith(color: Colors.black, fontSize: 18),
      ),
      dialogTheme: DialogTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      buttonTheme: ButtonThemeData(
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.all(16),
        buttonColor: primaryColor,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: MyColors.accentColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          textStyle: labelLarge,
          fixedSize: const Size(140, 50),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: MyColors.accentColor,
          padding: EdgeInsets.zero,
          textStyle: titleMedium.copyWith(fontSize: 13),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: MyColors.primaryColor,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 2,
              color: MyColors.border.withOpacity(0.35),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          side: BorderSide(width: 2, color: MyColors.border.withOpacity(0.35)),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          textStyle: bodySmall,
          fixedSize: const Size(140, 50),
        ),
      ),
      popupMenuTheme: PopupMenuThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: const BorderSide(color: MyColors.divider, width: 1),
        ),
        elevation: 0,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        iconSize: 22,
        elevation: 0,
        disabledElevation: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        filled: false,
        hintStyle: bodySmall.copyWith(color: Colors.black.withOpacity(0.7)),
        labelStyle: titleSmall.copyWith(
          color: Colors.black.withOpacity(0.5),
          fontSize: 14,
        ),
        errorStyle: bodyLarge.copyWith(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.8,
          color: const Color(0xFFcf6679),
          fontFamily: 'Poppins'
        ),
        border: border,
        enabledBorder: border,
        focusedBorder: border,
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      iconTheme: const IconThemeData(color: Colors.black, size: 24),
      dividerTheme: const DividerThemeData(
        thickness: 1,
        space: 1,
        // color: MyColors.divider,
      ),
      checkboxTheme: CheckboxThemeData(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        splashRadius: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        side: MaterialStateBorderSide.resolveWith(
          (states) => const BorderSide(width: 1, color: MyColors.primaryColor),
        ),
        checkColor: MaterialStateProperty.all(MyColors.primaryColor),
        fillColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return Colors.white;
          }
          return const Color(0xFFFFFFFF);
        }),
        overlayColor: MaterialStateProperty.all(const Color(0xFFFFFFFF)),
      ),
      radioTheme: RadioThemeData(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        fillColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return primaryColor;
          } else {
            return const Color(0xFFB5B5B5);
          }
        }),
      ).copyWith(
        fillColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return null;
          }
          if (states.contains(MaterialState.selected)) {
            return primaryColor;
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
            return MyColors.primaryColor;
          }
          return null;
        }),
        trackColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return null;
          }
          if (states.contains(MaterialState.selected)) {
            return MyColors.primaryColor;
          }
          return null;
        }),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: MyColors.card,
        disabledColor: Colors.grey,
        selectedColor: primaryColor,
        secondarySelectedColor: primaryColor,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        labelStyle: bodyLarge.copyWith(height: 1.2, color: Colors.black),
        secondaryLabelStyle: bodyLarge.copyWith(
          height: 1.2,
          color: Colors.white,
        ),
        brightness: Brightness.dark,
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: primaryColor,
        activeTickMarkColor: primaryColor,
        thumbColor: primaryColor,
        inactiveTrackColor: primaryColor.withOpacity(.2),
      ),
      tabBarTheme: TabBarTheme(
        indicatorSize: TabBarIndicatorSize.tab,
        // labelColor: MyColors.accentColor3,
        unselectedLabelColor: Colors.black.withOpacity(0.7),
        labelStyle: titleLarge.copyWith(
          fontWeight: FontWeight.w700,
          // color: MyColors.accentColor3,
          // fontSize: 14,
        ),
        unselectedLabelStyle: bodySmall.copyWith(
          fontWeight: FontWeight.w400,
          // fontSize: 14,
        ),
      ),
      colorScheme: ColorScheme.light(
        primary: primaryColor,
        secondary: primaryColor,
        onSecondary: Colors.white,
        brightness: Brightness.light,
        background: Colors.white,
      ).copyWith(background: MyColors.background),
    );
  }

  static Color primaryColor = MyColors.primaryColor;
}
