class Paket {
  String nama;
  String tempat;
  // String warna;
  int harga;
  String gambar;

  // TAMBAHAN
  String deskripsi;
  List<String> benefits;

  Paket({
    required this.nama,
    required this.tempat,
    // required this.warna,
    required this.harga,
    required this.gambar,

    // TAMBAHAN
    required this.deskripsi,
    required this.benefits,
  });
}