import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kiosq_web/components/strings.dart';
import '../../menus.dart';

class Showcase extends StatefulWidget {
  final String name = 'Showcase';
  Key get key => Menus.keys[name];
  @override
  State<StatefulWidget> createState() {
    return _Showcase();
  }
}

class _Showcase extends State<Showcase> {

  CarouselController buttonCarouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Material(
        color: Colors.yellow,
        child: Container(
          alignment: Alignment.bottomCenter,
      padding: EdgeInsets.symmetric(vertical: 50),
      child: Column(
        children: [
          CarouselSlider(
            items: List.generate(8, (index) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      child: Image.asset('assets/png/showcase/sc_${index + 1}.png')
                  );
                },
              );
            }).toList(),
            carouselController: buttonCarouselController,
            options: CarouselOptions(
              height: 400,
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 250/size,
              initialPage: 0,
              aspectRatio: 9/16
            ),
          ),
          SizedBox(height: 20,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child:Text(widget.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ))),
          SizedBox(height: 20,),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child:Text(Strings.showcaseDescription,
                textAlign: TextAlign.center,style: TextStyle(fontSize: 20),)),
        ],
      ),
    ));
  }
}
