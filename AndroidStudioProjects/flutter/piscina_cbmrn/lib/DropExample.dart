import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DropExample extends StatefulWidget {
  final DropdownController controller;
  final Function onChange;

  const DropExample({
    Key key,
    this.controller,
    this.onChange,
  }) : super(key: key);

  @override
  _DropExampleState createState() => _DropExampleState();
}

class _DropExampleState extends State<DropExample> {
  String _value = 'Horário';

  List<Map<String, dynamic>> estados = [
    {'hora': '', 'id': 1}
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //child: Container(
      padding: EdgeInsets.all(20.0),
      child: FutureBuilder(
          future: http.get('http://jcatechnology.com.br/piscina/spinner2.php'),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List response = jsonDecode(snapshot.data.body);

              return DropdownButton(
                value: widget.controller.value,
                items: response
                    .map((e) => DropdownMenuItem(
                  child: Text(e['hora']),
                  value: e['hora'],
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    widget.controller.value = value;
                  });

                  widget.onChange();
                },
              );
            }

            return Container();
          }),
      // ),
    );
  }

  // outra forma de fazer
  gerarListaEstados() {
    List<DropdownMenuItem<int>> auxiliar = [];

    estados.forEach((estado) {
      auxiliar.add(DropdownMenuItem(
        child: Text(estado['hora']),
        value: estado['id'],
      ));
    });

    return auxiliar;
  }
}

class DropdownController {
  String value = '';
}