import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:attendify/pages/auth/screens/login/screens/login_screen.dart';
import 'package:attendify/pages/check-in/screens/checkin_screen.dart';
import 'package:attendify/pages/check-out/screens/checkout_screen.dart';
import 'package:attendify/pages/history/screens/history_screen.dart';
import 'package:attendify/pages/izin/screens/izin_screen.dart';
import 'package:attendify/utils/constant/app_color.dart';
import 'package:attendify/utils/constant/app_font.dart';
import 'package:attendify/utils/constant/app_image.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late DateTime now;
  Timer? _timer;

  final List<Map<String, dynamic>> features = [];
  List<Map<String, dynamic>> filteredFeatures = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    now = DateTime.now();

    features.addAll([
      {'title': 'Absen Masuk', 'icon': AppImage.checkin, 'screen': const CheckinScreen()},
      {'title': 'Absen Pulang', 'icon': AppImage.checkout, 'screen': const CheckoutScreen()},
      {'title': 'Riwayat', 'icon': AppImage.iconLemburin, 'screen': const HistoryScreen()},
      {'title': 'Ajukan Izin', 'icon': AppImage.iconIzin, 'screen': const IzinScreen()},
    ]);

    filteredFeatures = List.from(features);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        now = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _filterFeatures(String query) {
    final filtered = features.where((feature) {
      final titleLower = feature['title'].toLowerCase();
      final searchLower = query.toLowerCase();
      return titleLower.contains(searchLower);
    }).toList();

    setState(() {
      filteredFeatures = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    String formattedTime = DateFormat('HH:mm:ss').format(now);
    String formattedDate = DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(now);

    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColor.backgroundColor,
        elevation: 0,
        title: Text(
          'Presind',
          style: PoppinsTextStyle.bold.copyWith(fontSize: 20, color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const LoginScreen()),
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundColor: Colors.grey[800],
              child: Image.asset(AppImage.demoUser),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildSearchBox(),
                  const SizedBox(height: 24),
                  _buildLiveAttendance(formattedTime, formattedDate),
                  const SizedBox(height: 16),
                  _buildCheckButtons(),
                ],
              ),
            ),
            _buildSectionTitle("Lainnya"),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                height: 120,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: filteredFeatures.length,
                  separatorBuilder: (context, index) => const SizedBox(width: 20),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        if (filteredFeatures[index]['screen'] != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => filteredFeatures[index]['screen']),
                          );
                        }
                      },
                      child: SizedBox(
                        width: 80,
                        child: _buildFeatureItem(
                          filteredFeatures[index]['title'],
                          filteredFeatures[index]['icon'],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            _buildSectionTitle("Berita"),
            _buildNewsSection(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBox() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          const SizedBox(width: 20),
          Icon(Icons.search, color: AppColor.primaryColor),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: _searchController,
              onChanged: _filterFeatures,
              decoration: InputDecoration(
                hintText: 'Cari fitur di sini...',
                hintStyle: PoppinsTextStyle.regular.copyWith(
                  color: Colors.grey[600],
                  fontSize: 13,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLiveAttendance(String time, String date) {
    return Column(
      children: [
        Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                'Presensi Langsung',
                style: PoppinsTextStyle.semiBold.copyWith(fontSize: 16),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const HistoryScreen()));
                },
                child: const Padding(
                  padding: EdgeInsets.all(4),
                  child: Icon(Icons.access_time, color: AppColor.primaryColor),
                ),
              ),
            ),
          ],
        ),
        Center(
          child: Text(
            time,
            style: PoppinsTextStyle.bold.copyWith(fontSize: 32),
          ),
        ),
        Center(
          child: Text(
            date,
            style: PoppinsTextStyle.regular.copyWith(fontSize: 14, color: Colors.grey[600]),
          ),
        ),
      ],
    );
  }

  Widget _buildCheckButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CheckinScreen()),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.secondaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            child: Text("Absen Masuk", style: PoppinsTextStyle.semiBold.copyWith(color: Colors.white)),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CheckoutScreen()),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepOrange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            child: Text("Absen Pulang", style: PoppinsTextStyle.semiBold.copyWith(color: Colors.white)),
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureItem(String title, String iconAsset) {
    return Column(
      children: [
        Container(
          width: 70,
          height: 70,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 2,
              ),
            ],
          ),
          child: Image.asset(
            iconAsset,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.image, size: 40, color: Colors.grey),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          textAlign: TextAlign.center,
          style: PoppinsTextStyle.medium.copyWith(fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: PoppinsTextStyle.bold.copyWith(fontSize: 16)),
          const Icon(Icons.chevron_right),
        ],
      ),
    );
  }

  Widget _buildNewsSection() {
    List<Map<String, String>> newsItems = [
      {'title': 'Berita seputar virus Corona Hari ini', 'time': '2 jam yang lalu'},
      {'title': 'Berita seputar sidang DPR Hari ini', 'time': '2 jam yang lalu'},
      {'title': 'Update terbaru kebijakan perusahaan', 'time': '3 jam yang lalu'},
      {'title': 'Perubahan jadwal kerja mulai bulan depan', 'time': '4 jam yang lalu'},
      {'title': 'Tambahan berita penting hari ini', 'time': '4 jam yang lalu'},
    ];

    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: newsItems.length,
        itemBuilder: (context, index) {
          return Container(
            width: MediaQuery.of(context).size.width * 0.7,
            margin: const EdgeInsets.only(right: 16),
            child: _buildNewsCard(newsItems[index]['title']!, newsItems[index]['time']!),
          );
        },
      ),
    );
  }

  Widget _buildNewsCard(String title, String time) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 4,
          ),
        ],
      ),
      child: Stack(
        children: [
          Row(
            children: [
              Image.asset(
                AppImage.iconBerita,
                width: 80,
                height: 80,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.article, size: 40, color: Colors.grey),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: PoppinsTextStyle.bold.copyWith(fontSize: 14),
                ),
              ),
            ],
          ),
          Positioned(
            top: 6,
            right: 0,
            child: Text(
              time,
              style: PoppinsTextStyle.regular.copyWith(fontSize: 11, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}