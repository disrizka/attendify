import 'package:attendify/pages/auth/screens/welcome/screens/welcome_screen.dart';
import 'package:attendify/utils/constant/app_color.dart';
import 'package:attendify/utils/constant/app_font.dart';
import 'package:attendify/utils/constant/app_image.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      globalBackgroundColor: AppColor.backgroundColor,
      key: introKey,
      pages: [
        PageViewModel(
          titleWidget: SizedBox.shrink(),
          bodyWidget: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 120),
                Image.asset(AppImage.intro1),
                SizedBox(height: 60),
                Text(
                  "Absen Lebih Akurat \ndengan Lokasi \nReal-Time.",
                  textAlign: TextAlign.center,
                  style: PoppinsTextStyle.bold.copyWith(
                    fontSize: 30,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
        PageViewModel(
          titleWidget: SizedBox.shrink(),
          bodyWidget: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 150),
              Text(
                "Kerja Keliling? \nAbsen Tetap \nAman! ",
                textAlign: TextAlign.center,
                style: PoppinsTextStyle.bold.copyWith(
                  fontSize: 30,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 30),
              Image.asset(AppImage.intro2),
              SizedBox(height: 20),
            ],
          ),
        ),
        PageViewModel(
          titleWidget: SizedBox.shrink(),
          bodyWidget: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 150),
              Image.asset(AppImage.intro3),
              SizedBox(height: 60),
              Text(
                "Mulai Hari Kerjamu \ndengan Absen \nyang Mudah.",
                textAlign: TextAlign.center,
                style: PoppinsTextStyle.bold.copyWith(
                  fontSize: 30,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ],
      showNextButton: false,
      showDoneButton: true,
      done: Text(
        "Done",
        style: PoppinsTextStyle.bold.copyWith(
          fontSize: 15,
          color: AppColor.primaryColor,
        ),
      ),
      onDone: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => WelcomeScreen()),
        );
      },
      dotsDecorator: DotsDecorator(
        size: Size(10.0, 10.0),
        color: Colors.grey,
        activeColor: AppColor.primaryColor,
        activeSize: Size(15.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.0),
        ),
      ),
    );
  }
}
