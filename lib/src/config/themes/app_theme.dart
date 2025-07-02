// import 'package:flutter/material.dart';
// import 'app_colors.dart';

// const String kFontFamily = "Poppins";

// class AppThemes {
//   static ThemeData get lightTheme => ThemeData(
//     brightness: Brightness.light,
//     primaryColor: AppColors.primaryColor,
//     scaffoldBackgroundColor: Colors.grey.shade100,
//     fontFamily: kFontFamily,
//     appBarTheme: AppBarTheme(
//       backgroundColor: Colors.grey.shade100,
//       // foregroundColor: Colors.grey.shade100,
//     ),
//     elevatedButtonTheme: ElevatedButtonThemeData(
//       style: ElevatedButton.styleFrom(
//         backgroundColor: AppColors.primaryColor,
//         foregroundColor: Colors.white,
//       ),
//     ),
//     colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
//     inputDecorationTheme: InputDecorationTheme(
//       border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//       filled: true,
//       fillColor: Colors.white,
//       hintStyle: TextStyle(color: Colors.grey.shade400),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(10),
//         borderSide: BorderSide(color: Colors.grey.shade300),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(10),
//         borderSide: BorderSide(color: Colors.grey.shade300),
//       ),
//       errorBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(10),
//         borderSide: BorderSide(color: AppColors.errorColor),
//       ),
//     ),
//     textTheme: TextTheme(
//       displayLarge: TextStyle(
//         fontFamily: kFontFamily,
//         fontSize: 57,
//         color: Colors.black87,
//       ),
//       displayMedium: TextStyle(
//         fontFamily: kFontFamily,
//         fontSize: 45,
//         color: Colors.black87,
//       ),
//       displaySmall: TextStyle(
//         fontFamily: kFontFamily,
//         fontSize: 36,
//         color: Colors.black87,
//       ),
//       headlineLarge: TextStyle(
//         fontFamily: kFontFamily,
//         fontSize: 32,
//         color: Colors.black87,
//       ),
//       headlineMedium: TextStyle(
//         fontFamily: kFontFamily,
//         fontSize: 28,
//         color: Colors.black87,
//       ),
//       headlineSmall: TextStyle(
//         fontFamily: kFontFamily,
//         fontSize: 24,
//         color: Colors.black87,
//       ),
//       titleLarge: TextStyle(
//         fontFamily: kFontFamily,
//         fontSize: 22,
//         color: Colors.black87,
//       ),
//       titleMedium: TextStyle(
//         fontFamily: kFontFamily,
//         fontSize: 16,
//         color: Colors.black87,
//       ),
//       titleSmall: TextStyle(
//         fontFamily: kFontFamily,
//         fontSize: 14,
//         color: Colors.black87,
//       ),
//       bodyLarge: TextStyle(
//         fontFamily: kFontFamily,
//         fontSize: 16,
//         color: Colors.black87,
//       ),
//       bodyMedium: TextStyle(
//         fontFamily: kFontFamily,
//         fontSize: 14,
//         color: Colors.black87,
//       ),
//       bodySmall: TextStyle(
//         fontFamily: kFontFamily,
//         fontSize: 12,
//         color: Colors.black87,
//       ),
//       labelLarge: TextStyle(
//         fontFamily: kFontFamily,
//         fontSize: 14,
//         color: Colors.black87,
//       ),
//       labelMedium: TextStyle(
//         fontFamily: kFontFamily,
//         fontSize: 12,
//         color: Colors.black87,
//       ),
//       labelSmall: TextStyle(
//         fontFamily: kFontFamily,
//         fontSize: 11,
//         color: Colors.black87,
//       ),
//     ),
//   );

//   static ThemeData get darkTheme => ThemeData(
//     brightness: Brightness.dark,
//     primaryColor: AppColors.primaryColor,
//     scaffoldBackgroundColor: Colors.black,
//     fontFamily: kFontFamily,
//     appBarTheme: AppBarTheme(
//       backgroundColor: Colors.black,
//       foregroundColor: Colors.white,
//     ),
//     elevatedButtonTheme: ElevatedButtonThemeData(
//       style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryColor),
//     ),
//     colorScheme: ColorScheme.fromSeed(
//       seedColor: AppColors.primaryColor,
//       brightness: Brightness.dark,
//     ),
//     textTheme: TextTheme(
//       displayLarge: TextStyle(
//         fontFamily: kFontFamily,
//         fontSize: 57,
//         color: Colors.white,
//       ),
//       displayMedium: TextStyle(
//         fontFamily: kFontFamily,
//         fontSize: 45,
//         color: Colors.white,
//       ),
//       displaySmall: TextStyle(
//         fontFamily: kFontFamily,
//         fontSize: 36,
//         color: Colors.white,
//       ),
//       headlineLarge: TextStyle(
//         fontFamily: kFontFamily,
//         fontSize: 32,
//         color: Colors.white,
//       ),
//       headlineMedium: TextStyle(
//         fontFamily: kFontFamily,
//         fontSize: 28,
//         color: Colors.white,
//       ),
//       headlineSmall: TextStyle(
//         fontFamily: kFontFamily,
//         fontSize: 24,
//         color: Colors.white,
//       ),
//       titleLarge: TextStyle(
//         fontFamily: kFontFamily,
//         fontSize: 22,
//         color: Colors.white,
//       ),
//       titleMedium: TextStyle(
//         fontFamily: kFontFamily,
//         fontSize: 16,
//         color: Colors.white,
//       ),
//       titleSmall: TextStyle(
//         fontFamily: kFontFamily,
//         fontSize: 14,
//         color: Colors.white,
//       ),
//       bodyLarge: TextStyle(
//         fontFamily: kFontFamily,
//         fontSize: 16,
//         color: Colors.white,
//       ),
//       bodyMedium: TextStyle(
//         fontFamily: kFontFamily,
//         fontSize: 14,
//         color: Colors.white,
//       ),
//       bodySmall: TextStyle(
//         fontFamily: kFontFamily,
//         fontSize: 12,
//         color: Colors.white,
//       ),
//       labelLarge: TextStyle(
//         fontFamily: kFontFamily,
//         fontSize: 14,
//         color: Colors.white,
//       ),
//       labelMedium: TextStyle(
//         fontFamily: kFontFamily,
//         fontSize: 12,
//         color: Colors.white,
//       ),
//       labelSmall: TextStyle(
//         fontFamily: kFontFamily,
//         fontSize: 11,
//         color: Colors.white,
//       ),
//     ),
//   );
// }

import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static get lightTheme => ThemeData(
        useMaterial3: false,
        scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
        fontFamily: AppStrings.fontFamily,
        brightness: Brightness.light,
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: AppColors.primaryColor,
          onPrimary: AppColors.whiteColor,
          secondary: AppColors.secondColor,
          onSecondary: AppColors.secondColor,
          error: AppColors.error,
          onError: AppColors.error,
          background: AppColors.primaryColor,
          onBackground: AppColors.primaryColor,
          surface: AppColors.primaryColor,
          onSurface: AppColors.primaryColor,
        ),
        buttonTheme: const ButtonThemeData(buttonColor: AppColors.primaryColor),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontFamily: AppStrings.fontFamily,
            //fontSize: AppSize.s16,
            fontWeight: FontWeight.w600,
            color: AppColors.textColor,
          ),
          headlineMedium: TextStyle(
            fontFamily: AppStrings.fontFamily,
            //fontSize: AppSize.s16,
            fontWeight: FontWeight.w600,
            color: AppColors.textColor,
          ),
          headlineSmall: TextStyle(
            fontFamily: AppStrings.fontFamily,
            fontWeight: FontWeight.w600,
            color: AppColors.textColor,
          ),
          bodyLarge: TextStyle(
            fontFamily: AppStrings.fontFamily,
            fontWeight: FontWeight.w600,
            // color: AppColors.primaryColor,
            fontSize: 14,
          ),
          bodySmall: TextStyle(
            fontFamily: AppStrings.fontFamily,
            fontWeight: FontWeight.w400,
            color: AppColors.secondaryTextColor,
          ),
          bodyMedium: TextStyle(
            fontFamily: AppStrings.fontFamily,
            color: AppColors.textColor,
          ),
          titleMedium: TextStyle(
            fontFamily: AppStrings.fontFamily,
            color: AppColors.blackColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primaryColor),
          ),
          fillColor: Colors.white,
          filled: true,
          // hintStyle: TextStyle(color: Colors.grey.shade),
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.strokeColor, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primaryColor, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.error, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(10)),
            //borderRadius: BorderRadius.circular(10),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.error, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          prefixIconColor: AppColors.secondaryColor,
          suffixIconColor: AppColors.secondaryColor,
          hintStyle: TextStyle(
            fontFamily: AppStrings.fontFamily,
            fontWeight: FontWeight.w300,
            color: AppColors.secondaryTextColor,
          ),
          labelStyle: TextStyle(
            fontFamily: AppStrings.fontFamily,
            fontWeight: FontWeight.w300,
            color: AppColors.secondaryTextColor,
          ),
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          iconTheme: IconThemeData(color: AppColors.secondColor),
          elevation: 0,
          // shape: Border(
          //   bottom: BorderSide(
          //     width: AppValues.s1,
          //     color: AppColors.strokeColor,
          //   ),
          // ),
          color: AppColors.scaffoldBackgroundColor,
          titleTextStyle: TextStyle(
            fontFamily: AppStrings.fontFamily,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.blackColor,
          ),
        ),
        drawerTheme: const DrawerThemeData(backgroundColor: Colors.white),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            elevation: const MaterialStatePropertyAll(0),
            backgroundColor:
                const MaterialStatePropertyAll(AppColors.primaryColor),
            foregroundColor:
                const MaterialStatePropertyAll(AppColors.whiteColor),
            minimumSize:
                const MaterialStatePropertyAll(Size(double.maxFinite, 50)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  10,
                ), // Define o raio da borda aqui
              ),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            minimumSize:
                const MaterialStatePropertyAll(Size(double.infinity, 50)),
            foregroundColor:
                const MaterialStatePropertyAll(AppColors.primaryColor),
            side: MaterialStateProperty.all(
              BorderSide(
                color: AppColors.secondColor, // Cor da borda
                width: 1.5, // Largura da borda
              ),
            ),
          ),
        ),
      );
  static get darkTheme => ThemeData(
        useMaterial3: false,
        scaffoldBackgroundColor: Colors.black,
        fontFamily: AppStrings.fontFamily,
        brightness: Brightness.light,
        buttonTheme: const ButtonThemeData(buttonColor: AppColors.primaryColor),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontFamily: AppStrings.fontFamily,
            //fontSize: AppSize.s16,
            fontWeight: FontWeight.w600,
            color: AppColors.textColor,
          ),
          headlineMedium: TextStyle(
            fontFamily: AppStrings.fontFamily,
            //fontSize: AppSize.s16,
            fontWeight: FontWeight.w600,
            color: AppColors.textColor,
          ),
          headlineSmall: TextStyle(
            fontFamily: AppStrings.fontFamily,
            fontWeight: FontWeight.w600,
            color: AppColors.textColor,
          ),
          bodyLarge: TextStyle(
            fontFamily: AppStrings.fontFamily,
            fontWeight: FontWeight.w600,
            color: AppColors.textColor,
          ),
          bodySmall: TextStyle(
            fontFamily: AppStrings.fontFamily,
            fontWeight: FontWeight.w400,
            color: AppColors.secondaryTextColor,
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.strokeColor),
            //            borderRadius: BorderRadius.circular(10),
          ),
          // focusedBorder: OutlineInputBorder(
          //   borderSide: BorderSide(color: AppColors.primaryColor50),
          //   //borderRadius: BorderRadius.circular(10),
          // ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primaryColor),
            //borderRadius: BorderRadius.circular(10),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primaryColor),
            //borderRadius: BorderRadius.circular(10),
          ),
          prefixIconColor: AppColors.secondaryColor,
          suffixIconColor: AppColors.secondaryColor,
          hintStyle: TextStyle(fontSize: 14),
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          color: Color(0xff363636),
          titleTextStyle: TextStyle(
            fontFamily: AppStrings.fontFamily,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.textColor,
          ),
        ),
        drawerTheme: const DrawerThemeData(backgroundColor: Color(0xff363636)),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor:
                const MaterialStatePropertyAll(AppColors.primaryColor),
            foregroundColor:
                const MaterialStatePropertyAll(AppColors.whiteColor),
            minimumSize:
                const MaterialStatePropertyAll(Size(double.maxFinite, 50)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  10,
                ), // Define o raio da borda aqui
              ),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            minimumSize:
                const MaterialStatePropertyAll(Size(double.infinity, 50)),
            foregroundColor:
                const MaterialStatePropertyAll(AppColors.primaryColor),
            side: MaterialStateProperty.all(
              BorderSide(
                color: AppColors.primaryColor, // Cor da borda
                width: 1.5, // Largura da borda
              ),
            ),
          ),
        ),
      );
}

class AppStrings {
  static const fontFamily = "Poppins";
}
