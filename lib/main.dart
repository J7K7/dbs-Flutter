import 'package:dbs_frontend/Themes/AppTheme.dart';
import 'package:dbs_frontend/pages/SplashScreen/Screen.dart';
import 'package:dbs_frontend/pages/ViewAllProducts/screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import 'package:ums_d/emo/Themes/AppTheme.dart';

void main() {
  runApp(const MyApp());

// sbvhjsd

// xhangwes for master it is
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return SimpleBuilder(
      builder: (_) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          // themeMode: ThemeMode.dark,
          home: ViewAllProducts(),
          // home: LoginScreen(),
        );
      },
    );
  }
}
