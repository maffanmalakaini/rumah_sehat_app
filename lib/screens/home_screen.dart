import 'package:flutter/material.dart';
import 'profile_screen.dart';
import 'transaksi_screen.dart';

class HomeScreen extends StatefulWidget {
  final String userName;
  final String userEmail;

  const HomeScreen({
    super.key,
    this.userName = 'User',
    this.userEmail = 'user@gmail.com',
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 1; // Default ke tab Home

  @override
  Widget build(BuildContext context) {
    // Navigasi Tab dengan Navbar yang Tetap Muncul
    final List<Widget> pages = [
      const TransaksiScreen(),
      _buildHomeContent(context),
      ProfileScreen(
        userName: widget.userName,
        userEmail: widget.userEmail,
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: _selectedIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF1E70EB),
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long, size: 28),
            label: 'Transaksi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_rounded, size: 36),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 28),
            label: 'Profil',
          ),
        ],
      ),
    );
  }

  Widget _buildHomeContent(BuildContext context) {
    String selectedBranch = 'RUMAH SEHAT, JAKARTA PUSAT';
    final List<String> branches = [
      'RUMAH SEHAT, JAKARTA PUSAT',
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Row(
          children: [
            Icon(Icons.add_box_rounded, color: Color(0xFF0066FF), size: 28),
            SizedBox(width: 8),
            Text(
              'RUMAH SEHAT MOBILE',
              style: TextStyle(
                color: Color(0xFF0066FF),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              color: const Color(0xFF1E70EB),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Selamat Datang,',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Text(
                    'Hi, ${widget.userName}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Silahkan pilih cabang Rumah Sehat terlebih dahulu',
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  ),
                  const SizedBox(height: 12),
                  StatefulBuilder(
                    builder: (context, setStateDropdown) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedBranch,
                            isExpanded: true,
                            icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF1E70EB)),
                            style: const TextStyle(
                              color: Color(0xFF1E70EB),
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                            items: branches.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setStateDropdown(() {
                                selectedBranch = newValue!;
                              });
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.1,
                children: [
                  _buildMenuItem(
                    icon: Icons.local_hospital_outlined,
                    label: 'Info Poli',
                    onTap: () => Navigator.pushNamed(context, '/info-poli'),
                  ),
                  _buildMenuItem(
                    icon: Icons.medication_outlined,
                    label: 'Resep Obat',
                    onTap: () {},
                  ),
                  _buildMenuItem(
                    icon: Icons.airport_shuttle_outlined,
                    label: 'IGD',
                    onTap: () => Navigator.pushNamed(context, '/igd'),
                  ),
                  _buildMenuItem(
                    icon: Icons.calendar_month_outlined,
                    label: 'Atur Jadwal',
                    onTap: () {},
                  ),
                  _buildMenuItem(
                    icon: Icons.single_bed_outlined,
                    label: 'Info Bed',
                    onTap: () => Navigator.pushNamed(context, '/info-bed'),
                  ),
                  _buildMenuItem(
                    icon: Icons.domain_outlined,
                    label: 'Tentang Kami',
                    onTap: () => Navigator.pushNamed(context, '/tentang-kami'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: const Color(0xFF1E70EB)),
            const SizedBox(height: 10),
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}