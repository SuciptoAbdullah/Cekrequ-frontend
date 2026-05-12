import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const RincianPesananPage(),
    );
  }
}

class RincianPesananPage extends StatelessWidget {
  const RincianPesananPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              children: [
                // HEADER
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.arrow_back_ios, size: 18),
                        SizedBox(width: 4),
                        Text(
                          "Rincian Pesanan",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Serif',
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          )
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 18),

                // CARD DETAIL
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
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
                        borderRadius: BorderRadius.circular(14),
                        child: Image.network(
                          'https://images.unsplash.com/photo-1522673607200-164d1b6ce486?q=80&w=1000',
                          height: 170,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),

                      const SizedBox(height: 12),

                      const Text(
                        "Foto Studio Prewedding Adat",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Serif',
                        ),
                      ),

                      const SizedBox(height: 8),

                      const Text(
                        "Tempat : Indoor (studio)",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),

                      const SizedBox(height: 4),

                      const Text(
                        "Rekomendasi Warna : Hitam",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),

                      const SizedBox(height: 4),

                      const Text(
                        "Harga : 250000",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),

                      const SizedBox(height: 12),

                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightBlue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 10,
                            ),
                          ),
                          onPressed: () {},
                          child: const Text(
                            "Lihat Detail",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 18),

                // FORM + RINGKASAN
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      buildTextField("Nama Pemesan"),
                      const SizedBox(height: 10),

                      buildTextField("Nomer Telepon"),
                      const SizedBox(height: 10),

                      buildTextField("Email"),
                      const SizedBox(height: 10),

                      buildTextField("Jadwal Foto"),
                      const SizedBox(height: 10),

                      buildTextField("Lokasi pemotretan"),
                      const SizedBox(height: 10),

                      buildTextField("Foto/Penyewaan"),

                      const SizedBox(height: 22),

                      const Text(
                        "Ringkasan Pesanan",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),

                      const SizedBox(height: 12),

                      buildSummaryTable(),

                      const SizedBox(height: 24),

                      SizedBox(
                        width: 220,
                        height: 45,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF9ACD32),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text(
                            "Metode Pembayaran",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String hint) {
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: const Color(0xFFF1F1F1),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget buildSummaryTable() {
    return Table(
      border: TableBorder.all(
        color: Colors.black,
        width: 1,
      ),
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(1),
      },
      children: const [
        TableRow(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Paket",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Subtotal",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        TableRow(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Nama Paket"),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("********"),
            ),
          ],
        ),
        TableRow(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Jumlah"),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("******"),
            ),
          ],
        ),
        TableRow(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Harga"),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Rp *****"),
            ),
          ],
        ),
        TableRow(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Total"),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Rp *****"),
            ),
          ],
        ),
        TableRow(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("DP"),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Rp *****"),
            ),
          ],
        ),
      ],
    );
  }
}