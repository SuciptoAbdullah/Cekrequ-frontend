import 'package:flutter/material.dart';
import 'galeri_page.dart';

import '../models/paket.dart';
import 'data_paket.dart';

class JelajahiPage extends StatelessWidget {
  const JelajahiPage({super.key});

  Widget buildItem(
    BuildContext context,
    String title,
    String desc,
    String img,
    List<Paket> packages,
  ) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,

          MaterialPageRoute(
            builder: (_) => GalleryPage(
              title: title,
              packages: packages,
            ),
          ),
        );
      },

      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(10),

        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),

        child: Row(
          children: [

            ClipRRect(
              borderRadius: BorderRadius.circular(15),

              child: Image.asset(
                img,
                width: 90,
                height: 90,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(width: 15),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  Text(
                    title,

                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    desc,

                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        title: Image.asset(
          "assets/image/Logo.jpeg",
          height: 40,
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            const Text(
              "Jelajahi",

              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              "Klik untuk info lebih detail",

              style: TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView(
                children: [

                  buildItem(
                    context,
                    "Prewedding",
                    "Mau Prewedding? ambil paket ini saja",
                    "assets/image/Prewed10.jpg",
                    kategoriPaket["Prewedding"]!,
                  ),

                  buildItem(
                    context,
                    "Wedding",
                    "Yakin mau nikah tapi tidak diabadikan?",
                    "assets/image/Wedding6.jpg",
                    kategoriPaket["Wedding"]!,
                  ),

                  buildItem(
                    context,
                    "Baby",
                    "Abadikan momen dengan paket foto ini",
                    "assets/image/baby1.jpg",
                    kategoriPaket["Baby"]!,
                  ),

                  buildItem(
                    context,
                    "Maternity",
                    "Abadikan momen dengan paket foto ini",
                    "assets/image/Maternity1.jpg",
                    kategoriPaket["Maternity"]!,
                  ),

                  buildItem(
                    context,
                    "Personal",
                    "Butuh foto formal? Pesan yang ini saja",
                    "assets/image/Personal2.jpg",
                    kategoriPaket["Personal"]!,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}