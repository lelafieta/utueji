import 'package:flutter/material.dart';

import '../../core/utils/app_strings.dart';
import '../../core/utils/app_values.dart';
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
        buttonTheme: const ButtonThemeData(
          buttonColor: AppColors.primaryColor,
        ),
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
            color: AppColors.primaryColor,
            fontSize: AppValues.s20,
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
            borderSide: BorderSide(
              color: AppColors.primaryColor,
            ),
          ),
          fillColor: Colors.white,
          filled: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.strokeColor,
              width: AppValues.s1,
            ),
            borderRadius: BorderRadius.all(Radius.circular(AppValues.s10)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.primaryColor,
              width: AppValues.s1,
            ),
            borderRadius: BorderRadius.all(Radius.circular(AppValues.s10)),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.error,
              width: AppValues.s1,
            ),
            borderRadius: BorderRadius.all(Radius.circular(AppValues.s10)),
            //borderRadius: BorderRadius.circular(10),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.error,
              width: AppValues.s1,
            ),
            borderRadius: BorderRadius.all(Radius.circular(AppValues.s10)),
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
            fontSize: AppValues.s18,
            fontWeight: FontWeight.w600,
            color: AppColors.blackColor,
          ),
        ),
        drawerTheme: const DrawerThemeData(
          backgroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            elevation: const MaterialStatePropertyAll(0),
            backgroundColor:
                const MaterialStatePropertyAll(AppColors.primaryColor),
            foregroundColor:
                const MaterialStatePropertyAll(AppColors.whiteColor),
            minimumSize: const MaterialStatePropertyAll(
              Size(double.maxFinite, 50),
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  AppValues.s10,
                ), // Define o raio da borda aqui
              ),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            minimumSize: const MaterialStatePropertyAll(
                Size(double.infinity, AppValues.s50)),
            foregroundColor:
                const MaterialStatePropertyAll(AppColors.primaryColor),
            side: MaterialStateProperty.all(
              const BorderSide(
                color: AppColors.secondColor, // Cor da borda
                width: AppValues.s1_5, // Largura da borda
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
        buttonTheme: const ButtonThemeData(
          buttonColor: AppColors.primaryColor,
        ),
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
          contentPadding: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
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
          hintStyle: TextStyle(fontSize: AppValues.s14),
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          color: Color(0xff363636),
          titleTextStyle: TextStyle(
            fontFamily: AppStrings.fontFamily,
            fontSize: AppValues.s16,
            fontWeight: FontWeight.w600,
            color: AppColors.textColor,
          ),
        ),
        drawerTheme: const DrawerThemeData(
          backgroundColor: Color(0xff363636),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor:
                const MaterialStatePropertyAll(AppColors.primaryColor),
            foregroundColor:
                const MaterialStatePropertyAll(AppColors.whiteColor),
            minimumSize: const MaterialStatePropertyAll(
              Size(double.maxFinite, AppValues.s50),
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    AppValues.s10), // Define o raio da borda aqui
              ),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            minimumSize: const MaterialStatePropertyAll(
                Size(double.infinity, AppValues.s50)),
            foregroundColor:
                const MaterialStatePropertyAll(AppColors.primaryColor),
            side: MaterialStateProperty.all(
              const BorderSide(
                color: AppColors.primaryColor, // Cor da borda
                width: AppValues.s1_5, // Largura da borda
              ),
            ),
          ),
        ),
      );
}
