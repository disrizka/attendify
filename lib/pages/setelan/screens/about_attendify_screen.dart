import 'package:flutter/material.dart';
import 'package:attendify/utils/constant/app_color.dart';
import 'package:attendify/utils/constant/app_font.dart';

class AboutAttendifyScreen extends StatelessWidget {
  const AboutAttendifyScreen({super.key});

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
          "Tentang Attendify",
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
              "Selamat Datang di Attendify!",
              style: PoppinsTextStyle.bold.copyWith(
                fontSize: 24,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Attendify adalah solusi modern untuk manajemen absensi yang cepat, akurat, dan aman. "
              "Kami berkomitmen untuk memberikan pengalaman terbaik bagi pengguna dalam mencatat kehadiran, izin, dan laporan riwayat absensi.",
              style: PoppinsTextStyle.regular.copyWith(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 24),
            _buildAboutItem(
              title: "Misi Kami",
              description:
                  "Membantu perusahaan dan individu dalam mengelola kehadiran dengan mudah, "
                  "serta meningkatkan kedisiplinan dan produktivitas.",
              icon: Icons.flag_outlined,
              color: Colors.blueAccent,
            ),
            const SizedBox(height: 16),
            _buildAboutItem(
              title: "Visi Kami",
              description:
                  "Menjadi platform absensi digital terpercaya di berbagai sektor pendidikan, "
                  "perusahaan, dan komunitas global.",
              icon: Icons.visibility_outlined,
              color: Colors.green,
            ),
            const SizedBox(height: 16),
            _buildAboutItem(
              title: "Fitur Utama",
              description:
                  "• Check In & Check Out berbasis lokasi\n"
                  "• Riwayat absensi lengkap\n"
                  "• Izin kehadiran praktis\n"
                  "• Keamanan data terenkripsi",
              icon: Icons.star_border_rounded,
              color: Colors.orange,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutItem({
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
