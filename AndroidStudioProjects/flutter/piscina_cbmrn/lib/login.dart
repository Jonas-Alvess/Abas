import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:json_store/json_store.dart';

import 'AdminPage.dart';
import 'Resenha.dart';
import 'agendar.dart';

String nome = '';
String id = '';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = new TextEditingController();
  TextEditingController senha = new TextEditingController();
  // Plugin de armazenamento local
  JsonStore jsonStore = JsonStore();

  String msg = '';

  String nome = '';
  String id = '';



  Future<List> _login() async {
    final response =
    await http.post("http://jcatechnology.com.br/piscina/login.php", body: {
    //await http.post("http://192.168.1.141/piscina/login_bombeiro.php", body: {
    "email": email.text,
    "senha": senha.text,
     //"id":id,
     });

    var datauser = json.decode(response.body);
   /* var datauser = [
      {
        'level': 'admin',
        'username': 'firmino',
        'id_usuario': '12'
      }
    ];*/

    if (datauser.length == 0) {
      setState(() {
        msg = "Dados incorretos";
      });
    } else {
      if (datauser[0]['level'] == 'admin') {
        // Navigator.pushReplacementNamed(context, '/Home');
        Navigator.push(context, MaterialPageRoute(builder: (_) => Resenha()));
      } else if (datauser[0]['level'] == 'member') {
        // Navigator.pushReplacementNamed(context, '/MemberPage');
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => Resenha()));
      }
      // Salvar os dados do usuario no local
      await jsonStore.setItem('user', datauser[0]);

      setState(() {
        email = datauser[0]['email'];
        senha = datauser[0]['senha'];
      });
    }

    return datauser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,

        //appBar: AppBar(title: Text("Login"),),

        body: SingleChildScrollView(
          padding: EdgeInsets.only(top: 70, left: 30, right: 30),
          child: Column(
            children: <Widget>[
              new Padding(padding: EdgeInsets.only(top: 50.0)),
              Image.asset("imagens/gbs.jpeg", height: 200,
                width: 200,),


              Padding(padding: EdgeInsets.only(top: 20.0)),
              new TextFormField(
                controller: email,
                decoration: new InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(color: Colors.blueAccent)),
                  labelText: "Email",
                  prefixIcon: const Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                  fillColor: Colors.black,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: new BorderSide(color: Colors.black),
                  ),
                  //fillColor: Colors.green
                ),
                keyboardType: TextInputType.emailAddress,
                style: new TextStyle(
                  fontFamily: "Poppins",
                  color: Colors.black,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
//                child: Text('Hello World!'),
              ),
              new TextFormField(
                controller: senha,
                obscureText: true,
                decoration: new InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(color: Colors.blueAccent)),
                  labelText: "Senha",
                  prefixIcon: const Icon(
                    Icons.remove_red_eye,
                    color: Colors.black,
                  ),
                  fillColor: Colors.black,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: new BorderSide(),
                  ),
                  //fillColor: Colors.green
                ),
                style: new TextStyle(
                  fontFamily: "Poppins",
                  color: Colors.black,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(12.0),
//                child: Text('Hello World!'),
              ),
              RaisedButton(
                child: Text("Login",
                    style: TextStyle(color: Colors.white, fontSize: 20)),
                color: Colors.yellow[800],
                padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32)),
                onPressed: () {
                  _login();
                },
              ),
              SizedBox(
                height: 3,
              ),

              Text(
                msg,
                style: TextStyle(fontSize: 20.0, color: Colors.red),
              )
            ],
          ),
        ));
  }

  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }
}