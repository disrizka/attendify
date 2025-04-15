import 'package:attendify/pages/check-in/screens/checkin_screen.dart';
import 'package:attendify/pages/history/screens/history_screen.dart';
import 'package:attendify/utils/constant/app_color.dart';
import 'package:attendify/utils/constant/app_font.dart';
import 'package:attendify/utils/constant/app_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    String formattedTime = DateFormat('hh:mm a').format(now);
    String formattedDate = DateFormat('E, dd MMMM yyyy').format(now);

    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColor.backgroundColor,
        title: Text(
          'Attendify',
          style: PoppinsTextStyle.bold.copyWith(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.chevron_left), onPressed: () {}),
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
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(24.0),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 20),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.search, color: AppColor.primaryColor),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'search in here',
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
              ),

              const SizedBox(height: 24),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Live Attendance',
                        style: PoppinsTextStyle.semiBold.copyWith(
                          color: const Color.fromARGB(255, 0, 0, 0),
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HistoryScreen(),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(4),
                          child: Icon(
                            Icons.access_time,
                            color: AppColor.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Time and Date
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Center(
                  child: Text(
                    formattedTime,
                    style: PoppinsTextStyle.bold.copyWith(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      fontSize: 32,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Center(
                  child: Text(
                    formattedDate,
                    style: PoppinsTextStyle.regular.copyWith(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CheckinScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.secondaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: Text(
                          'Check in',
                          style: PoppinsTextStyle.semiBold.copyWith(
                            color: AppColor.backgroundColor,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepOrange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: Text(
                          'Check out',
                          style: PoppinsTextStyle.semiBold.copyWith(
                            color: AppColor.backgroundColor,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Lainnya',
                      style: PoppinsTextStyle.bold.copyWith(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        fontSize: 16,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.chevron_right),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: SizedBox(
                  height: 120,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      List<Map<String, dynamic>> features = [
                        {'title': 'Izin', 'icon': AppImage.iconIzin},
                        {'title': 'Tugas', 'icon': AppImage.iconTugas},
                        {'title': 'Lembur In', 'icon': AppImage.iconLemburin},
                        {'title': 'Lembur Out', 'icon': AppImage.iconLemburout},
                        {'title': 'Cek Absen', 'icon': AppImage.iconCekabsen},
                      ];

                      return Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: SizedBox(
                          width: 80,
                          child: _buildFeatureItem(
                            features[index]['title'],
                            features[index]['icon'],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Berita Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Berita',
                      style: PoppinsTextStyle.bold.copyWith(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        fontSize: 16,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.chevron_right),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),

              // News Cards - Horizontal Scrollable
              SizedBox(
                height: 150, // Fixed height for news cards
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  scrollDirection: Axis.horizontal,
                  itemCount: 4, // Number of news items
                  itemBuilder: (context, index) {
                    List<Map<String, String>> newsItems = [
                      {
                        'title': 'Berita seputar virus Corona Hari ini',
                        'time': '2 jam yang lalu',
                      },
                      {
                        'title': 'Berita seputar sidang DPR Hari ini',
                        'time': '2 jam yang lalu',
                      },
                      {
                        'title': 'Update terbaru kebijakan perusahaan',
                        'time': '3 jam yang lalu',
                      },
                      {
                        'title': 'Perubahan jadwal kerja mulai bulan depan',
                        'time': '4 jam yang lalu',
                      },
                    ];
                    return Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      margin: const EdgeInsets.only(right: 16),
                      child: _buildNewsCard(
                        newsItems[index]['title']!,
                        newsItems[index]['time']!,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }

  Widget _buildFeatureItem(String title, String iconAsset) {
    return Container(
      width: 80,
      margin: EdgeInsets.only(right: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Prevent vertical overflow
        children: [
          Container(
            width: 70,
            height: 70,
            padding: EdgeInsets.all(12),
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
              width: 40,
              height: 40,
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  _getIconForTitle(title),
                  size: 40,
                  color: Colors.blueGrey,
                );
              },
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            textAlign: TextAlign.center,
            style: PoppinsTextStyle.medium.copyWith(
              color: Color.fromARGB(255, 0, 0, 0),
              fontSize: 12,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  IconData _getIconForTitle(String title) {
    switch (title) {
      case 'Izin':
        return Icons.person;
      case 'Tugas':
        return Icons.assignment;
      case 'Lembur In':
        return Icons.access_time;
      case 'Lembur Out':
        return Icons.exit_to_app;
      case 'Cek Absen':
        return Icons.checklist;
      default:
        return Icons.apps;
    }
  }

  Widget _buildNewsCard(String title, String time) {
    return Container(
      padding: EdgeInsets.all(12),
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
          Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  AppImage.iconBerita,
                  width: 80,
                  height: 80,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.article,
                      size: 40,
                      color: Colors.blueGrey,
                    );
                  },
                ),
                SizedBox(height: 19),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 18),
                    child: Text(
                      title,
                      textAlign: TextAlign.right,
                      style: PoppinsTextStyle.bold.copyWith(
                        fontSize: 14,
                        color: const Color.fromARGB(255, 0, 0, 0),
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 6,
            right: 0,
            child: Text(
              time,
              style: PoppinsTextStyle.regular.copyWith(
                fontSize: 11,
                color: const Color.fromARGB(255, 182, 182, 182),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
