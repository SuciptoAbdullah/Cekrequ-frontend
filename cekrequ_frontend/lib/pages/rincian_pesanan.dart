import 'package:flutter/material.dart';

class DetailPesananPage extends StatelessWidget {
  final Map<String, dynamic> data;

  const DetailPesananPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rincian Pesanan"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // IMAGE
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  data["gambar"],
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: double.infinity,
                      height: 250,
                      color: Colors.grey[300],
                      child: const Icon(Icons.broken_image, size: 50),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),

              // TITLE
              Text(
                data["judul"],
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),

              // STATUS
              Text(
                "Status: ${data["status"]}",
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // INFO ROWS
              buildInfoRow(
                "Hari/Tanggal",
                data["tanggal"] ?? "Minggu, 29 February 2025",
              ),
              buildInfoRow(
                "Jam",
                data["jam"] ?? "09.30",
              ),
              buildInfoRow(
                "Tema Warna",
                data["warna"] ?? "Hitam",
              ),
              buildInfoRow(
                "Total Harga",
                data["harga"] ?? "Rp50.000",
              ),
              buildInfoRow(
                "Lokasi",
                data["lokasi"] ?? "Di Studio",
              ),
              const SizedBox(height: 25),

              // LOCATION BOX
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.location_on, color: Colors.lightBlue),
                        SizedBox(width: 5),
                        Text(
                          "Detail Lokasi:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Padding(
                      padding: EdgeInsets.only(left: 28),
                      child: Text(
                        "Jl. Ir. H. Juanda, Singajaya, Kec.\n"
                        "Indramayu, Kabupaten Indramayu,\n"
                        "Jawa Barat 45218",
                        style: TextStyle(color: Colors.grey, height: 1.5),
                      ),
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

  Widget buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              title,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
          const Text(":"),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}