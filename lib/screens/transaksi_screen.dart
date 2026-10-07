// Mengimpor UI Flutter
import 'package:flutter/material.dart';
// Mengimpor ApiService untuk ambil data transaksi
import '../services/api_service.dart';

class TransaksiScreen extends StatefulWidget {
  const TransaksiScreen({super.key});

  @override
  State<TransaksiScreen> createState() => _TransaksiScreenState();
}

class _TransaksiScreenState extends State<TransaksiScreen> {
  // List penampung data riwayat transaksi pasien
  List<dynamic> _transactions = [];
  // Status penanda proses pemuatan data
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchTransactions(); // Panggil fungsi saat layar pertama dimuat
  }

  void _fetchTransactions() async {
    final data = await ApiService.getTransactions(1); // Ambil riwayat transaksi user ID 1
    setState(() {
      _transactions = data;
      _isLoading = false; // Matikan loading spinner
    });
  }

  // Fungsi penentu warna label status (Berhasil/Proses/Dibatalkan)
  Color _getStatusColor(String status) {
    if (status == 'Berhasil') return Colors.green;
    if (status == 'Proses') return Colors.orange;
    return Colors.red; // Status dibatalkan
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Transaksi'),
        backgroundColor: const Color(0xFF0066FF),
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator()) // Tampilkan animasi loading
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _transactions.length,
              itemBuilder: (context, index) {
                final item = _transactions[index];
                final status = item['status'] ?? 'Proses';
                
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: const Icon(Icons.receipt, color: Color(0xFF0066FF)),
                    // Aman dari crash jika data poli bernilai null
                    title: Text(item['poli']?['name'] ?? 'Poli Umum'),
                    subtitle: Text('Tanggal: ${item['date'] ?? '-'}'),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getStatusColor(status).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        status,
                        style: TextStyle(color: _getStatusColor(status), fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}