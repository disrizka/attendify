class IzinResponse {
  final String message;
  final IzinData? data;

  IzinResponse({required this.message, this.data});

  factory IzinResponse.fromJson(Map<String, dynamic> json) {
    return IzinResponse(
      message: json['message'],
      data: json['data'] != null ? IzinData.fromJson(json['data']) : null,
    );
  }
}

class IzinData {
  final int id;
  final int userId;
  final String checkIn;
  final String? checkOut;
  final String checkInLocation;
  final String? checkOutLocation;
  final String checkInAddress;
  final String? checkOutAddress;
  final String status;
  final String alasanIzin;

  IzinData({
    required this.id,
    required this.userId,
    required this.checkIn,
    this.checkOut,
    required this.checkInLocation,
    this.checkOutLocation,
    required this.checkInAddress,
    this.checkOutAddress,
    required this.status,
    required this.alasanIzin,
  });

  factory IzinData.fromJson(Map<String, dynamic> json) {
    return IzinData(
      id: json['id'],
      userId: json['user_id'],
      checkIn: json['check_in'],
      checkOut: json['check_out'],
      checkInLocation: json['check_in_location'],
      checkOutLocation: json['check_out_location'],
      checkInAddress: json['check_in_address'],
      checkOutAddress: json['check_out_address'],
      status: json['status'],
      alasanIzin: json['alasan_izin'],
    );
  }
}
