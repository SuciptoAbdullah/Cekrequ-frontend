import 'package:flutter/material.dart';
import '../models/paket.dart';

class PembelianPage extends StatefulWidget {
  final Paket paket;

  const PembelianPage({super.key, required this.paket});

  @override
  State<PembelianPage> createState() => _PembelianPageState();
}

class _PembelianPageState extends State<PembelianPage> {
  final _formKey = GlobalKey<FormState>();
  
  // Controller untuk Form
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _hpController = TextEditingController();
  final TextEditingController _lokasiController = TextEditingController();
  final TextEditingController _catatanController = TextEditingController();
  
  DateTime? _tanggalTerpilih;
  String? _metodePembayaran;

  // List Metode Pembayaran
  final List<String> _listPembayaran = ["Transfer Bank (VA)", "E-Wallet (Dana/OVO/Gopay)", "DP / Bayar di Tempat"];

  // Fungsi Pilih Tanggal
  Future<void> _pilihTanggal(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != _tanggalTerpilih) {
      setState(() {
        _tanggalTerpilih = picked;
      });
    }
  }

  @override
  void dispose() {
    _namaController.dispose();
    _hpController.dispose();
    _lokasiController.dispose();
    _catatanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text("Form Pembelian"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ===== RINGKASAN PAKET YANG DIPILIH =====
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.blue.shade200),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          widget.paket.gambar,
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            width: 70,
                            height: 70,
                            color: Colors.grey[300],
                            child: const Icon(Icons.image_not_supported),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.paket.nama,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            const SizedBox(height: 4),
                            Text("Harga: Rp ${widget.paket.harga}", style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.w600)),
                            // Text("Tempat: ${widget.paket.tempat} | Warna: ${widget.paket.warna}", style: const TextStyle(fontSize: 12, color: Colors.grey)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // ===== FORM DATA PEMESAN =====
                const Text("Data Pemesan", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),

                // Input Nama
                TextFormField(
                  controller: _namaController,
                  decoration: InputDecoration(
                    labelText: "Nama Lengkap",
                    prefixIcon: const Icon(Icons.person_outline),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (value) => value!.isEmpty ? "Nama tidak boleh kosong" : null,
                ),
                const SizedBox(height: 12),

                // Input Nomor HP
                TextFormField(
                  controller: _hpController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: "Nomor WhatsApp / HP",
                    prefixIcon: const Icon(Icons.phone_android),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (value) => value!.isEmpty ? "Nomor HP tidak boleh kosong" : null,
                ),
                const SizedBox(height: 12),

                // Input Lokasi / Alamat Acara
                TextFormField(
                  controller: _lokasiController,
                  decoration: InputDecoration(
                    labelText: "Lokasi / Alamat Acara",
                    prefixIcon: const Icon(Icons.location_on_outlined),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (value) => value!.isEmpty ? "Lokasi tidak boleh kosong" : null,
                ),
                const SizedBox(height: 12),

                // Pilih Tanggal Acara
                InkWell(
                  onTap: () => _pilihTanggal(context),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.calendar_today_outlined, color: Colors.grey),
                            const SizedBox(width: 10),
                            Text(
                              _tanggalTerpilih == null 
                                  ? "Pilih Tanggal Acara" 
                                  : "${_tanggalTerpilih!.day}-${_tanggalTerpilih!.month}-${_tanggalTerpilih!.year}",
                              style: TextStyle(color: _tanggalTerpilih == null ? Colors.grey[600] : Colors.black),
                            ),
                          ],
                        ),
                        const Icon(Icons.arrow_drop_down, color: Colors.grey),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Metode Pembayaran
                DropdownButtonFormField<String>(
                  value: _metodePembayaran,
                  hint: const Text("Pilih Metode Pembayaran"),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.payment),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  items: _listPembayaran.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _metodePembayaran = value;
                    });
                  },
                  validator: (value) => value == null ? "Silakan pilih metode pembayaran" : null,
                ),
                const SizedBox(height: 12),

                // Catatan Tambahan
                TextFormField(
                  controller: _catatanController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: "Catatan Tambahan (Opsional)",
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 30),

                // ===== TOMBOL KONFIRMASI =====
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate() && _tanggalTerpilih != null) {
                        // TODO: Proses pengiriman data pemesanan ke API / Database
                        
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Pemesanan Berhasil Diproses!")),
                        );
                        Navigator.pop(context); // Kembali ke Home
                      } else if (_tanggalTerpilih == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Silakan pilih tanggal acara terlebih dahulu")),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    ),
                    child: const Text(
                      "Konfirmasi & Bayar",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}