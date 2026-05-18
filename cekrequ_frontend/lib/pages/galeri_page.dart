import 'package:flutter/material.dart';
import 'detail_paket_page.dart';
import '../models/paket.dart';

class GalleryPage extends StatelessWidget {
  final String title;
  final List<Paket> packages;

  const GalleryPage({
    super.key,
    required this.title,
    required this.packages,
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

        title: Text(
          title,

          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(12),

        child: GridView.builder(
          itemCount: packages.length,

          gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.75,
          ),

          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailPaketPage(
                      package: packages[index],
                    ),
                  ),
                );
              },

              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),

                child: Image.asset(
                  packages[index].gambar,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}