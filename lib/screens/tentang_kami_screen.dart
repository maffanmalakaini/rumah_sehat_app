import 'package:flutter/material.dart';
import '../services/api_service.dart';

class TentangKamiScreen extends StatefulWidget {
  const TentangKamiScreen({super.key});

  @override
  State<TentangKamiScreen> createState() => _TentangKamiScreenState();
}

class _TentangKamiScreenState extends State<TentangKamiScreen> {
  Map<String, dynamic>? _info;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchInfo();
  }

  void _fetchInfo() async {
    final data = await ApiService.getHospitalInfo(1);
    setState(() {
      _info = data;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tentang Kami'),
        backgroundColor: const Color(0xFF0066FF),
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      _info?['branch_name'] ?? 'Rumah Sehat',
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF0066FF)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildDetailRow('Alamat', _info?['address']),
                  _buildDetailRow('Email', _info?['email']),
                  _buildDetailRow('Kelas Rumah Sakit', _info?['class_type'] != null ? 'Kelas ${_info!['class_type']}' : '-'),
                  _buildDetailRow('Akreditasi', _info?['accreditation']),
                ],
              ),
            ),
    );
  }

  Widget _buildDetailRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
          const SizedBox(height: 4),
          Text(value ?? '-', style: const TextStyle(fontSize: 16)),
          const Divider(),
        ],
      ),
    );
  }
}