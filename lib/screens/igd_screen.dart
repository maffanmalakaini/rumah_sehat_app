import 'package:flutter/material.dart';
import '../services/api_service.dart';

class IgdScreen extends StatefulWidget {
  const IgdScreen({super.key});

  @override
  State<IgdScreen> createState() => _IgdScreenState();
}

class _IgdScreenState extends State<IgdScreen> {
  Map<String, dynamic>? _emergency;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchEmergency();
  }

  void _fetchEmergency() async {
    final data = await ApiService.getEmergency(1);
    setState(() {
      _emergency = data;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kontak IGD 24 Jam'),
        backgroundColor: const Color(0xFF0066FF),
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(Icons.emergency, size: 80, color: Colors.red),
                  const SizedBox(height: 16),
                  const Text(
                    'Layanan Gawat Darurat',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
                  ),
                  const SizedBox(height: 24),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.phone, color: Color(0xFF0066FF)),
                      title: const Text('Telepon IGD'),
                      subtitle: Text(_emergency?['phone'] ?? '-'),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.chat, color: Colors.green),
                      title: const Text('WhatsApp IGD'),
                      subtitle: Text(_emergency?['whatsapp'] ?? '-'),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.location_on, color: Colors.orange),
                      title: const Text('Alamat'),
                      subtitle: Text(_emergency?['address'] ?? '-'),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}