import 'dart:async';
import 'dart:io';
import 'package:attendify/pages/auth/service/auth_service.dart';
import 'package:attendify/service/geo_service.dart';
import 'package:attendify/service/pref_handler.dart';
import 'package:attendify/utils/constant/app_color.dart';
import 'package:attendify/utils/constant/app_font.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class IzinScreen extends StatefulWidget {
  const IzinScreen({super.key});

  @override
  State<IzinScreen> createState() => _IzinScreenState();
}

class _IzinScreenState extends State<IzinScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  final TextEditingController _alasanController = TextEditingController();
  bool _isLoading = true;
  String _currentAddress = "Memuat lokasi...";
  double _currentLat = 0;
  double _currentLong = 0;

  @override
  void initState() {
    super.initState();
    _fetchLocation();
  }

  Future<void> _fetchLocation() async {
    try {
      final pos = await determineUserLocation();
      final placemarks = await placemarkFromCoordinates(
        pos.latitude,
        pos.longitude,
      );
      final place = placemarks.first;

      setState(() {
        _currentLat = pos.latitude;
        _currentLong = pos.longitude;
        _currentAddress =
            "${place.street}, ${place.locality}, ${place.administrativeArea}";
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _currentAddress = "Gagal memuat lokasi";
        _isLoading = false;
      });
    }
  }

  Future<void> _submitIzin() async {
    final userId = await PreferenceHandler.getId();
    final token = await PreferenceHandler.getToken();

    if (_alasanController.text.trim().isEmpty) {
      _showElegantSnackBar("Alasan tidak boleh kosong", isError: true);
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await AuthService().izin(
        lat: _currentLat,
        lng: _currentLong,
        address: _currentAddress,
        alasan: _alasanController.text.trim(),
        token: token!,
      );

      setState(() {
        _isLoading = false;
      });

      _showElegantSnackBar(response.message ?? "Izin berhasil", isError: false);
      Navigator.pop(context, true);
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      _showElegantSnackBar(
        "Gagal mengirim izin: ${e.toString().replaceFirst('Exception: ', '')}",
        isError: true,
      );
    }
  }

  void _showElegantSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              isError ? Icons.error_outline : Icons.check_circle_outline,
              color: Colors.white,
            ),
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
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColor.backgroundColor,
        elevation: 0,
        title: Text(
          'Pengajuan Izin',
          style: PoppinsTextStyle.bold.copyWith(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Lokasi Card
                  _buildLocationCard(),

                  const SizedBox(height: 24),

                  // Alasan TextField
                  _buildReasonInput(),

                  const SizedBox(height: 170),

                  // Submit Button
                  _buildSubmitButton(),

                  const SizedBox(height: 16),

                  // Info Text
                  _buildInfoText(),
                ],
              ),
            ),
    );
  }

  Widget _buildLocationCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Lokasi Anda',
            style: PoppinsTextStyle.semiBold.copyWith(
              fontSize: 16,
              color: AppColor.primaryColor,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColor.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.location_on,
                  color: AppColor.primaryColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  _currentAddress,
                  style: PoppinsTextStyle.medium.copyWith(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReasonInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Alasan Izin',
          style: PoppinsTextStyle.semiBold.copyWith(
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextField(
            controller: _alasanController,
            maxLines: 6,
            style: PoppinsTextStyle.regular.copyWith(fontSize: 14),
            decoration: InputDecoration(
              hintText: "Tulis alasan izin kamu di sini...",
              hintStyle: PoppinsTextStyle.regular.copyWith(
                fontSize: 14,
                color: Colors.grey,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.all(16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: _submitIzin,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.primaryColor,
          foregroundColor: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.send_rounded),
            const SizedBox(width: 10),
            Text(
              "Kirim Pengajuan",
              style: PoppinsTextStyle.semiBold.copyWith(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Center(
        child: Text(
          "Pengajuan izin akan dikirim.",
          textAlign: TextAlign.center,
          style: PoppinsTextStyle.regular.copyWith(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
