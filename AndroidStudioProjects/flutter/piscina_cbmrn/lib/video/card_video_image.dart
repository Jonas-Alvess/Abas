import 'package:flutter/material.dart';
import 'package:piscina_cbmrn/video/upload_video.dart';

import '../Home.dart';
import '../Resenha.dart';
import 'awsome_video.dart';


class CardVideoImage extends StatefulWidget {
  final Map<String, dynamic> media;

  const CardVideoImage({
    Key key,
    this.media,
  }) : super(key: key);

  @override
  _CardVideoImageState createState() => _CardVideoImageState();
}

class _CardVideoImageState extends State<CardVideoImage> {

  //VideoPlayerController _controller;

  double heightVideoCard = 280;

  @override
  void initState() {
    super.initState();
   /* _controller = VideoPlayerController.network(widget.media['link'])
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });*/
  }

  @override
  Widget build(BuildContext context) {
    return antigo();
  }

  antigo() {
    return Card(
      margin: EdgeInsets.only(top:10, bottom: 20, left: 20, right: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 10,
      child: InkWell(
        onTap: () async {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => UploadVideo(
               // media: widget.media,
              ),
            ),
          );
        },

       /* onTap: widget.media['type'] == 'image'
            ? () {

        } : Resenha(),*/
        child: Container(
          height: 400,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              RaisedButton(
                child: Text("LogOut"),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_) => Home()));
                },
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: NetworkImage(
                      widget.media['image'],
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Visibility(
                  visible: widget.media['type'] == 'video',
                  child: Icon(
                    Icons.play_circle_filled,
                    size: 100,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  widget.media['title'],
                  style: TextStyle(fontSize: 17),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(widget.media['description']),
              ),
            ],
          ),
        ),
      ),
    );
  }
}