import 'package:flutter_filmler_http/Kategoriler.dart';

class KatCevap{
  int success;
  List<Kategoriler> kategoriListesi;

  KatCevap(this.success, this.kategoriListesi);

  factory KatCevap.fromJson(Map<String,dynamic> json){
    var jsonDizisi = json["kategoriler"] as List;
    List<Kategoriler> yerelKategoriListesi = jsonDizisi.map((nesne) => Kategoriler.fromJson(nesne)).toList();
    return KatCevap(json["success"] as int, yerelKategoriListesi);
  }
}