import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:attendify/utils/constant/app_color.dart';
import 'package:attendify/utils/constant/app_font.dart';
import 'package:attendify/utils/constant/app_image.dart';
import 'package:attendify/pages/auth/service/auth_service.dart';
import 'package:attendify/service/pref_handler.dart';
import 'package:attendify/pages/auth/models/history_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = "Loading...";
  String email = "Loading...";
  DateTime? selectedDate;
  List<Datum> historyList = [];
  bool isLoadingHistory = false;

  @override
  void initState() {
    super.initState();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    try {
      final token = await PreferenceHandler.getToken();
      final data = await AuthService().getProfile(token);
      setState(() {
        name = data['name'] ?? '-';
        email = data['email'] ?? '-';
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memuat profile: $e')),
      );
    }
  }

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
      fetchHistoryByDate(picked);
    }
  }

  Future<void> fetchHistoryByDate(DateTime date) async {
    setState(() => isLoadingHistory = true);
    final userId = await PreferenceHandler.getId();
    final token = await PreferenceHandler.getToken();
    if (userId != null && token != null) {
      try {
        final historyResponse = await AuthService().getHistory(
          userId: userId,
          token: token,
        );

        final filtered = (historyResponse.data ?? []).where((item) {
          if (item.status == 'izin') {
            return item.checkIn != null &&
                item.checkIn!.year == date.year &&
                item.checkIn!.month == date.month &&
                item.checkIn!.day == date.day;
          } else {
            final checkInMatch = item.checkIn != null &&
                item.checkIn!.year == date.year &&
                item.checkIn!.month == date.month &&
                item.checkIn!.day == date.day;
            final checkOutMatch = item.checkOut != null &&
                item.checkOut!.year == date.year &&
                item.checkOut!.month == date.month &&
                item.checkOut!.day == date.day;
            return checkInMatch || checkOutMatch;
          }
        }).toList();

        setState(() {
          historyList = filtered;
          isLoadingHistory = false;
        });
      } catch (e) {
        setState(() => isLoadingHistory = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal mengambil history: $e')),
        );
      }
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return "-";
    return DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(date);
  }

  String _formatTime(DateTime? dateTime) {
    if (dateTime == null) return "-";
    return DateFormat.Hm().format(dateTime);
  }

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
          "Akun Saya",
          style: PoppinsTextStyle.bold.copyWith(fontSize: 20, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey[800],
                backgroundImage: AssetImage(AppImage.demoUser),
              ),
              const SizedBox(height: 16),
              Text(
                name,
                style: PoppinsTextStyle.bold.copyWith(fontSize: 20),
              ),
              const SizedBox(height: 4),
              Text(
                email,
                style: PoppinsTextStyle.regular.copyWith(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _pickDate,
                icon: Icon(Icons.calendar_today, color: AppColor.backgroundColor),
                label: Text("Pilih Tanggal History"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              if (selectedDate != null) ...[
                const SizedBox(height: 24),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "History untuk: ${_formatDate(selectedDate)}",
                    style: PoppinsTextStyle.semiBold.copyWith(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 16),
              ],
              if (isLoadingHistory)
                const Center(child: CircularProgressIndicator())
              else if (historyList.isEmpty && selectedDate != null)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      "Tidak ada absensi pada tanggal ini.",
                      style: PoppinsTextStyle.regular.copyWith(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                )
              else
                Column(
                  children: historyList.expand((item) {
                    List<Widget> entries = [];
          
                    if (item.status == 'izin') {
                      entries.add(_buildHistoryCard(
                        title: 'Izin',
                        time: item.alasanIzin ?? "-",
                        icon: Icons.info_outline,
                        color: Colors.orange,
                      ));
                    } else {
                      if (item.checkIn != null &&
                          _isSameDay(item.checkIn!, selectedDate!)) {
                        entries.add(_buildHistoryCard(
                          title: 'Check In',
                          time: _formatTime(item.checkIn),
                          icon: Icons.login,
                          color: Colors.green,
                        ));
                      }
                      if (item.checkOut != null &&
                          _isSameDay(item.checkOut!, selectedDate!)) {
                        entries.add(_buildHistoryCard(
                          title: 'Check Out',
                          time: _formatTime(item.checkOut),
                          icon: Icons.logout,
                          color: Colors.red,
                        ));
                      }
                    }
          
                    return entries;
                  }).toList(),
                ),
            ],
          ),
        ),
      ),
    );
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
           date1.month == date2.month &&
           date1.day == date2.day;
  }

  Widget _buildHistoryCard({
    required String title,
    required String time,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color,
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(
          title,
          style: PoppinsTextStyle.semiBold.copyWith(fontSize: 15),
        ),
        subtitle: Text(
          time,
          style: PoppinsTextStyle.regular.copyWith(
            fontSize: 13,
            color: Colors.grey[600],
          ),
        ),
      ),
    );
  }
}
