import 'package:flutter/material.dart';

class DetailPesananPage extends StatelessWidget {
  final Map<String, dynamic> data;

  const DetailPesananPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rincian Pesanan"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              data["gambar"],
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),

            const SizedBox(height: 10),

            Text(
              data["judul"],
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text("Status: ${data["status"]}"),
          ],
        ),
      ),
    );
  }
}