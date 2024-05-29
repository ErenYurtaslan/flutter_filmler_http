import 'package:flutter/material.dart';
import 'package:flutter_filmler_http/DetaySayfa.dart';
import 'package:flutter_filmler_http/Filmler.dart';
import 'package:flutter_filmler_http/FilmlerCevap.dart';
import 'package:flutter_filmler_http/Kategoriler.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class FilmlerSayfa extends StatefulWidget {

  Kategoriler kategori;


  FilmlerSayfa({super.key, required this.kategori});

  @override
  State<FilmlerSayfa> createState() => _FilmlerSayfaState();
}

class _FilmlerSayfaState extends State<FilmlerSayfa> {



  List<Filmler> parseF_Cevap(String cevap){
    return FilmCevap.fromJson(json.decode(cevap)).filmlerListesi;
  }




  Future<List<Filmler>> filmleriGoster(String kategori_id) async{
    var url = Uri.parse("http://kasimadalan.pe.hu/filmler/filmler_by_kategori_id.php");
    var veri ={"kategori_id" : kategori_id};
    var yanit = await http.post(url, body: veri);
    return parseF_Cevap(yanit.body);
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(




      appBar: AppBar(
        title: Text("Filmler: ${widget.kategori.kategori_ad}"),
      ),





      body: FutureBuilder<List<Filmler>>(
          future: filmleriGoster(widget.kategori.kategori_id),
          builder: (context, snapshot){
            if(snapshot.hasData){
              var filmlerListesi = snapshot.data;
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio:  4/7,),
                itemCount: filmlerListesi!.length,
                itemBuilder: (context, index){
                  var film = filmlerListesi[index];
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> Detay(film: film)));
                    },
                    child: Card(
                      color: Colors.blue.shade300,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network("http://kasimadalan.pe.hu/filmler/resimler/${film.film_resim}"),
                          ),
                          Text(film.film_ad, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold ),
                          ),
                        ],
                      ),
                    ),
                  );
                },

              );
            }else{
              return const Center();
            }
          }
      ),






    );
  }
}
