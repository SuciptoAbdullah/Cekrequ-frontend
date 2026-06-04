import 'package:flutter/material.dart';
import 'home_page.dart';

class AiPage extends StatefulWidget {
  const AiPage({super.key});

  @override
  State<AiPage> createState() => _AiPageState();
}

class _AiPageState extends State<AiPage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF2F5),

      // ===== BODY =====
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                // ===== LOGO =====
                Row(
                  children: [

                    Image.asset(
                      "assets/image/Logo.jpeg",
                      height: 35,
                    ),

                    const SizedBox(width: 10),

                    RichText(
                      text: const TextSpan(
                        children: [

                          TextSpan(
                            text: "Cekrequ",

                            style: TextStyle(
                              color: Color(0xFF2EA7FF),
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          TextSpan(
                            text: " Photo AI",

                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 28,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 25),

                // ===== HELLO =====
                const Text(
                  "Hallo, User",

                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                const Text(
                  "Mau foto konsep apa hari ini ?",

                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 22),

                // ===== SEARCH =====
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),

                  decoration: BoxDecoration(
                    color: Colors.white,

                    borderRadius: BorderRadius.circular(30),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),

                  child: const TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,

                      icon: Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),

                      hintText: "Search konsep foto...",
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // ===== TITLE =====
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,

                  children: [

                    const Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [

                        Text(
                          "Rekomendasi Untuk Kamu",

                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 5),

                        Text(
                          "Berdasarkan trend terbaru",

                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),

                    const Icon(Icons.arrow_forward_ios, size: 18),
                  ],
                ),

                const SizedBox(height: 18),

                // ===== CARD =====
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,

                    borderRadius: BorderRadius.circular(18),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),

                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [

                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(18),
                          topRight: Radius.circular(18),
                        ),

                        child: Image.asset(
                          "assets/image/Prewed10.jpg",

                          height: 220,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(14),

                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,

                          children: [

                            const Text(
                              "Foto Studio Prewedding Adat",

                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 8),

                            Row(
                              children: [

                                const Text(
                                  "Kategori | Prewedding",

                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),

                                const Spacer(),

                                ElevatedButton(
                                  onPressed: () {},

                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color(0xFF2EA7FF),

                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20),
                                    ),
                                  ),

                                  child: const Text(
                                    "Lihat Detail",

                                    style: TextStyle(
                                      color: Colors.white,
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

                const SizedBox(height: 30),

                // ===== KATEGORI =====
                const Text(
                  "Kategori Trending",

                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 18),

                Wrap(
                  spacing: 12,
                  runSpacing: 12,

                  children: [

                    kategoriChip("Wedding"),
                    kategoriChip("Prewedding"),
                    kategoriChip("Family"),
                    kategoriChip("Personal"),
                    kategoriChip("Newborn"),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),

      // ===== NAVBAR =====
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,

        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });

          // NAVIGASI
          if (index == 0) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomePage(token: ' ')));
          }

          if (index == 1) {
            Navigator.pop(context);
          }

          if (index == 2) {
            // NOTIFIKASI
          }

          if (index == 3) {
            // PROFILE
          }
        },

        selectedItemColor: Colors.grey,
        unselectedItemColor: Colors.grey,

        type: BottomNavigationBarType.fixed,

        items: const [

          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined),
            label: "Jelajah",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.mail_outline),
            label: "Notifikasi",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Profile",
          ),
        ],
      ),
    );
  }

  // ===== CHIP =====
  Widget kategoriChip(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(16),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),

      child: Row(
        mainAxisSize: MainAxisSize.min,

        children: [

          const Icon(Icons.blur_on, size: 16),

          const SizedBox(width: 6),

          Text(title),
        ],
      ),
    );
  }
}