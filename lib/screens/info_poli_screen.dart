// Mengimpor komponen UI Flutter
import 'package:flutter/material.dart';
// Mengimpor service API
import '../services/api_service.dart';

class InfoPoliScreen extends StatefulWidget {
  const InfoPoliScreen({super.key});

  @override
  State<InfoPoliScreen> createState() => _InfoPoliScreenState();
}

class _InfoPoliScreenState extends State<InfoPoliScreen> {
  // List data daftar poli
  List<dynamic> _polis = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchPolis(); // Ambil data saat halaman dibuka
  }

  void _fetchPolis() async {
    final data = await ApiService.getPolis(1); // Cabang ID 1
    setState(() {
      _polis = data;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Info Poli'),
        backgroundColor: const Color(0xFF0066FF),
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _polis.length,
              itemBuilder: (context, index) {
                final item = _polis[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: const Icon(Icons.medical_services, color: Color(0xFF0066FF)),
                    title: Text(item['name'] ?? '-', style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('Jam Operasional: ${item['operating_hours'] ?? '-'}'),
                  ),
                );
              },
            ),
    );
  }
}