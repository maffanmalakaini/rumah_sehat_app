// Mengimpor library untuk konversi data JSON
import 'dart:convert';
// Mengimpor library http untuk request API ke backend
import 'package:http/http.dart' as http;

class ApiService {
  // IP Server backend (10.0.2.2 untuk Android Emulator, 127.0.0.1 untuk iOS/Web)
  static const String baseUrl = 'http://10.0.2.2:8000/api';

  // 1. Fungsi Login
  static Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    return {'statusCode': response.statusCode, 'data': jsonDecode(response.body)};
  }

  // 2. Fungsi Register
  static Future<Map<String, dynamic>> register(String name, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': name, 'email': email, 'password': password}),
    );
    return {'statusCode': response.statusCode, 'data': jsonDecode(response.body)};
  }

  // 3. Fungsi Ambil Data Info Poli
  static Future<List<dynamic>> getPolis(int branchId) async {
    final response = await http.get(Uri.parse('$baseUrl/branches/$branchId/polis'));
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return body['data'];
    }
    return [];
  }

  // 4. Fungsi Ambil Data Bed / Kamar
  static Future<List<dynamic>> getBeds(int branchId) async {
    final response = await http.get(Uri.parse('$baseUrl/branches/$branchId/beds'));
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return body['data'];
    }
    return [];
  }

  // 5. Fungsi Ambil Kontak IGD
  static Future<Map<String, dynamic>?> getEmergency(int branchId) async {
    final response = await http.get(Uri.parse('$baseUrl/branches/$branchId/emergency'));
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return body['data'];
    }
    return null;
  }

  // 6. Fungsi Ambil Informasi Tentang Kami
  static Future<Map<String, dynamic>?> getHospitalInfo(int branchId) async {
    final response = await http.get(Uri.parse('$baseUrl/branches/$branchId/info'));
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return body['data'];
    }
    return null;
  }

  // 7. Fungsi Ambil Riwayat Transaksi
  static Future<List<dynamic>> getTransactions(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/users/$userId/transactions'));
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return body['data'];
    }
    return [];
  }
}