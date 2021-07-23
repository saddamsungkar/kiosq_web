import 'dart:async';
import 'dart:ui';
import 'dart:math';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../menus.dart';
import '../../static.dart';
import '../strings.dart';

class TheTeam extends StatefulWidget {
  final String name = 'The Team';
  Key get key => Menus.keys[name];
  @override
  State<StatefulWidget> createState() {
    return _TheTeam();
  }
}

class _TheTeam extends State<TheTeam> {
  Map<String, List<String>> features = {
    'Alfian Badrul Isnan': ['alfian.jpg', 'alf.ian_'],
    'Fadly Ahmad Firdausy': ['fadly.jpg', 'freaquill'],
    'Muhammad Saddam': ['saddam.jpg', 'saddamsungkar'],
    'Muhammad Zidan Arsyad': ['zidan.jpg', 'zidan.arsyad'],
    'Ricky Kusnadi': ['ricky.jpg', 'rc_kusnadi']
  };
  CarouselController buttonCarouselController = CarouselController();

  List<bool> _visiblity;
  List<Timer> _timerShow;
  List<Widget> qWidget = List.generate(
      Strings.quotes.length,
      (index) => Text(
            Strings.quotes[index],
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black.withOpacity(0.8), fontSize: 20),
          ));

  void initState() {
    super.initState();
    _visiblity = List.generate(features.length, (index) => false);
    _timerShow = List.generate(features.length, (index) => null);
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Material(
        color: Colors.white,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 50),
          alignment: Alignment.bottomLeft,
          child: Column(
            children: [
              CarouselSlider(
                items: List.generate(features.length, (index) {
                  return Builder(
                    builder: (BuildContext context) {
                      return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _visiblity[index] = true;
                                });
                                if (_timerShow[index] != null &&
                                    _timerShow[index].isActive)
                                  _timerShow[index].cancel();
                                _timerShow[index] =
                                    Timer(const Duration(seconds: 4), () {
                                  setState(() {
                                    _visiblity[index] = false;
                                  });
                                });
                              },
                              child: MouseRegion(
                                onEnter: (p) {
                                  setState(() {
                                    _visiblity[index] = true;
                                  });
                                },
                                onExit: (p) {
                                  setState(() {
                                    _visiblity[index] = false;
                                    if (_timerShow[index] != null &&
                                        _timerShow[index].isActive)
                                      _timerShow[index].cancel();
                                  });
                                },
                                child: Material(
                                  elevation: 5,
                                  color: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(200),
                                  ),
                                  child: Container(
                                      height: 200,
                                      width: 200,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              fit: BoxFit.contain,
                                              image: AssetImage(
                                                  'assets/profiles/${(features[features.keys.toList()[index]])[0]}'))),
                                      child: AnimatedOpacity(
                                          duration: Duration(milliseconds: 125),
                                          opacity:
                                              (_visiblity[index]) ? 1.0 : 0.0,
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.white
                                                      .withOpacity(0.8)),
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          200),
                                                  child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              features.keys
                                                                      .toList()[
                                                                  index],
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Text(
                                                              features[features
                                                                      .keys
                                                                      .toList()[
                                                                  index]][1],
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          0.5)),
                                                            ),
                                                          ]))))),
                                ),
                              ));
                    },
                  );
                }).toList(),
                carouselController: buttonCarouselController,
                options: CarouselOptions(
                    height: 200,
                    reverse: true,
                    enableInfiniteScroll: false,
                    autoPlay: false,
                    enlargeCenterPage: false,
                    viewportFraction: 250 / size,
                    initialPage: 2,
                    aspectRatio: 9 / 16),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: Text('Meet Our Team',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.black))),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: AnimatedSwitcher(
                    duration: const Duration(seconds: 3),
                    child: CarouselSlider(
                      items: List.generate(features.length, (index) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                                width: size - 50,
                                child:Text(
                                Strings.quotes[index], textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.black.withOpacity(0.8), fontSize: 20),
                              )
                            );
                          },
                        );
                      }).toList(),
                      carouselController: buttonCarouselController,
                      options: CarouselOptions(
                          height: 75,
                          autoPlay: true,
                          enlargeCenterPage: false,
                          autoPlayCurve: Curves.easeInOut,
                          autoPlayInterval: Duration(minutes: 1),
                          viewportFraction: 1,),
                    ),),
              ),
            ],
          ),
        ));
  }
}
