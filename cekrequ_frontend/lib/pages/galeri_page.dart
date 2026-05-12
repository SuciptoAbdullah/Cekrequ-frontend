import 'package:flutter/material.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});

  Widget buildItem(
    BuildContext context, String title, String desc, String img) {
    return InkWell(
      onTap: () {},
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(img, width: 80, height: 80, fit: BoxFit.cover),
              ),
              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16,
                    ),),
                    const SizedBox(height: 5),
                    Text(desc, style: const TextStyle(color: Colors.grey),),
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
        title: const Text("Daftar Gambar"),
        centerTitle: true,
        actions: const [
          Icon(Icons.shopping_cart_outlined),
          SizedBox(width: 10),
          Icon(Icons.notifications_none),
          SizedBox(width: 10),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            const Text("Jelajahi", style: TextStyle(fontSize: 20, fontWeight:FontWeight.bold),),
            const SizedBox(height: 5),
            const Text("Klik untuk info lebih detail"),
            const SizedBox(height: 15),

            Expanded(
              child: ListView(
                children: [
                  buildItem(context, "Prewedding", "butuh foto formal? pesan yang ini saja :D", "assets/image/Prewed10.jpg"),
                  buildItem(context, "Wedding", "Yakin mau nikah tapi tidak diabadikan?", "assets/image/Wedding6.jpg"),
                  buildItem(context, "Baby", "Abadikan momen dengan paket foto ini", "assets/image/baby1.jpg"),
                  buildItem(context, "Maternity", "Abadikan momen dengan paket foto ini", "assets/image/Maternity1.jpg"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}