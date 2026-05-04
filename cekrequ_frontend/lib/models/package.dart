import 'package:cekrequ_frontend/models/feature.dart';

class Package {
  final String nama;
  final int harga;
  final List<String> gambar;
  final List<Feature> fiturList;

  Package({
    required this.nama,
    required this.harga,
    required this.gambar,
    required this.fiturList,
  });

  factory Package.fromJson(Map<String, dynamic> json){
    return Package(nama: json['name'], harga: json['price'], gambar: json['images'], fiturList: Feature.getListFromJson(json['features']));
  }

}
