import 'dart:developer';
import 'package:awsome_video_player/awsome_video_player.dart';
import 'package:flutter/material.dart';

class AwsomeVideo extends StatefulWidget {
  final String url;

  const AwsomeVideo({Key key, this.url}) : super(key: key);

  @override
  _AwsomeVideoState createState() => _AwsomeVideoState();
}

class _AwsomeVideoState extends State<AwsomeVideo> {
  @override
  Widget build(BuildContext context) {
    return AwsomeVideoPlayer(
      widget.url,
      videoStyle: VideoStyle(
        playIcon: Icon(
          Icons.play_circle_filled,
          color: Colors.white,
        ),
        showPlayIcon: true,

        videoTopBarStyle: VideoTopBarStyle(

        ),
        videoControlBarStyle: VideoControlBarStyle(
          // backgroundColor: Colors.yellow,
          // barBackgroundColor: Colors.white,
          // bufferedColor: Colors.yellow,
          timeFontColor: Colors.blue,

          progressStyle: VideoProgressStyle(
            bufferedColor: Colors.yellow,
            dragBarColor: Colors.blue,
            backgroundColor: Colors.green,
            playedColor: Colors.white,
          ),
        ),
      ),
      // Evento acionado quando o vídeo é iniciado
      oninit: (video) {
        log('video iniciado');
      },
      // evento acionado quando o video finaliza
      onended: (video) {
        log('sai do modo tela cheia');
      },
      // evento acionado quando o video é colocado em tela cheai
      onfullscreen: (t) {
        log('entrou em full');
      },
    );
  }
}