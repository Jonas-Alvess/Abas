import 'dart:convert';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:piscina_cbmrn/video/card_video_image.dart';
import 'package:piscina_cbmrn/video/upload_imagem.dart';
import 'package:piscina_cbmrn/video/upload_video.dart';

import 'agendar.dart';
import 'meus_agendamentos.dart';

Color color = Colors.white;

class Resenha extends StatefulWidget {
  @override
  _ResenhaState createState() => _ResenhaState();
}

class _ResenhaState extends State<Resenha> {
  // declaração
  List<dynamic> listaApi = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        color:Colors.blue,
        height: 50,
        animationDuration: Duration(microseconds: 400),
        backgroundColor: color,
        items: [

          Container(
              padding: EdgeInsets.only(top:10),
              child: Column(
                children: [
                  Icon(Icons.date_range),
                  Text( "Agendei"),
                ],
              )
          ),

          Container(
              padding: EdgeInsets.only(top:10),
              child: Column(
                children: [
                  Icon(Icons.timer),
                  Text( "Agendar"),
                ],
              )
          ),

          Container(
              padding: EdgeInsets.only(top:10),
              child: Column(
                children: [
                  Icon(Icons.arrow_upward),
                  Text( "Imagem"),
                ],
              )
          ),

          Container(
              padding: EdgeInsets.only(top:10),
              child: Column(
                children: [
                  Icon(Icons.arrow_upward),
                  Text( "Video"),
                ],
              )
          ),

        ],
        onTap: (index){
          setState(() {
            if(index == 0){
              Navigator.push(context, MaterialPageRoute(builder: (_) => MeusAgendamentos()));
            }else if(index == 1){
              Navigator.push(context, MaterialPageRoute(builder: (_) => Agendar()));
            }else if(index == 2){
              Navigator.push(context, MaterialPageRoute(builder: (_) => UploadImagem()));
            }else{
              Navigator.push(context, MaterialPageRoute(builder: (_) => UploadVideo()));
            }
          });
        },
      ),
      body: FutureBuilder(
        // FutureBuilder é componente que renderiza de acordo com a resposta da requisição
        future: http.get(
          'http://jcatechnology.com.br/ss/video.php',
        ), // A chamada para api (ou qualquer chamada assincrona)
        // initialData: http.Response,
        builder: (context, snapshot) {
          // Verifica se foi retornadoa alguma informação da requisição, pois mesmo sem ter terminado a requisição o builder é chamado.
          if (snapshot.hasData) {
            // Convertendo os dados da resposta para mapa
            listaApi = jsonDecode(snapshot.data.body);

            return ListView.builder(
              itemCount: listaApi.length,
              itemBuilder: (context, index) {
                return CardVideoImage(
                  media: listaApi[index],
                );
              },
            );
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}