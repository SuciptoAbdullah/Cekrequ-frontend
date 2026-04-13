import 'package:flutter/material.dart';

class PesananPage extends StatelessWidget {
  PesananPage({super.key});
  final List<Map<String, dynamic>> pesanan = [
    {
      "judul": "Foto Wedding Dekorasi",
      "status": "Sukses",
      "gambar": "assets/image/Wedding11.jpg"
    },
    {
      "judul": "Foto Prewedding Outdoor Adat Jawa",
      "status": "Sukses",
      "gambar": "assets/image/Prewedding11jpg"
    },
    {
      "judul": "Foto Bayi Konsep Salon",
      "status": "Sukses",
      "gambar": "assets/image/baby1.jpg"
    },
    {
      "judul": "Foto Maternity Adat Jawa",
      "status": "Sukses",
      "gambar": "assets/image/Maternity1.jpg"
    },
  ];

  Color getStatusColor(String status) {
    if (status == "Sukses") {
      return Colors.green;
    } else {
      return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daftar Pesanan"),
        actions: [
          Icon(Icons.shopping_cart_outlined),
          SizedBox(width: 10),
          Icon(Icons.notifications_none),
          SizedBox(width: 10),
        ],
      ),
      body: Column(
        children: [
          // Filter
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Text("Urutkan menurut: "),
                SizedBox(width: 10),
                Chip(label: Text("Terbaru")),
              ],
            ),
          ),

          // List Pesanan
          Expanded(
            child: ListView.builder(
              itemCount: pesanan.length,
              itemBuilder: (context, index) {
                final item = pesanan[index];

                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        // Gambar
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            item["gambar"],
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                          ),
                        ),

                        SizedBox(width: 10),

                        // Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item["judul"],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Text("Status: "),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: getStatusColor(item["status"]),
                                          
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      item["status"],
                                      style: TextStyle(
                                        color:
                                            getStatusColor(item["status"]),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Tombol Buat Pesanan
          Padding(
            padding: const EdgeInsets.all(12),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // aksi buat pesanan
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: Colors.blue,
                ),
                child: Text("+ Buat Pesanan"),
              ),
            ),
          )
        ],
      ),
    );
  }
}