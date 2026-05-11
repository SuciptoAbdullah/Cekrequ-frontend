import 'package:flutter/material.dart';

class DetailPesananPage extends StatelessWidget {
  final Map<String, dynamic> data;

  const DetailPesananPage({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffECEFF1),

      // ================= APP BAR =================
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 60,

        leadingWidth: 80,

        leading: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Image.asset(
            "assets/image/logo.png",
            height: 35,
          ),
        ),

        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Icon(
              Icons.notifications_none,
              color: Colors.black,
              size: 28,
            ),
          ),
        ],
      ),

      // ================= BODY =================
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 30),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // HEADER TITLE
              Container(
                width: double.infinity,
                color: const Color(0xffECEFF1),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),

                child: Row(
                  children: [

                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                        size: 30,
                      ),
                    ),

                    const SizedBox(width: 10),

                    const Text(
                      "Rincian Pesanan",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Serif',
                      ),
                    ),
                  ],
                ),
              ),

              // ================= CONTENT =================
              Padding(
                padding: const EdgeInsets.all(16),

                child: Container(
                  padding: const EdgeInsets.all(16),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
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
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          data["gambar"],
                          width: double.infinity,
                          height: 250,
                          fit: BoxFit.cover,
                        ),
                      ),

                      const SizedBox(height: 20),

                      // TITLE
                      Text(
                        data["judul"],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Serif',
                        ),
                      ),

                      const SizedBox(height: 5),

                      // SUBTITLE
                      const Text(
                        "Adat Jawa",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Serif',
                        ),
                      ),

                      const SizedBox(height: 20),

                      // DETAIL INFO
                      buildInfoRow(
                        "Hari/Tanggal",
                        "Minggu, 29 February 2025",
                      ),

                      buildInfoRow(
                        "Jam",
                        "09.30",
                      ),

                      buildInfoRow(
                        "Tema Warna",
                        "Hitam",
                      ),

                      buildInfoRow(
                        "Total Harga",
                        "Rp50.000",
                      ),

                      buildInfoRow(
                        "Lokasi",
                        "Di Studio",
                      ),

                      const SizedBox(height: 25),

                      // LOCATION BOX
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(14),

                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.shade300,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Row(
                              children: const [
                                Icon(
                                  Icons.location_on,
                                  color: Colors.lightBlue,
                                ),

                                SizedBox(width: 5),

                                Text(
                                  "Detail Lokasi:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 10),

                            const Padding(
                              padding: EdgeInsets.only(left: 28),
                              child: Text(
                                "Jl. Ir. H. Juanda, Singajaya, Kec.\n"
                                "Indramayu, Kabupaten Indramayu, Jawa\n"
                                "Barat 45218",
                                style: TextStyle(
                                  color: Colors.grey,
                                  height: 1.5,
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
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          SizedBox(
            width: 100,
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ),

          const Text(":"),

          const SizedBox(width: 10),

          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}