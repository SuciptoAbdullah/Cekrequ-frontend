import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'pembelian_page.dart'; // Sesuaikan dengan struktur folder Anda jika berbeda

import '../models/paket.dart';
import 'data_paket.dart';

import 'jelajahi_page.dart';
import 'pesanan_page.dart';
import 'profil_page.dart';
import 'login_page.dart';


// ===== HOME PAGE =====

class HomePage extends StatefulWidget {
  final String token;
  final Map<String, dynamic>? userData;

  const HomePage({
    super.key,
    required this.token,
    this.userData,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int selectedIndex = 0;
  Map<String, dynamic>? userData;
  bool isLoading = true;
  String? errorMessage;

  // ===== DATA PAKET DARI data_paket.dart =====

  final List<Paket> daftarPaket = [
    ...kategoriPaket["Prewedding"]!,
    ...kategoriPaket["Wedding"]!,
    ...kategoriPaket["Baby"]!,
    ...kategoriPaket["Maternity"]!,
    ...kategoriPaket["Personal"]!,
  ];

  // ===== AMBIL DATA PROFIL =====

  Future<void> getProfile() async {

    if (widget.userData != null) {
      setState(() {
        userData = widget.userData;
        isLoading = false;
        errorMessage = null;
      });

      return;
    }

    try {

      final prefs = await SharedPreferences.getInstance();

      final savedUserData =
          prefs.getString('user_data');

      if (savedUserData != null) {

        setState(() {
          userData = jsonDecode(savedUserData);
          isLoading = false;
        });

        return;
      }

    } catch (e) {
      print(e);
    }

    setState(() {
      userData = {
        'username': 'User',
        'email': 'user@email.com',
      };

      isLoading = false;
      errorMessage = "Menggunakan data default";
    });
  }

  // ===== LOGOUT =====

  Future<void> _logout(BuildContext context) async {

    final confirm = await showDialog<bool>(
      context: context,

      builder: (context) => AlertDialog(
        title: const Text("Konfirmasi Logout"),

        content: const Text(
          "Apakah Anda yakin ingin keluar?",
        ),

        actions: [

          TextButton(
            onPressed: () =>
                Navigator.pop(context, false),

            child: const Text("Batal"),
          ),

          TextButton(
            onPressed: () =>
                Navigator.pop(context, true),

            child: const Text(
              "Logout",

              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );

    if (confirm == true) {

      final prefs =
          await SharedPreferences.getInstance();

      await prefs.remove('access_token');
      await prefs.remove('user_data');

      if (context.mounted) {

        Navigator.pushAndRemoveUntil(
          context,

          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),

          (route) => false,
        );
      }
    }
  }

  // ===== INIT =====

  @override
  void initState() {
    super.initState();
    getProfile();
  }

  // ===== LIST PAGE =====

  List<Widget> get pages => [

    homeContent(),

    PesananPage(
      token: widget.token,
    ),

    const JelajahiPage(),

    ProfilPage(
      userData: userData,
      onLogout: () => _logout(context),
      isLoading: isLoading,
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

          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Beranda",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            label: "Pesanan",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.image),
            label: "Galeri",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profil",
          ),
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

            // ===== HEADER =====

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
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [

                        Text(
                          isLoading
                              ? "Halo..."
                              : "Halo ${userData?['username'] ?? 'User'}!",

                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 8),

                        const Text(
                          "Selamat datang di aplikasi cekrekqu.\nAbadikan setiap momen spesialmu bersama kami.",

                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const CircleAvatar(
                    radius: 30,

                    backgroundImage: NetworkImage(
                      "https://i.pravatar.cc/150",
                    ),
                  ),
                ],
              ),
            ),

            // ===== DAFTAR PAKET =====

            Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 16),

              padding: const EdgeInsets.all(16),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),

              child: Column(
                children: [

                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,

                    children: [

                      const Text(
                        "Daftar Paket",

                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      ElevatedButton(
                        onPressed: () {},

                        child: const Text(
                          "+ Buat Pesanan",
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  const Align(
                    alignment: Alignment.centerRight,

                    child: Chip(
                      label: Text("Terbaru"),
                    ),
                  ),

                  const SizedBox(height: 10),

                  isLoading
                      ? const Center(
                          child:
                              CircularProgressIndicator(),
                        )

                      : Column(
                          children:
                              daftarPaket.map((paket) {

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
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          ClipRRect(
            borderRadius: BorderRadius.circular(10),

            child: SizedBox(
              width: 90,
              height: 90,

              child: Image.asset(
                paket.gambar,

                fit: BoxFit.cover,

                errorBuilder:
                    (context, error, stackTrace) {

                  return Container(
                    color: Colors.grey,

                    child: const Icon(
                      Icons.broken_image,
                    ),
                  );
                },
              ),
            ),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Text(
                  paket.nama,

                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),

                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 4),

                Text("Tempat: ${paket.tempat}"),
                // Text("Warna: ${paket.warna}"),
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
                  // Pindah ke halaman pembelian dengan membawa data paket saat ini
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PembelianPage(paket: paket),
                    ),
                  );
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