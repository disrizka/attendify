import 'package:attendify/pages/auth/screens/register/screen/register_screen.dart';
import 'package:attendify/pages/main/screens/bottom_navigation_bar.dart';
import 'package:attendify/utils/constant/app_color.dart';
import 'package:attendify/utils/constant/app_font.dart';
import 'package:attendify/utils/constant/app_image.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Welcome Text
              Text(
                "Welcome back \nagain! Attendify \nto see you, Again!",
                textAlign: TextAlign.left,
                style: PoppinsTextStyle.bold.copyWith(fontSize: 30),
              ),
              const SizedBox(height: 50),

              // Email Field
              TextField(
                decoration: InputDecoration(
                  hintText: "email",
                  hintStyle: PoppinsTextStyle.regular.copyWith(
                    color: Colors.grey[600],
                    fontSize: 13,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Password Field
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Password",
                  hintStyle: PoppinsTextStyle.regular.copyWith(
                    color: Colors.grey[600],
                    fontSize: 13,
                  ),
                  suffixIcon: Icon(Icons.visibility),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 70),

              // Login Button
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
                    MaterialPageRoute(builder: (context) => BottomBar()),
                  );
                },
                child: Text(
                  "Login",
                  style: PoppinsTextStyle.bold.copyWith(fontSize: 16),
                ),
              ),
              const SizedBox(height: 20),

              // Or login with
              Row(
                children: [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "Or login with",
                      style: PoppinsTextStyle.regular.copyWith(
                        color: Colors.grey[600],
                        fontSize: 13,
                      ),
                    ),
                  ),
                  const Expanded(child: Divider()),
                ],
              ),
              const SizedBox(height: 20),

              // Social Media Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Facebook
                  IconButton(
                    icon: Image.asset(AppImage.facebook),
                    iconSize: 40,
                    onPressed: () {
                      // Aksi Login dengan Facebook
                    },
                  ),
                  const SizedBox(width: 30),
                  // Google
                  IconButton(
                    icon: Image.asset(AppImage.google),
                    iconSize: 40,
                    onPressed: () {
                      // Aksi Login dengan Google
                    },
                  ),
                  const SizedBox(width: 30),
                  // Apple
                  IconButton(
                    icon: Image.asset(AppImage.apple),
                    iconSize: 40,
                    onPressed: () {
                      // Aksi Login dengan Apple
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Register Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: PoppinsTextStyle.regular.copyWith(
                      color: Colors.grey[600],
                      fontSize: 13,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterScreen(),
                        ),
                      );
                    },
                    child: Text(
                      "Register here",
                      style: PoppinsTextStyle.bold.copyWith(
                        color: AppColor.tertiaryColor,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
