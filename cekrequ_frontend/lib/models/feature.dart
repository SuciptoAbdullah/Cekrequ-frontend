// ignore_for_file: non_constant_identifier_names

class Feature{
  final String nama;
  final int quantitas;

  Feature({required this.nama, required this.quantitas});

  factory Feature.fromJson(Map<String, dynamic> json){
    return Feature(nama: json['name'], quantitas: json['quantity']);
  }

  static List<Feature> getListFromJson(List<Map<String, dynamic>> jsonList){
    List<Feature> list = [];
    for(int i=0; i<jsonList.length; i++){
      Feature FeatureItem = Feature.fromJson(jsonList[i]);
      list.add(FeatureItem);
    }
    return list;
  }

}