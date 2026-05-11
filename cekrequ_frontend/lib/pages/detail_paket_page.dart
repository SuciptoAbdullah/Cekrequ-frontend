import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff3f3f3),

      // ================= APP BAR =================
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        elevation: 0,
        automaticallyImplyLeading: false,
        toolbarHeight: 70,
        title: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Image.asset(
            "assets/image/logo.png",
            height: 40,
            fit: BoxFit.contain,
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 100),

          child: Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: Colors.grey.shade300),
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // TITLE
                const Center(
                  child: Text(
                    "Detail Paket",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Serif',
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Stack(
                  alignment: Alignment.center,
                  children: [

                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        "assets/image/baby1.jpg",
                        height: 320,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),

                    // LEFT BUTTON
                    Positioned(
                      left: 10,
                      child: CircleAvatar(
                        backgroundColor: Colors.white70,
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),

                    // RIGHT BUTTON
                    Positioned(
                      right: 10,
                      child: CircleAvatar(
                        backgroundColor: Colors.white70,
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                // DOT INDICATOR
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    4,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // PACKAGE NAME
                const Text(
                  "Nama paketnya taru sini ya :D",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                // BENEFIT TITLE
                Text(
                  "Benefit :",
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 8),

                // BENEFIT BOX
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: Colors.grey.shade400),
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [

                      Text("● Nama benefit dari paket ini itu disini"),
                      SizedBox(height: 8),

                      Text("● Nama benefit dari paket ini itu disini"),
                      SizedBox(height: 8),

                      Text("● Nama benefit dari paket ini itu disini"),
                      SizedBox(height: 8),

                      Text("● Nama benefit dari paket ini itu disini"),
                      SizedBox(height: 8),

                      Text("● Nama benefit dari paket ini itu disini"),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // DESCRIPTION TITLE
                Text(
                  "Deskripsi",
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 10),

                // DESCRIPTION
                const Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      // ================= NAVBAR =================
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,

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
            icon: Icon(Icons.notifications_none),
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