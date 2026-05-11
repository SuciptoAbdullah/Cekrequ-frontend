import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/paket.dart';
import 'galeri_page.dart';
import 'pesanan_page.dart';
import 'profil_page.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  final String token;

  const HomePage({super.key, required this.token});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  Map<String, dynamic>? userData;
  bool isLoading = true;

  final List<Paket> daftarPaket = [
    Paket(
      nama: "Foto Wedding",
      tempat: "Outdoor",
      warna: "Hitam",
      harga: 250000,
      gambar: "assets/image/Wedding.jpg",
    ),
    Paket(
      nama: "Foto Prewedding",
      tempat: "Outdoor",
      warna: "Hitam",
      harga: 300000,
      gambar: "assets/image/Prewed10.jpg",
    ),
    Paket(
      nama: "Foto Bayi Konsep",
      tempat: "Indoor",
      warna: "Putih",
      harga: 200000,
      gambar: "assets/image/baby1.jpg",
    ),
  ];

  // ===== AMBIL DATA PROFIL =====
  Future<void> getProfile() async {
    try {
      final response = await http.get(
        Uri.parse('https://gilberto-unpercussive-dara.ngrok-free.dev/api/user/profile'),
        headers: {
          'Authorization': 'Bearer ${widget.token}',
          'Accept': 'application/json',
          'ngrok-skip-browser-warning': 'true',
        },
      );

      print("Profile Status: ${response.statusCode}");
      print("Profile Response: ${response.body}");

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        setState(() {
          userData = data['data'] ?? data;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error getProfile: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  // ===== FUNGSI LOGOUT =====
  Future<void> _logout(BuildContext context) async {
    // Tampilkan konfirmasi
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Konfirmasi Logout"),
        content: const Text("Apakah Anda yakin ingin keluar?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Batal"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              "Logout",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );

    if (confirm == true) {
      // Hapus token dari SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('access_token');
      
      if (context.mounted) {
        // Kembali ke halaman login
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) =>  LoginPage()),
          (route) => false,
        );
      }
    }
  }

  // ===== INIT STATE =====
  @override
  void initState() {
    super.initState();
    getProfile();
  }

  // ===== LIST PAGE =====
  List<Widget> get pages => [
    homeContent(),
    PesananPage(token: widget.token),
    const GalleryPage(),
    ProfilPage(
      userData: userData,
      onLogout: () => _logout(context),
    ),
  ];

  // ===== BUILD =====
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5E5E5),

      body: pages[selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Beranda"),
          BottomNavigationBarItem(icon: Icon(Icons.receipt), label: "Pesanan"),
          BottomNavigationBarItem(icon: Icon(Icons.image), label: "Galeri"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
        ],
      ),
    );
  }

  // ===== HOME CONTENT =====
  Widget homeContent() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            // HEADER
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isLoading
                              ? "Halo..."
                              : "Halo ${userData?['username'] ?? userData?['name'] ?? 'User'}!",
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "Selamat datang di aplikasi cekrekqu.\nAbadikan setiap momen spesialmu bersama kami.",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage("https://i.pravatar.cc/150"),
                  ),
                ],
              ),
            ),

            // DAFTAR PAKET
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Daftar Paket",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // TODO: Navigasi ke halaman buat pesanan
                        },
                        child: const Text("+ Buat Pesanan"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Chip(label: Text("Terbaru")),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    children: daftarPaket.map((paket) {
                      return paketCard(paket);
                    }).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // ===== CARD PAKET =====
  Widget paketCard(Paket paket) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey[200],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              width: 90,
              height: 90,
              child: Image.asset(
                paket.gambar,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey,
                    child: const Icon(Icons.broken_image),
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  paket.nama,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text("Tempat: ${paket.tempat}"),
                Text("Warna: ${paket.warna}"),
                Text("Harga: Rp ${paket.harga}"),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Column(
            children: [
              const Icon(Icons.shopping_cart),
              const SizedBox(height: 5),
              ElevatedButton(
                onPressed: () {
                  // TODO: Tambah ke keranjang / proses pesanan
                },
                child: const Text("Beli"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}