import 'package:flutter/material.dart';
import 'package:attendify/utils/constant/app_color.dart';
import 'package:attendify/utils/constant/app_font.dart';

class PrivacySecurityScreen extends StatelessWidget {
  const PrivacySecurityScreen({super.key});

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
          "Privasi & Keamanan",
          style: PoppinsTextStyle.bold.copyWith(fontSize: 20, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Privasi dan Keamanan Anda adalah Prioritas Kami",
              style: PoppinsTextStyle.bold.copyWith(
                fontSize: 24,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Kami berkomitmen menjaga kerahasiaan dan keamanan data Anda saat menggunakan aplikasi Attendify.",
              style: PoppinsTextStyle.regular.copyWith(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 24),
            _buildInfoCard(
              title: "Kebijakan Privasi",
              description: "Kami menghargai privasi Anda. Data Anda disimpan dengan aman "
                  "dan tidak akan dibagikan kepada pihak ketiga tanpa persetujuan Anda.",
              icon: Icons.privacy_tip_outlined,
              iconColor: Colors.blueAccent,
            ),
            const SizedBox(height: 16),
            _buildInfoCard(
              title: "Keamanan Data",
              description: "Semua data absensi dan informasi akun Anda dienkripsi dan hanya dapat diakses oleh Anda. "
                  "Kami menggunakan teknologi terbaru untuk melindungi sistem dari akses tidak sah.",
              icon: Icons.security_outlined,
              iconColor: Colors.green,
            ),
            const SizedBox(height: 16),
            _buildInfoCard(
              title: "Kontrol Pengguna",
              description: "Anda memiliki kendali penuh atas akun Anda. "
                  "Perbarui informasi atau hapus akun Anda kapan saja melalui pengaturan.",
              icon: Icons.manage_accounts_outlined,
              iconColor: Colors.orange,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required String description,
    required IconData icon,
    required Color iconColor,
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
            backgroundColor: iconColor.withOpacity(0.15),
            child: Icon(icon, color: iconColor, size: 24),
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
