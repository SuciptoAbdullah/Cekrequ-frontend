import 'package:flutter/material.dart';

class PesananPage extends StatelessWidget {
  PesananPage({super.key});

  final List<Map<String, dynamic>> pesanan = [
    {
      "judul": "Foto Wedding Dekorasi",
      "status": "Sukses",
      "gambar": "assets/image/Wedding4.jpg",
    },
    {
      "judul": "Foto Prewedding Outdoor Adat Jawa",
      "status": "Sukses",
      "gambar": "assets/image/Prewed11.jpg",
    },
    {
      "judul": "Foto Bayi Konsep Salon",
      "status": "Sukses",
      "gambar": "assets/image/baby1.jpg",
    },
    {
      "judul": "Foto Maternity Adat Jawa",
      "status": "Sukses",
      "gambar": "assets/image/Maternity1.jpg",
    },
  ];

  Color getStatusColor(String status) {
    return status == "Sukses" ? Colors.green : Colors.orange;
  }

  Color getStatusBg(String status) {
    return status == "Sukses" ? Colors.green.shade100 : Colors.orange.shade100;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Pesanan"),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // FILTER
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: const [
                Text("Urutkan menurut: "),
                SizedBox(width: 10),
                Chip(label: Text("Terbaru")),
              ],
            ),
          ),

          // LIST PESANAN
          Expanded(
            child: ListView.builder(
              itemCount: pesanan.length,
              itemBuilder: (context, index) {
                final item = pesanan[index];

                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        // GAMBAR (AMAN)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            item["gambar"],
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,

                            // 🔥 INI YANG PENTING (ANTI ERROR MERAH)
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 70,
                                height: 70,
                                color: Colors.grey[300],
                                child: const Icon(
                                  Icons.image_not_supported,
                                  color: Colors.grey,
                                ),
                              );
                            },
                          ),
                        ),

                        const SizedBox(width: 12),

                        // INFO
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item["judul"],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 6),

                              Row(
                                children: [
                                  const Text("Status: "),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: getStatusBg(item["status"]),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      item["status"],
                                      style: TextStyle(
                                        color: getStatusColor(item["status"]),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // BUTTON
          Padding(
            padding: const EdgeInsets.all(12),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: Colors.blue,
                ),
                child: const Text("+ Buat Pesanan"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
