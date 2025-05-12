import 'package:flutter/material.dart';
import 'package:attendify/utils/constant/app_color.dart';
import 'package:attendify/utils/constant/app_font.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

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
          "Bantuan",
          style: PoppinsTextStyle.bold.copyWith(fontSize: 20, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Butuh bantuan?",
              style: PoppinsTextStyle.bold.copyWith(
                fontSize: 24,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Kami siap membantu Anda menyelesaikan masalah atau memahami aplikasi Presind lebih baik.",
              style: PoppinsTextStyle.regular.copyWith(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 24),
            _buildHelpItem(
              title: "Cara Menggunakan Aplikasi",
              description: "Login terlebih dahulu, lalu Anda dapat melakukan Check In, Check Out, lihat history, atau ajukan izin dengan mudah.",
              icon: Icons.app_registration,
              color: Colors.blueAccent,
            ),
            const SizedBox(height: 16),
            _buildHelpItem(
              title: "Lupa Check Out?",
              description: "Segera hubungi admin agar data absensi Anda bisa diperbaiki secepatnya.",
              icon: Icons.logout,
              color: Colors.orangeAccent,
            ),
            const SizedBox(height: 16),
            _buildHelpItem(
              title: "Edit Data Akun",
              description: "Masuk ke menu Settings > Edit Profile untuk memperbarui nama atau email Anda.",
              icon: Icons.manage_accounts,
              color: Colors.green,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHelpItem({
    required String title,
    required String description,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: color.withOpacity(0.15),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: PoppinsTextStyle.semiBold.copyWith(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: PoppinsTextStyle.regular.copyWith(
                    fontSize: 13,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
