import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/paket.dart';
import 'data_paket.dart';

import 'jelajahi_page.dart';
import 'pesanan_page.dart';
import 'profil_page.dart';
import 'login_page.dart';
import 'main_menu_page.dart';

// ===== HOME PAGE =====
class HomePage extends StatefulWidget {
  final String token;
  final Map<String, dynamic>? userData;

  const HomePage({super.key, required this.token, this.userData});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  Map<String, dynamic>? userData;
  bool isLoading = true;

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
      });

      return;
    }

    try {
      final prefs = await SharedPreferences.getInstance();

      final savedUserData = prefs.getString('user_data');

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
      userData = {'username': 'User'};

      isLoading = false;
    });
  }

// ===== LOGOUT =====
  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove('access_token');
    await prefs.remove('user_data');

    if (context.mounted) {
      Navigator.pushAndRemoveUntil(
        context,

        MaterialPageRoute(builder: (context) => LoginPage()),

        (route) => false,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    getProfile();
  }

  List<Widget> get pages => [
    homeContent(),

    PesananPage(token: widget.token),

    const JelajahiPage(),

    ProfilPage(
      userData: userData,
      onLogout: () => _logout(context),
      isLoading: isLoading,
    ),
  ];

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

        selectedItemColor: Colors.black,

        unselectedItemColor: Colors.grey,

        backgroundColor: Colors.white,
        elevation: 10,

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home), 
            label: "Beranda"
            ),

          BottomNavigationBarItem(
            icon: Icon(Icons.receipt), 
            label: "Pesanan"
            ),

          BottomNavigationBarItem(
            icon: Icon(Icons.image), 
            label: "Galeri"
            ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person), 
            label: "Profil"
            ),
        ],
      ),
    );
  }

  Widget homeContent() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),

          child: Column(
            children: [
               
              // ===== HEADER =====
              Container(
                padding: const EdgeInsets.all(18),

                decoration: BoxDecoration(
                  color: Colors.white,

                  borderRadius: BorderRadius.circular(22),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),

                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
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
                                : "Halo ${userData?['username'] ?? 'User'}!",

                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                            ),
                          ),

                          const SizedBox(height: 10),

                          const Text(
                            "Selamat datang di aplikasi cekrequ.\nAbadikan setiap momen spesialmu bersama kami.",

                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const CircleAvatar(
                      radius: 35,
                      backgroundImage: NetworkImage(
                        "https://i.pravatar.cc/150",
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // ===== DAFTAR PAKET =====
              Container(
                padding: const EdgeInsets.all(18),

                decoration: BoxDecoration(
                  color: const Color(0xFFF7F7F7),

                  borderRadius: BorderRadius.circular(24),

                  border: Border.all(color: Colors.grey.shade300),
                ),

                child: Column(
                  children: [
                    const Text(
                      "Daftar Paket",

                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 16),

                    SizedBox(
                      width: double.infinity,
                      height: 45,

                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const MainMenuPage()));
                        },

                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1EA0E9),

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),

                        child: const Text(
                          "+ Buat Pesanan",

                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    Row(
                      children: [
                        const Text(
                          "Urutkan menurut :",

                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),

                        const Spacer(),

                       // ===== DAFTAR PAKET ====
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 7,
                          ),

                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,

                            borderRadius: BorderRadius.circular(20),
                          ),

                          child: const Text("Terbaru"),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : Column(
                            children: daftarPaket.map((paket) {
                              return paketCard(paket);
                            }).toList(),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

// ===== CARD PAKET =====
  Widget paketCard(Paket paket) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),

      padding: const EdgeInsets.all(10),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(18),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),

            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),

      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),

            child: Image.asset(
              paket.gambar,

              width: 85,
              height: 85,
              fit: BoxFit.cover,

              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 85,
                  height: 85,
                  color: Colors.grey,

                  child: const Icon(Icons.broken_image),
                );
              },
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  paket.nama,

                  style: const TextStyle(
                    fontWeight: FontWeight.w600,

                    fontSize: 14,
                  ),

                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 8),

                Text(
                  "Tempat : ${paket.tempat}",

                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),

                const SizedBox(height: 4),

                Text(
                  "Rp ${paket.harga}",

                  style: const TextStyle(
                    fontWeight: FontWeight.bold,

                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

          Column(
            children: [

              const SizedBox(height: 8),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 5,
                ),

                decoration: BoxDecoration(
                  color: const Color(0xFF8BC34A),

                  borderRadius: BorderRadius.circular(20),
                ),

                child: const Text(
                  "Sukses",

                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}