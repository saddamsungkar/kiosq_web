import 'dart:async';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:kiosq_web/components/feedback_controller.dart';

import '../../menus.dart';
import '../strings.dart';

class Feedbacks extends StatefulWidget {
  final String name = 'Feedback';
  Key get key => Menus.keys[name];
  @override
  State<StatefulWidget> createState() {
    return _Feedbacks();
  }
}

class _Feedbacks extends State<Feedbacks> {
  Map<String, List<String>> features = {
    'Smart Search': ['search.svg', 'The Search Engine is Great'],
    'Smart Map': ['map.svg', 'The Map is Great']
  };

  List<String> defaultDesc = ['Feedbacks', Strings.samples];

  CarouselController buttonCarouselController = CarouselController();
  TextEditingController msg = TextEditingController();
  Timer t;
  double rating = 5;
  Widget theIcon = Icon(Icons.send);
  bool fabstate = true;
  Color btnColor = Colors.blue;

  int textSizer = 0;

  void initState() {
    super.initState();
  }

  List<Widget> feedbackList = [];

  void getFeedback(double size) {
    FeedbackController.get().then((value) => setState(() {
          feedbackList = List.generate(value.length, (index) {
            return Builder(
              builder: (BuildContext context) {
                return Padding(
                    padding: EdgeInsets.all(25),
                    child: GestureDetector(
                      onTap: () => listGenerator(size),
                      child: Card(
                        elevation: 20,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Container(
                          width: size - 50,
                          padding: EdgeInsets.all(25),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                dateFormatter(value[index].date),
                                style: TextStyle(color: Colors.grey),
                              ),
                              Text(
                                value[index].msg,
                                maxLines: 5,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                              ),
                              RatingBarIndicator(
                                rating: value[index].rating,
                                itemBuilder: (context, index) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                itemCount: 5,
                                itemSize: 20.0,
                                direction: Axis.horizontal,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ));
              },
            );
          }).toList();
        }));
  }

  void listGenerator(double size) {
    setState(() {
      feedbackList = [
        Builder(
          builder: (BuildContext context) {
            return Padding(
              padding: EdgeInsets.all(25),
              child: GestureDetector(
                onTap: () => getFeedback(size),
                child: Card(
                    elevation: 20,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Container(
                        width: size - 50,
                        padding: EdgeInsets.all(25),
                        child: Center(
                          child: SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator()),
                        ))),
              ),
            );
          },
        )
      ];
    });
    getFeedback(size);
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    if (feedbackList.isEmpty) listGenerator(size);
    return Material(
      color: Colors.blue,
      child: Container(
          padding: EdgeInsets.only(top: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: Text(widget.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ))),
              SizedBox(
                height: 20,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: Text(
                    Strings.feedback,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.8), fontSize: 20),
                  )),
              Padding(
                  padding: EdgeInsets.only(left: 50, right: 50, top: 25),
                  child: Material(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      elevation: 5,
                      child: Container(
                          padding: EdgeInsets.all(25),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.white),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Give us your input and suggestions so we can grow together',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(top: 25),
                                    child: TextField(
                                      controller: msg,
                                      maxLines: 5,
                                      maxLength: 200,
                                      onChanged: (str) {
                                        setState(() {
                                          textSizer = str.length;
                                        });
                                      },
                                      decoration: new InputDecoration(
                                          border: new OutlineInputBorder(
                                            borderRadius:
                                                const BorderRadius.all(
                                              const Radius.circular(25),
                                            ),
                                          ),
                                          hintText:
                                              "Type your inputs and suggestions here",
                                          hintStyle:
                                              TextStyle(color: Colors.grey)),
                                    )),
                                Text(
                                  'Give us rating!',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      RatingBar.builder(
                                        initialRating: rating,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemPadding: EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating) {
                                          this.rating = rating;
                                        },
                                      ),
                                      FloatingActionButton(
                                          backgroundColor: btnColor,
                                          onPressed: (fabstate)
                                              ? () {
                                                  setState(() {
                                                    btnColor = Colors.grey;
                                                    fabstate = false;
                                                    theIcon =
                                                        CircularProgressIndicator(
                                                      backgroundColor:
                                                          Colors.white,
                                                    );
                                                  });
                                                  FeedbackController.send(
                                                          msg.value.text,
                                                          rating)
                                                      .then((value) {
                                                    print(value);
                                                    setState(() {
                                                      if (value) {
                                                        btnColor = Colors.green;
                                                        theIcon =
                                                            Icon(Icons.check);
                                                        msg.clear();
                                                        listGenerator(size);
                                                      } else {
                                                        btnColor = Colors.red;
                                                        theIcon =
                                                            Icon(Icons.cancel);
                                                      }
                                                    });

                                                    Timer(Duration(seconds: 1),
                                                        () {
                                                      setState(() {
                                                        btnColor = Colors.blue;
                                                        theIcon =
                                                            Icon(Icons.send);
                                                        fabstate = true;
                                                      });
                                                    });
                                                  });
                                                }
                                              : null,
                                          child: theIcon),
                                    ])
                              ])))),
              CarouselSlider(
                items: feedbackList,
                carouselController: buttonCarouselController,
                options: CarouselOptions(
                    viewportFraction: 475 / size,
                    height: 250,
                    autoPlay: true,
                    initialPage: 0),
              ),
              SizedBox(
                height: 25,
              ),
            ],
          )),
    );
  }

  String dateFormatter(DateTime date) {
    String day;
    String month;
    switch (date.weekday) {
      case DateTime.sunday:
        day = 'Sunday';
        break;
      case DateTime.monday:
        day = 'Monday';
        break;
      case DateTime.tuesday:
        day = 'Tuesday';
        break;
      case DateTime.wednesday:
        day = 'Wednesday';
        break;
      case DateTime.thursday:
        day = 'Thursday';
        break;
      case DateTime.friday:
        day = 'Friday';
        break;
      case DateTime.saturday:
        day = 'Saturday';
        break;
    }

    switch (date.month) {
      case DateTime.january:
        month = 'January';
        break;
      case DateTime.february:
        month = 'February';
        break;
      case DateTime.march:
        month = 'March';
        break;
      case DateTime.april:
        month = 'April';
        break;
      case DateTime.may:
        month = 'May';
        break;
      case DateTime.june:
        month = 'June';
        break;
      case DateTime.july:
        month = 'July';
        break;
      case DateTime.august:
        month = 'August';
        break;
      case DateTime.september:
        month = 'September';
        break;
      case DateTime.october:
        month = 'October';
        break;
      case DateTime.november:
        month = 'November';
        break;
      case DateTime.december:
        month = 'December';
        break;
    }

    return '$day, ${date.day} $month ${date.year}. at ${(date.hour % 12 < 10) ? '0' : ''}${date.hour % 12}:${date.minute} ${(date.hour / 12 < 1) ? 'AM' : 'PM'}';
  }
}
