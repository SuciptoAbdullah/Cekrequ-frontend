import 'package:flutter/material.dart';
import '../models/paket.dart';

class DetailPaketPage extends StatelessWidget {
  final Paket package;

  const DetailPaketPage({
    super.key,
    required this.package,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),

          onPressed: () {
            Navigator.pop(context);
          },
        ),

        title: const Text(
          "Detail Paket",

          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // FOTO
            ClipRRect(
              borderRadius: BorderRadius.circular(20),

              child: Image.asset(
                package.gambar,
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 20),

            // NAMA
            Text(
              package.nama,

              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            // HARGA
            Text(
              "Rp ${package.harga}",

              style: const TextStyle(
                fontSize: 20,
                color: Colors.pink,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            // BENEFIT
            const Text(
              "Benefit",

              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),

              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(15),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: package.benefits.map((benefit) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text("• $benefit"),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 20),

            // DESKRIPSI
            const Text(
              "Deskripsi",

              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              package.deskripsi,
            ),
          ],
        ),
      ),
    );
  }
}