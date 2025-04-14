import 'package:attendify/utils/constant/app_color.dart';
import 'package:attendify/utils/constant/app_font.dart';
import 'package:attendify/utils/constant/app_image.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColor.backgroundColor,
        title: Text(
          'History',
          style: PoppinsTextStyle.bold.copyWith(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          // History Box (selalu di atas)
          _buildHistoryInfoBox(),
          // Konten scrollable di bawah
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: const [
                  // Tambahkan konten lain di sini
                  Text("Ini isi scrollable..."),
                  SizedBox(height: 800), // Contoh panjang biar bisa scroll
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryInfoBox() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gambar di sebelah kiri
          Image.asset(AppImage.historyImage, width: 129, height: 89),
          SizedBox(width: 25),
          // Box di sebelah kanan
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColor.primaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Cek History mu disini",
                    style: PoppinsTextStyle.bold.copyWith(
                      fontSize: 16,
                      color: AppColor.backgroundColor,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Tinggalkan kebiasaan telat kamu \nyaa, dan tetap semangat!",
                    style: PoppinsTextStyle.regular.copyWith(
                      fontSize: 8,
                      color: AppColor.backgroundColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
