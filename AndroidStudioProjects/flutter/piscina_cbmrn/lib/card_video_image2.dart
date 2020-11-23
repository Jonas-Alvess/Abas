
import 'package:flutter/material.dart';


class CardVideoImage2 extends StatefulWidget {
  final Map<String, dynamic> media;

  const CardVideoImage2({
    Key key,
    this.media,
  }) : super(key: key);

  @override
  _CardVideoImage2State createState() => _CardVideoImage2State();
}

class _CardVideoImage2State extends State<CardVideoImage2> {


  double heightVideoCard = 280;

  @override
  void initState() {
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    return antigo();
  }

  antigo() {
    return Card(
      margin: EdgeInsets.only(bottom: 50),
      elevation: 10,
        child: Container(
          child: Column(
            children: [
              Text(
                widget.media['title'],
                style: TextStyle(fontSize: 17),
              ),
              Text(widget.media['description']),
            ],
          ),
        ),
      );
  }
}