import 'dart:convert';

DeleteabsenResponse deleteabsenResponseFromJson(String str) =>
    DeleteabsenResponse.fromJson(json.decode(str));

String deleteabsenResponseToJson(DeleteabsenResponse data) =>
    json.encode(data.toJson());

class DeleteabsenResponse {
  final String? message;
  final Data? data;

  DeleteabsenResponse({this.message, this.data});

  factory DeleteabsenResponse.fromJson(Map<String, dynamic> json) =>
      DeleteabsenResponse(
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {"message": message, "data": data?.toJson()};
}

class Data {
  final int? id;
  final int? userId;
  final DateTime? checkIn;
  final String? checkInLocation;
  final String? checkInAddress;
  final dynamic checkOut;
  final dynamic checkOutLocation;
  final dynamic checkOutAddress;
  final String? status;
  final String? alasanIzin;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final double? checkInLat;
  final double? checkInLng;
  final dynamic checkOutLat;
  final dynamic checkOutLng;

  Data({
    this.id,
    this.userId,
    this.checkIn,
    this.checkInLocation,
    this.checkInAddress,
    this.checkOut,
    this.checkOutLocation,
    this.checkOutAddress,
    this.status,
    this.alasanIzin,
    this.createdAt,
    this.updatedAt,
    this.checkInLat,
    this.checkInLng,
    this.checkOutLat,
    this.checkOutLng,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    userId: json["user_id"],
    checkIn: json["check_in"] == null ? null : DateTime.parse(json["check_in"]),
    checkInLocation: json["check_in_location"],
    checkInAddress: json["check_in_address"],
    checkOut: json["check_out"],
    checkOutLocation: json["check_out_location"],
    checkOutAddress: json["check_out_address"],
    status: json["status"],
    alasanIzin: json["alasan_izin"],
    createdAt:
        json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt:
        json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    checkInLat: json["check_in_lat"]?.toDouble(),
    checkInLng: json["check_in_lng"]?.toDouble(),
    checkOutLat: json["check_out_lat"],
    checkOutLng: json["check_out_lng"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "check_in": checkIn?.toIso8601String(),
    "check_in_location": checkInLocation,
    "check_in_address": checkInAddress,
    "check_out": checkOut,
    "check_out_location": checkOutLocation,
    "check_out_address": checkOutAddress,
    "status": status,
    "alasan_izin": alasanIzin,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "check_in_lat": checkInLat,
    "check_in_lng": checkInLng,
    "check_out_lat": checkOutLat,
    "check_out_lng": checkOutLng,
  };
}
