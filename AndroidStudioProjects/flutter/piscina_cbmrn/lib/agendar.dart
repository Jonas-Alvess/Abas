import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pattern_formatter/date_formatter.dart';
import 'package:http/http.dart' as http;
import 'DropExample.dart';
import 'Home.dart';


class Agendar extends StatefulWidget {
  @override
  _AgendarState createState() => _AgendarState();
}

class _AgendarState extends State<Agendar> {

    TextEditingController dia = TextEditingController();
    //TextEditingController horario = TextEditingController();
    DropdownController valueDropdown = DropdownController();

    String msg = '';

    Future register() async {
      var url = "http://jcatechnology.com.br/piscina/agendar.php";
      //var url = "http://192.168.1.141/piscina/agendar.php";
      var response = await http.post(url, body: {
        "dia": dia.text,
        "horario": valueDropdown.value,
      //"horario": horario.text,

      });
      var data = json.decode(response.body);
      if (data == "Error") {
        Fluttertoast.showToast(
          msg: "Horário esgotado",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          fontSize: 20.0,
        );
      } else {
        Fluttertoast.showToast(
          msg: "Agendamento realizado com sucesso!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          fontSize: 20.0,
        );
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Agendar(),),);
      }
    }

    @override
    void initState() {
      super.initState();

      this.valueDropdown.value = 'Horário';
    }
      @override
      Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text(
          'CBMRN',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[100]),
        ),
      ),

      body: SingleChildScrollView(
        child: Container(
           child: Card(
              child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Escolha a data',
                          hintText: 'dd/MM/yyyy',
                          prefixIcon: Icon(Icons.date_range),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        keyboardType: TextInputType.number,

                        inputFormatters: [
                          WhitelistingTextInputFormatter(RegExp(r'\d+|-|/')),
                          DateInputFormatter(),
                        ],
                        style: TextStyle(fontSize: 16.0, color: Colors.black),

                        controller: dia,
                      ),
                    ),
                    DropExample(

                      controller: this.valueDropdown,
                      // onChange: () {
                      //   setState(() {});
                      // },
                    ),
                    MaterialButton(
                      color: Colors.blue,
                      child: Text('Agendar',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      onPressed: () {
                        //log(this.valueDropdown.value);
                        register();
                      },
                    ),
                    new Padding(padding: EdgeInsets.only(top: 40.0)),
                    RaisedButton(
                      child: Text("LogOut"),
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_) => Home()));
                      },
                    ),
                  ]
               )
           )
        )
      ),
    );
  }
}
