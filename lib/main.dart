import 'package:attendify/pages/auth/screens/splash/screens/splash_screen.dart';
import 'package:attendify/utils/constant/app_color.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColor.primaryColor),
      ),
      home: SplashScreen(),
    );
  }
}

