import 'package:flutter/material.dart';
import 'package:attendify/utils/constant/app_color.dart';
import 'package:attendify/utils/constant/app_font.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

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
          "Kebijakan Privasi",
          style: PoppinsTextStyle.bold.copyWith(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Kebijakan Privasi Presind",
              style: PoppinsTextStyle.bold.copyWith(
                fontSize: 24,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Kami menghargai privasi Anda. Halaman ini menjelaskan bagaimana kami mengelola dan melindungi informasi pribadi Anda di aplikasi Presind.",
              style: PoppinsTextStyle.regular.copyWith(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 24),
            _buildPolicyItem(
              title: "Pengumpulan Data",
              description:
                  "Kami mengumpulkan informasi yang Anda berikan saat mendaftar, seperti nama, email, serta data absensi Anda untuk kebutuhan operasional aplikasi.",
              icon: Icons.cloud_upload_outlined,
              iconColor: Colors.blueAccent,
            ),
            const SizedBox(height: 16),
            _buildPolicyItem(
              title: "Penggunaan Data",
              description:
                  "Data Anda digunakan untuk memproses absensi, menampilkan laporan kehadiran, serta meningkatkan layanan kami.",
              icon: Icons.data_usage_outlined,
              iconColor: Colors.green,
            ),
            const SizedBox(height: 16),
            _buildPolicyItem(
              title: "Keamanan Data",
              description:
                  "Kami menerapkan enkripsi dan langkah-langkah keamanan ketat untuk menjaga informasi Anda dari akses tidak sah.",
              icon: Icons.lock_outline,
              iconColor: Colors.deepPurpleAccent,
            ),
            const SizedBox(height: 16),
            _buildPolicyItem(
              title: "Hak Anda",
              description:
                  "Anda dapat mengakses, memperbarui, atau menghapus informasi pribadi Anda kapan saja melalui pengaturan aplikasi.",
              icon: Icons.security_update_good_outlined,
              iconColor: Colors.orangeAccent,
            ),
            const SizedBox(height: 32),
            Center(
              child: Text(
                "Terakhir diperbarui: April 2025",
                style: PoppinsTextStyle.regular.copyWith(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPolicyItem({
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
