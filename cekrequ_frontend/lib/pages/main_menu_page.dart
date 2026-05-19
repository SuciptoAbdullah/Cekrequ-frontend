import 'package:flutter/material.dart';
import 'ai_page.dart';
import 'home_page.dart';

class MainMenuPage extends StatefulWidget {
  const MainMenuPage({super.key});

  @override
  State<MainMenuPage> createState() => _MainMenuPageState();
}

class _MainMenuPageState extends State<MainMenuPage> {

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9EDF2),

      // ===== APPBAR =====
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        title: Align(
          alignment: Alignment.centerLeft,

          child: Image.asset(
            "assets/image/Logo.jpeg",
            height: 35,
          ),
        ),
      ),

      // ===== BODY =====
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          padding: const EdgeInsets.all(20),

          decoration: BoxDecoration(
            color: Colors.white,

            borderRadius: BorderRadius.circular(20),

            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),

          child: Column(
            mainAxisSize: MainAxisSize.min,

            children: [

              // ===== TITLE =====
              const Text(
                "Pilih Menu",

                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              // ===== BUTTON REKOMENDASI =====
              SizedBox(
                width: double.infinity,
                height: 50,

                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: Color(0xFF1697E6),
                      width: 2,
                    ),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),

                    backgroundColor: Colors.white,
                  ),

                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const AiPage(),
                      ),
                    );
                  },

                  child: const Text(
                    "✦ Rekomendasi Cerdas",

                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ===== BUTTON PILIH MENU =====
              SizedBox(
                width: double.infinity,
                height: 50,

                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1697E6),

                    elevation: 5,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),

                  onPressed: () {},

                  child: const Text(
                    "◻ Pilih Menu",

                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      // ===== BOTTOM NAVBAR =====
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,

        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });

          // ===== HOME =====
          if (index == 0) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomePage(token: '')));
          }

          // ===== JELAJAH =====
          if (index == 1) {}

          // ===== NOTIFIKASI =====
          if (index == 2) {}

          // ===== PROFILE =====
          if (index == 3) {}
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
}