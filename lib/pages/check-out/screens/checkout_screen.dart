import 'dart:async';
import 'dart:io';
import 'package:attendify/service/geo_service.dart';
import 'package:attendify/utils/constant/app_color.dart';
import 'package:attendify/utils/constant/app_font.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  bool _isLoading = true;

  String _currentAddress = "Unknown";
  double _currentLat = 0;
  double _currentLong = 0;
  String _note = "";

  @override
  void initState() {
    super.initState();
    _fetchLocation();
  }

  Future<void> _fetchLocation() async {
    setState(() => _isLoading = true);
    try {
      LatLng userLocation = await determineUserLocation();
      await _getAddressFromLatLng(userLocation);
    } catch (e) {
      print("Error fetching location: $e");
    }
    setState(() => _isLoading = false);
  }

  Future<void> _getAddressFromLatLng(LatLng position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        setState(() {
          _currentAddress =
              "${place.street}, ${place.subLocality}, ${place.locality}, ${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.country}, ${place.postalCode}";
          _currentLat = position.latitude;
          _currentLong = position.longitude;
        });
      }
    } catch (e) {
      print("Error reverse geocoding: $e");
    }
  }

  void _openAppSettings() async {
    await _geolocatorPlatform.openAppSettings();
  }

  void _openLocationSettings() async {
    await _geolocatorPlatform.openLocationSettings();
  }

  PopupMenuButton _createActions() {
    return PopupMenuButton(
      elevation: 40,
      onSelected: (value) {
        if (value == 1) _openAppSettings();
        if (value == 2) _openLocationSettings();
      },
      itemBuilder:
          (context) => [
            const PopupMenuItem(value: 1, child: Text("Open App Settings")),
            if (Platform.isAndroid || Platform.isWindows)
              const PopupMenuItem(
                value: 2,
                child: Text("Open Location Settings"),
              ),
          ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Stack(
                children: [
                  GoogleMap(
                    circles: {
                      Circle(
                        circleId: const CircleId("circle"),
                        center: LatLng(_currentLat, _currentLong),
                        radius: 5,
                        fillColor: AppColor.secondaryColor,
                        strokeWidth: 2,
                        strokeColor: AppColor.secondaryColor,
                      ),
                    },
                    myLocationEnabled: true,
                    mapType: MapType.normal,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(_currentLat, _currentLong),
                      zoom: 14.5,
                    ),
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                  ),

                  // FAB Kiri (Back)
                  Positioned(
                    top: MediaQuery.of(context).padding.top + 16,
                    left: 16,
                    child: SizedBox(
                      height: 40,
                      width: 40,
                      child: FloatingActionButton(
                        heroTag: "fab_back",
                        onPressed: () => Navigator.pop(context),
                        backgroundColor: AppColor.primaryColor,
                        shape:
                            const CircleBorder(), // memastikan bentuknya lingkaran
                        child: Icon(
                          Icons.arrow_back,
                          color: AppColor.backgroundColor,
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    top: MediaQuery.of(context).padding.top + 16,
                    right: 16,
                    child: SizedBox(
                      height: 40,
                      width: 40,
                      child: FloatingActionButton(
                        heroTag: "fab_refresh",
                        onPressed: _fetchLocation,
                        backgroundColor: AppColor.primaryColor,
                        shape: CircleBorder(),
                        child: Icon(
                          Icons.my_location,
                          color: AppColor.backgroundColor,
                        ),
                      ),
                    ),
                  ),

                  // Bottom Panel
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 30,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                            offset: const Offset(0, -5),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Check In",
                            style: PoppinsTextStyle.bold.copyWith(
                              fontSize: 20,
                              color: AppColor.primaryColor,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.location_pin,
                                color: Colors.orange,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  _currentAddress,
                                  style: PoppinsTextStyle.regular.copyWith(
                                    fontSize: 12,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            onChanged: (val) => _note = val,
                            decoration: InputDecoration(
                              hintText: "Note (optional)",
                              filled: true,
                              fillColor: Colors.grey[100],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            maxLines: 2,
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: 120,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColor.primaryColor,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              onPressed: () {
                                // TODO: Save check-in data
                                print("Check-In with note: $_note");
                                print("Location: $_currentAddress");
                              },
                              child: Text(
                                "Go",
                                style: PoppinsTextStyle.semiBold.copyWith(
                                  fontSize: 20,
                                  color: AppColor.backgroundColor,
                                ),
                              ),
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
