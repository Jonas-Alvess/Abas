import 'package:flutter/material.dart';
import 'package:piscina_cbmrn/login.dart';
import 'cadastrar_bombeiro.dart';
import 'cadastrar_outros.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            /*Container(
              height: 300,
              width: 300,
              child: CircleAvatar(
                backgroundImage: AssetImage("imagens/gbs.jpeg"
                ),
              ),
            ),*/

            Image.asset("imagens/gbs.jpeg", height: 200,
              width: 200,),


            Padding(padding: EdgeInsets.only(top: 20.0)),
            Text(
              "Você é ?",
              style: TextStyle(
                  fontSize: 40.0,
                  color: Colors.blue
              ),
            ),
            RaisedButton(
              child: Text("Bombeiro Militar",
                  style: TextStyle(color: Colors.white, fontSize: 20)),
              color: Colors.yellow[800],
              padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CadastrarBombeiro(),
                  ),
                );
              },
            ),
            SizedBox(
              height: 3,
            ),
            RaisedButton(
              child: Text(
                "Outros",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              color: Colors.yellow[800],
              padding: EdgeInsets.fromLTRB(25, 5, 25, 5),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CadastrarOutros(),
                  ),
                );
              },
            ),
            RaisedButton(
              child: Text(
                "Já sou cadastrado",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              color: Colors.yellow[800],
              padding: EdgeInsets.fromLTRB(25, 5, 25, 5),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Login(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}