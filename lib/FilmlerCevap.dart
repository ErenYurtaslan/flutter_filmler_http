import 'package:flutter_filmler_http/Filmler.dart';

class FilmCevap{
  int success;
  List<Filmler> filmlerListesi;

  FilmCevap(this.success, this.filmlerListesi);

  factory FilmCevap.fromJson(Map<String,dynamic> json){
    var jsonDizisi = json["filmler"] as List;
    List<Filmler> yerelFilmlerListesi = jsonDizisi.map((nesne) => Filmler.fromJson(nesne)).toList();
    return FilmCevap(json["success"] as int, yerelFilmlerListesi);
  }
}