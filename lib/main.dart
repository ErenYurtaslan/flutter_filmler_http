import 'package:flutter_filmler_http/FilmlerSayfa.dart';
import 'package:flutter_filmler_http/KategoriCevap.dart';
import 'package:flutter_filmler_http/Kategoriler.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  const Anasayfa(),
    );
  }
}

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});



  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {

  List<Kategoriler> parseK_Cevap(String cevap){
    return KatCevap.fromJson(json.decode(cevap)).kategoriListesi;
  }

  Future<List<Kategoriler>> tumKategorileriGoster() async{
    var url = Uri.parse("http://kasimadalan.pe.hu/filmler/tum_kategoriler.php");
    var yanit = await http.get(url);
    return parseK_Cevap(yanit.body);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(


      appBar: AppBar(
        title: const Text("Kategoriler"),
      ),






      body: FutureBuilder<List<Kategoriler>>(
          future: tumKategorileriGoster(),
          builder: (context, snapshot){
            if(snapshot.hasData){
              var kategoriListesi = snapshot.data;
              return ListView.builder(
                itemCount: kategoriListesi!.length,
                itemBuilder: (context, index){
                  var kategori = kategoriListesi[index];
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>FilmlerSayfa(kategori: kategori,)));
                    },
                    child: Card(
                      child: SizedBox(
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(kategori.kategori_ad),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }else{
              return  Container(
                color: Colors.indigo.shade200,
              );
            }
          }
      ),






    );
  }
}