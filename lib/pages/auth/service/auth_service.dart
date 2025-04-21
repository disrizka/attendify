import 'dart:convert';
import 'package:attendify/api/endpoint.dart';
import 'package:attendify/models/delete_model.dart';
import 'package:attendify/models/izin_model.dart';
import 'package:attendify/pages/auth/models/edit_profile_model.dart';
import 'package:attendify/pages/auth/models/history_model.dart';
import 'package:attendify/pages/auth/models/login_model.dart';
import 'package:attendify/pages/auth/models/register_model.dart';
import 'package:http/http.dart' as http;

class AuthService {
  Future<RegisterResponse> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('${Endpoint.baseUrlApi}/api/register'),
      headers: {'Accept': 'application/json'},
      body: {'name': name, 'email': email, 'password': password},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return RegisterResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(
        'Gagal registrasi: ${jsonDecode(response.body)['message']}',
      );
    }
  }

  Future<LoginResponse> login({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('${Endpoint.baseUrlApi}/api/login'),
      headers: {'Accept': 'application/json'},
      body: {'email': email, 'password': password},
    );
    print(response.body);
    if (response.statusCode == 200) {
      return LoginResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(jsonDecode(response.body)['message'] ?? 'Login gagal');
    }
  }

  Future<Map<String, dynamic>> checkin({
    required double lat,
    required double lng,
    required String address,
    required String? token,
  }) async {
    final url = Uri.parse('${Endpoint.baseUrlApi}/api/absen/check-in');

    final response = await http.post(
      url,
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
      body: ({
        "check_in_lat": "$lat",
        "check_in_lng": "$lng",
        "check_in_location": "$lat, $lng",
        "check_in_address": address,
      }),
    );

    print("STATUS CODE: ${response.statusCode}");
    print("BODY: ${response.body}");

    if (response.statusCode == 200) {
      try {
        return jsonDecode(response.body);
      } catch (e) {
        throw Exception("Format JSON tidak valid: $e");
      }
    } else {
      throw Exception("${jsonDecode(response.body)["message"]}");
    }
  }

  Future<Map<String, dynamic>> checkout({
    required double lat,
    required double lng,
    required String address,
    required String? token,
  }) async {
    final url = Uri.parse('${Endpoint.baseUrlApi}/api/absen/check-out');

    final response = await http.post(
      url,
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
      body: ({
        "check_out_lat": "$lat",
        "check_out_lng": "$lng",
        "check_out_location": "$lat, $lng",
        "check_out_address": address,
      }),
    );

    print("STATUS CODE: ${response.statusCode}");
    print("BODY: ${response.body}");

    if (response.statusCode == 200) {
      try {
        return jsonDecode(response.body);
      } catch (e) {
        throw Exception("Format JSON tidak valid: $e");
      }
    } else {
      throw Exception("${jsonDecode(response.body)["message"]}");
    }
  }

  Future<HistoryResponse> getHistory({
    required int userId,
    required String token,
    String? startDate,
    String? endDate,
  }) async {
    String url = '${Endpoint.baseUrlApi}/api/absen/history?user_id=$userId';

    // Tambahkan parameter start & end jika tersedia
    if (startDate != null && endDate != null) {
      url += '&start=$startDate&end=$endDate';
    }

    final response = await http.get(
      Uri.parse(url),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return HistoryResponse.fromJson(jsonDecode(response.body));
    } else {
      final Map<String, dynamic> error = jsonDecode(response.body);
      throw Exception(error['message'] ?? 'Gagal mengambil riwayat');
    }
  }

  Future<Map<String, dynamic>> getProfile(String? token) async {
    final response = await http.get(
      Uri.parse('${Endpoint.baseUrlApi}/api/profile'),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return jsonData['data'];
    } else {
      throw Exception("Gagal ambil profil: ${response.body}");
    }
  }

  Future<EditProfileResponse> editProfile({
    required String name,
    required String email,
    required String? token,
  }) async {
    final url = Uri.parse('${Endpoint.baseUrlApi}/api/profile');
    final response = await http.put(
      url,
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
      body: ({'name': name, 'email': email}),
    );

    if (response.statusCode == 200) {
      return EditProfileResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Gagal mengupdate profil");
    }
  }

  Future<IzinResponse> izin({
    required double lat,
    required double lng,
    required String address,
    required String alasan,
    required String token,
  }) async {
    final url = Uri.parse('${Endpoint.baseUrlApi}/api/absen/check-in');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'check_in_lat': lat,
        'check_in_lng': lng,
        'check_in_address': address,
        "status": "izin",
        'alasan_izin': alasan,
      }),
    );

    if (response.statusCode == 200) {
      return IzinResponse.fromJson(jsonDecode(response.body));
    } else {
      final Map<String, dynamic> error = jsonDecode(response.body);
      throw Exception(error['message'] ?? 'Gagal mengirim izin');
    }
  }

  Future<DeleteabsenResponse> deleteAbsen({
    required int absenId,
    required String token,
  }) async {
    final url = Uri.parse('${Endpoint.baseUrlApi}/api/absen/$absenId');

    final response = await http.delete(
      url,
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );

    final Map<String, dynamic> body = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return DeleteabsenResponse.fromJson(body);
    } else {
      throw Exception(body['message']);
    }
  }
}
