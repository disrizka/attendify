import 'package:attendify/pages/auth/screens/intoduction/screens/introduction_screen.dart';
import 'package:attendify/pages/auth/screens/login/screens/login_screen.dart';
import 'package:attendify/pages/main/screens/bottom_navigation_bar.dart';
import 'package:attendify/service/pref_handler.dart';
import 'package:attendify/utils/constant/app_color.dart';
import 'package:attendify/utils/constant/app_image.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    getDataUser();
  }

  void getDataUser() async {
    var token = await PreferenceHandler.getToken();
    var lookWelcoming = await PreferenceHandler.getLookWelcoming();
    Future.delayed(Duration(seconds: 2), () {
      if (lookWelcoming == false) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => IntroScreen()),
        );
      } else if (token != '' || token!.isNotEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BottomBar()),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              AppImage.logo,
              height: MediaQuery.of(context).size.width * 0.8,
              width: MediaQuery.of(context).size.width * 0.8,
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
