import 'package:flutter/material.dart';
import '../services/api_service.dart';

class InfoBedScreen extends StatefulWidget {
  const InfoBedScreen({super.key});

  @override
  State<InfoBedScreen> createState() => _InfoBedScreenState();
}

class _InfoBedScreenState extends State<InfoBedScreen> {
  List<dynamic> _beds = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchBeds();
  }

  void _fetchBeds() async {
    final data = await ApiService.getBeds(1);
    setState(() {
      _beds = data;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Info Kamar / Bed'),
        backgroundColor: const Color(0xFF0066FF),
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _beds.length,
              itemBuilder: (context, index) {
                final item = _beds[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: const Icon(Icons.single_bed, color: Color(0xFF0066FF), size: 36),
                    title: Text(item['room_type'] ?? '-', style: const TextStyle(fontWeight: FontWeight.bold)),
                    trailing: Text(
                      '${item['total_beds'] ?? 0} Bed Tersedia',
                      style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              },
            ),
    );
  }
}