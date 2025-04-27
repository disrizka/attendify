import 'package:attendify/pages/auth/models/history_model.dart';
import 'package:attendify/pages/auth/service/auth_service.dart';
import 'package:attendify/pages/main/screens/bottom_navigation_bar.dart';
import 'package:attendify/service/pref_handler.dart';
import 'package:attendify/utils/constant/app_color.dart';
import 'package:attendify/utils/constant/app_font.dart';
import 'package:attendify/utils/constant/app_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<Datum> _historyList = [];
  bool _isLoading = true;
  Map<String, List<Datum>> _groupedHistory = {};

  @override
  void initState() {
    super.initState();
    _initializeLocale();
  }

  Future<void> _initializeLocale() async {
    await initializeDateFormatting('id_ID', null);
    fetchHistory();
  }

  Future<void> fetchHistory() async {
    final userId = await PreferenceHandler.getId();
    final token = await PreferenceHandler.getToken();
    if (userId != null && token != null) {
      try {
        final historyResponse = await AuthService().getHistory(
          userId: userId,
          token: token,
        );

        final Map<String, List<Datum>> grouped = {};
        for (var item in historyResponse.data ?? []) {
          if (item.checkIn != null) {
            final dateStr = DateFormat(
              'EEEE, d MMMM yyyy',
              'id_ID',
            ).format(item.checkIn!);
            grouped.putIfAbsent(dateStr, () => []).add(item);
          }
        }

        setState(() {
          _historyList = historyResponse.data ?? [];
          _groupedHistory = grouped;
          _isLoading = false;
        });
      } catch (e) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Gagal ambil data: $e")));
      }
    }
  }

  

  Future<void> _deleteAbsen(int? absenId) async {
    if (absenId == null) return;
    final token = await PreferenceHandler.getToken();
    if (token == null) return;

    final confirm = await showDialog<bool>(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: Text(
              'Hapus Absensi',
              style: PoppinsTextStyle.semiBold.copyWith(fontSize: 18),
            ),
            content: Text(
              'Apakah kamu yakin ingin menghapus absensi ini?',
              style: PoppinsTextStyle.regular.copyWith(fontSize: 14),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: Text(
                  'Batal',
                  style: PoppinsTextStyle.medium.copyWith(color: Colors.grey),
                ),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  foregroundColor: Colors.white,
                ),
                child: Text('Hapus', style: PoppinsTextStyle.medium),
              ),
            ],
          ),
    );

   if (confirm == true) {
  try {
    final res = await AuthService().deleteAbsen(
      absenId: absenId,
      token: token,
    );

    _showElegantSnackBar(res.message ?? 'Berhasil menghapus absen'); // ✅ pakai elegant snackbar
    await fetchHistory();
  } catch (e) {
    _showElegantSnackBar(e.toString().replaceFirst('Exception: ', '')); // ✅ pakai elegant snackbar
  }
}


    
  }
void _showElegantSnackBar(String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          const Icon(Icons.info_outline, color: Colors.white),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.black87,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      duration: const Duration(seconds: 3),
    ),
  );
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'History',
          style: PoppinsTextStyle.bold.copyWith(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BottomBar()),
            );
          },
        ),
      ),
      body: Column(
        children: [
          _buildHistoryInfoBox(),
          const SizedBox(height: 16),
          Expanded(
            child:
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _historyList.isEmpty
                    ? const Center(child: Text("Tidak ada riwayat absensi."))
                    : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: _groupedHistory.keys.length,
                      itemBuilder: (context, index) {
                        final date = _groupedHistory.keys.elementAt(index);
                        final items = _groupedHistory[date]!;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: Text(
                                date,
                                style: PoppinsTextStyle.bold.copyWith(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            ...items.map((item) => _buildHistoryItem(item)),
                            const SizedBox(height: 8),
                          ],
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(Datum item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (item.checkIn != null && item.status == 'masuk')
          _buildItemRow(
            icon: Icons.login,
            iconColor: Colors.green,
            label: 'Check In',
            time: _formatTime(item.checkIn),
            address: item.checkInAddress ?? "-",
            id: item.id,
          ),
        if (item.checkOut != null)
          _buildItemRow(
            icon: Icons.logout,
            iconColor: Colors.red,
            label: 'Check Out',
            time: _formatTime(item.checkOut),
            address: item.checkOutAddress ?? "-",
            id: item.id,
          ),
        if (item.status == 'izin')
          _buildItemRow(
            icon: Icons.info_outline,
            iconColor: Colors.orange,
            label: 'Izin',
            time: item.alasanIzin ?? "-",
            address:
                item.checkInAddress ??
                "-", // biasanya izin juga ada lokasi izin
            id: item.id,
          ),
      ],
    );
  }

  Widget _buildItemRow({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String time,
    required String address,
    required int? id,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start, // supaya jam dan alamat bisa vertikal
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: PoppinsTextStyle.semiBold.copyWith(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                Text(
                  time,
                  style: PoppinsTextStyle.regular.copyWith(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  address,
                  maxLines: 2,
                  style: PoppinsTextStyle.regular.copyWith(
                    fontSize: 11,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () => _deleteAbsen(id),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime? dt) {
    if (dt == null) return "-";
    return DateFormat.Hm().format(dt);
  }

  Widget _buildHistoryInfoBox() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(AppImage.historyImage, width: 145, height: 93),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: AppColor.primaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Cek History mu disini",
                    style: PoppinsTextStyle.bold.copyWith(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Tinggalkan kebiasaan telat kamu yaa, dan tetap semangat!",
                    style: PoppinsTextStyle.regular.copyWith(
                      fontSize: 10,
                      color: Colors.white,
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
