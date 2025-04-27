import 'package:flutter/material.dart';
import 'package:attendify/utils/constant/app_color.dart';
import 'package:attendify/utils/constant/app_font.dart';

class VersionScreen extends StatelessWidget {
  const VersionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColor.backgroundColor,
        elevation: 0.5,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Versi Aplikasi",
          style: PoppinsTextStyle.bold.copyWith(fontSize: 20, color: Colors.black),
        ),
      ),
      body: Center(
        child: Card(
         
          elevation: 2,
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.verified,
                  size: 60,
                  color: AppColor.primaryColor,
                ),
                const SizedBox(height: 20),
                Text(
                  "Attendify",
                  style: PoppinsTextStyle.bold.copyWith(fontSize: 22),
                ),
                const SizedBox(height: 8),
                Text(
                  "Versi 1.0.0",
                  style: PoppinsTextStyle.medium.copyWith(fontSize: 16, color: Colors.grey.shade700),
                ),
                const SizedBox(height: 12),
                Text(
                  "Build Date: April 2025",
                  style: PoppinsTextStyle.regular.copyWith(fontSize: 13, color: Colors.grey.shade500),
                ),
                const SizedBox(height: 20),
                Text(
                  "Terima kasih telah menggunakan Attendify untuk mencatat absensi Anda dengan lebih mudah dan aman.",
                  textAlign: TextAlign.center,
                  style: PoppinsTextStyle.regular.copyWith(fontSize: 14, color: Colors.black87),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
