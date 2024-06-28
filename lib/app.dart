import 'package:flutter/material.dart';
import 'package:flutter_task/presentation/screen/productsPage.dart';
import 'package:flutter_task/presentation/utils/app_colors.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'controller_binder.dart';

class MyTask extends StatelessWidget {
   MyTask({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: _themeData,
      home: const ProductsPage(),
      initialBinding: ControllerBinder(),
    );
  }
  final _themeData = ThemeData(
      fontFamily: 'Roboto',
      inputDecorationTheme: InputDecorationTheme(
          fillColor: const Color(0x75D5D5D5),
          filled: true,
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8),
          )),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            backgroundColor: AppColors.themeColor,
            foregroundColor: Colors.white,
            padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12)),
      ),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              foregroundColor: AppColors.themeColor,
              textStyle: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 16))),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w600,
        ),
      ),

      chipTheme: ChipThemeData(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50)
          )
      )
  );
}