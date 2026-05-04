import 'package:flutter/material.dart';
import '../models/package.dart';
import 'galeri_page.dart';
import 'pesanan_page.dart';
import 'profil_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  final List<Paket> daftarPaket = [
    Paket(
      nama: "Foto Wedding Dekorasi",
      tempat: "Indoor (studio)",
      warna: "Hitam",
      harga: 250000,
      gambar: "assets/image/Wedding4.jpg",

    ),
    Paket(
      nama: "Foto Prewedding Outdoor",
      tempat: "Outdoor",
      warna: "Hitam",
      harga: 300000,
      gambar: "assets/image/Prewed11.jpg",
    ),
    Paket(
      nama: "Foto Bayi Konsep",
      tempat: "Indoor",
      warna: "Putih",
      harga: 200000,
      gambar: "assets/image/baby1.jpg",
    ),
  ];

  // ===== LIST PAGE =====
  List<Widget> get pages => [
        homeContent(),
        PesananPage(),
        const GalleryPage(),
        const ProfilPage(),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5E5E5),

      // ===== BODY DINAMIS =====
      body: pages[selectedIndex],

      // ===== NAVBAR =====
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
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Halo User!",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Selamat datang di aplikasi cekrekqu.\nAbadikan setiap momen spesialmu bersama kami.",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage:
                        NetworkImage("https://i.pravatar.cc/150"),
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
                        onPressed: () {},
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

  // ===== CARD =====
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
              onPressed: () {},
              child: const Text("Beli"),
            ),
          ],
        ),
      ],
    ),
  );
}
}