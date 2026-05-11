import 'package:flutter/material.dart';

class ProfilPage extends StatelessWidget {
  final Map<String, dynamic>? userData;
  final VoidCallback? onLogout;
  final bool isLoading; // 🔥 Tambahan opsional

  const ProfilPage({
    super.key,
    this.userData,
    this.onLogout,
    this.isLoading = false, // Default false
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage("https://i.pravatar.cc/150"),
            ),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                leading: const Icon(Icons.person),
                title: const Text("Username"),
                subtitle: Text(
                  userData?['username'] ?? 
                  userData?['name'] ?? 
                  userData?['data']?['username'] ?? // Tambahan nested data
                  "Belum tersedia"
                ),
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.email),
                title: const Text("Email"),
                subtitle: Text(
                  userData?['email'] ?? 
                  userData?['data']?['email'] ?? // Tambahan nested data
                  "Belum tersedia"
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLoading ? null : onLogout, // 🔥 Disable jika loading
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Text("Logout", style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}