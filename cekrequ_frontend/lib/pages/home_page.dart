import 'package:flutter/material.dart';
import '../models/paket.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List<Paket> daftarPaket = [
    Paket(
      nama: "Foto Wedding Dekorasi",
      tempat: "Indoor (studio)",
      warna: "Hitam",
      harga: 250000,
      gambar: "cekrequ_frontend/assets/image/Wedding4.jpg",
    ),
    Paket(
      nama: "Foto Prewedding Outdoor",
      tempat: "Outdoor",
      warna: "Hitam",
      harga: 300000,
      gambar: "cekrequ_frontend/assets/image/Prewed11.jpg",
    ),
    Paket(
      nama: "Foto Bayi Konsep",
      tempat: "Indoor",
      warna: "Putih",
      harga: 200000,
      gambar: "cekrequ_frontend/assets/image/baby1.jpg",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE5E5E5),

      // ===== NAVBAR =====
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Beranda"),
          BottomNavigationBarItem(icon: Icon(Icons.receipt), label: "Pesanan"),
          BottomNavigationBarItem(icon: Icon(Icons.image), label: "Galeri"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
        ],
      ),

      // ===== BODY =====
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // ===== HEADER =====
              Container(
                padding: EdgeInsets.all(16),
                margin: EdgeInsets.all(16),
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
                    CircleAvatar(
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
                margin: EdgeInsets.symmetric(horizontal: 16),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    // TITLE + BUTTON
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Daftar Paket",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: Text("+ Buat Pesanan"),
                        ),
                      ],
                    ),

                    SizedBox(height: 10),

                    // FILTER
                    Align(
                      alignment: Alignment.centerRight,
                      child: Chip(label: Text("Terbaru")),
                    ),

                    SizedBox(height: 10),

                    // ✅ LIST DARI MODEL
                    Column(
                      children: daftarPaket.map((paket) {
                        return paketCard(paket);
                      }).toList(),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // ===== CARD =====
  Widget paketCard(Paket paket) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey[200],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              paket.gambar,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),

          SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(paket.nama, style: TextStyle(fontWeight: FontWeight.bold)),
                Text("Tempat: ${paket.tempat}"),
                Text("Warna: ${paket.warna}"),
                Text("Harga: Rp ${paket.harga}"),
              ],
            ),
          ),

          Column(
            children: [
              Icon(Icons.shopping_cart),
              SizedBox(height: 5),
              ElevatedButton(onPressed: () {}, child: Text("Beli")),
            ],
          ),
        ],
      ),
    );
  }
}
