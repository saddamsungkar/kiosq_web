import 'package:flutter/material.dart';
import 'package:kiosq_web/components/strings.dart';
import 'package:kiosq_web/components/video_link_parser.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../../menus.dart';

class AtGlance extends StatefulWidget {
  final String name = 'At Glance';
  Key get key => Menus.keys[name];
  @override
  State<StatefulWidget> createState() {
    return _AtGlance();
  }
}

class _AtGlance extends State<AtGlance> {
  Widget videoChild = Center(
      child: SizedBox(
    height: 20,
    width: 20,
    child: CircularProgressIndicator(),
  ));

  @override
  void initState() {
    super.initState();
    VideoParser.get().then((value) {
      List<String> splitter = value.split('=');
      print(splitter[splitter.length - 1].replaceAll('"',''));
      setState(() {
        videoChild = YoutubePlayerIFrame(
          controller: YoutubePlayerController(
            initialVideoId: splitter[splitter.length - 1].replaceAll('"',''),
            params: YoutubePlayerParams(
                showControls: true,
                showFullscreenButton: true,
                autoPlay: false),
          ),
          aspectRatio: 16 / 9,
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.white,
        child: Container(
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.all(50),
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.only(bottom: 50),
                  height: 500,
                  child: videoChild),
              Text(widget.name,
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(
                height: 20,
              ),
              Text(
                Strings.videoDescription,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black.withOpacity(0.8), fontSize: 20),
              ),
            ],
          ),
        ));
  }
}
