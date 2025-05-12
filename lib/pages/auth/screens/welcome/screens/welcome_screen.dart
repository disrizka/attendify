import 'package:attendify/pages/auth/screens/login/screens/login_screen.dart';
import 'package:attendify/pages/auth/screens/register/screen/register_screen.dart';
import 'package:attendify/utils/constant/app_color.dart';
import 'package:attendify/utils/constant/app_font.dart';
import 'package:attendify/utils/constant/app_image.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Center(child: Image.asset(AppImage.logo, height: 264)),

            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 40, left: 20, right: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: AppColor.primaryColor),
                        foregroundColor: AppColor.primaryColor,
                        minimumSize: Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Daftar",
                        style: PoppinsTextStyle.bold.copyWith(fontSize: 16),
                      ),
                    ),
                    SizedBox(height: 15),

                    // Tombol Sign In (filled)
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primaryColor,
                        foregroundColor: AppColor.backgroundColor,
                        minimumSize: Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Masuk",
                        style: PoppinsTextStyle.bold.copyWith(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
