import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../menus.dart';

class Footer extends StatefulWidget {
  Key get key => Menus.keys['Footer'];
  @override
  State<StatefulWidget> createState() {
    return _Footer();
  }
}

class _Footer extends State<Footer> {
  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.blue.shade900,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
          alignment: Alignment.bottomLeft,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                      children:[
                        SizedBox(
                          height: 20,
                            width: 20,
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                                child:GestureDetector(
                              onTap: () async {
                                String _url = 'https://github.com/alfianisnan26/kiosq_web';
                                await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
                              },
                                child:Image.asset('assets/svg/github.png', color: Colors.white.withOpacity(0.8),)))),
                        Visibility(
                      visible: (MediaQuery.of(context).size.width < 650)
                          ? false
                          : true,
                      child: Padding(
                        padding: EdgeInsets.only(left: 25),
                          child:Text(
                          'KiosQ App Showcase 1.02 [Beta] | KiosQ App 0.2 [Alpha]',
                          overflow: TextOverflow.fade,
                      style: TextStyle(color: Colors.white.withOpacity(0.8)))))]),
                  Text('KiosQ Team © 2021',
                  style: TextStyle(color: Colors.white.withOpacity(0.8)),)
                ],
              )
            ],
          ),
        ));
  }
}
