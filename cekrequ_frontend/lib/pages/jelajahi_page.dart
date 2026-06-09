import 'package:flutter/material.dart';
import 'galeri_page.dart';
import '../models/paket.dart';
import 'data_paket.dart';

class JelajahiPage extends StatefulWidget {
  // 1. Perbaikan: Menyimpan token ke dalam variabel kelas agar bisa diakses atau tidak error
  final String token;

  const JelajahiPage({super.key, required this.token});

  @override
  State<JelajahiPage> createState() => _JelajahiPageState();
}

class _JelajahiPageState extends State<JelajahiPage> {
  // Menentukan tab yang aktif secara default
  String activeTab = 'Pesan';

  // Data tiruan yang disesuaikan persis dengan gambar screenshot Anda
  final List<Map<String, dynamic>> daftarPesanan = [
    {
      'title': 'Foto Wedding Dekorasi',
      'status': 'Sukses',
      'img': 'assets/image/Wedding6.jpg',
      'kategori': 'Pesan',
    },
    {
      'title': 'Foto Prewedding Outdoor Adat Jawa',
      'status': 'Sukses',
      'img': 'assets/image/Prewed10.jpg',
      'kategori': 'Pesan',
    },
    {
      'title': 'Foto Bayi Konsep Salon',
      'status': 'Sukses',
      'img': 'assets/image/baby1.jpg',
      'kategori': 'Pesan',
    },
    {
      'title': 'Foto Maternity Adat Jawa',
      'status': 'Pending',
      'img': 'assets/image/Maternity1.jpg',
      'kategori': 'Pesan',
    },
    // Contoh data untuk tab Booking
    {
      'title': 'Booking Paket Foto Personal',
      'status': 'Pending',
      'img': 'assets/image/Personal2.jpg',
      'kategori': 'Booking',
    },
  ];

  Widget buildItem({
    required BuildContext context,
    required String title,
    required String status,
    required String img,
  }) {
    // Menentukan warna badge status (Sukses = Hijau, Pending = Oranye)
    Color statusBgColor = status == 'Sukses' ? const Color(0xFF8BC34A) : const Color(0xFFE1A15B);

    return InkWell(
      onTap: () {
        // Aksi ketika item pesanan diklik (misal pergi ke halaman galeri/detail)
        List<Paket>? paketData;
        
        // Safety check untuk memisahkan kata kunci kategori paket
        final kataKunci = title.split(' ');
        if (kataKunci.length > 1) {
          paketData = kategoriPaket[kataKunci[1]];
        }
        
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (_) => GalleryPage(
        //       title: title,
        //       packages: paketData ?? [], // Mengirim list kosong jika data tidak ditemukan
        //     ),
        //   ),
        // );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bagian Foto Produk
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                img,
                width: 90,
                height: 90,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 90,
                    height: 90,
                    color: Colors.grey[300],
                    child: const Icon(Icons.image, color: Colors.grey),
                  );
                },
              ),
            ),
            const SizedBox(width: 15),
            // Bagian Informasi Teks & Status
            Expanded(
              child: SizedBox(
                height: 90,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    Row(
                      children: [
                        const Text(
                          "Status : ",
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                        const SizedBox(width: 5),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                          decoration: BoxDecoration(
                            color: statusBgColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            status,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Memfilter list data berdasarkan tab yang aktif saat ini
    final filteredPesanan = daftarPesanan.where((item) => item['kategori'] == activeTab).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Daftar Pesanan",
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 10),
            // Tombol Switcher Tab (Pesan & Booking)
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: const Color(0xFFE0E0E0),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  // Tab Pesan
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          activeTab = 'Pesan';
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: activeTab == 'Pesan' ? Colors.white : Colors.transparent,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Text(
                          "Pesan",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: activeTab == 'Pesan' ? Colors.black : Colors.grey[700],
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Tab Booking
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          activeTab = 'Booking';
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: activeTab == 'Booking' ? Colors.white : Colors.transparent,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Text(
                          "Booking",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: activeTab == 'Booking' ? Colors.black : Colors.grey[700],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            // List Item Pesanan/Booking
            Expanded(
              child: filteredPesanan.isEmpty
                  ? Center(
                      child: Text(
                        "Tidak ada data $activeTab",
                        style: const TextStyle(color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredPesanan.length,
                      itemBuilder: (context, index) {
                        final item = filteredPesanan[index];
                        return buildItem(
                          context: context,
                          title: item['title'],
                          status: item['status'],
                          img: item['img'],
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}