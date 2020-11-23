import 'package:flutter/material.dart';

class MeusAgendamentos extends StatefulWidget {
  @override
  _MeusAgendamentosState createState() => _MeusAgendamentosState();
}

class _MeusAgendamentosState extends State<MeusAgendamentos> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top:50),
      child: Text("Horários", style: TextStyle(color: Colors.white),),
    );
  }
}
