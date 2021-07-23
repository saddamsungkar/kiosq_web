import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../menus.dart';
import '../static.dart';

class SideBar extends StatefulWidget {
  final Function callback;

  const SideBar({Key key, this.callback}) : super(key: key);
  @override
  Key get key => Key('Main');
  @override
  State<StatefulWidget> createState() {
    return _SideBar();
  }
}

class _SideBar extends State<SideBar> with SingleTickerProviderStateMixin {
  Curve curve = Curves.easeInOut;
  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width > Menus.widgets.length * 110 + 500) {
      if (Static.sidebarState == true) {
        Static.sidebarEnd = 1;
        Static.sidebarStart = 1;
        setState(() {
          Static.sidebarState = false;
          if (Static.scrollController.offset == 0) Static.headerState = false;
        });
      }
    }
    return TweenAnimationBuilder(
      tween: Tween<Offset>(
          begin: Offset(Static.sidebarStart, 0),
          end: Offset(Static.sidebarEnd, 0)),
      duration: Duration(milliseconds: 250),
      curve: curve,
      builder: (context, offset, child) {
        return FractionalTranslation(
          translation: offset,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: widget.callback,
                  child: Container(
                width: MediaQuery.of(context).size.width - 200,
                height: MediaQuery.of(context).size.height,
                color: Colors.transparent
              )),
              child
            ],
          ),
        );
      },
      child: Material(
        elevation: 10,
        child: Container(
          width: 200,
          color: Colors.white,
          child: Column(children: [
            SizedBox(
              height: 70,
            ),
            Wrap(
                direction: Axis.vertical,
                spacing: 20,
                children: Menus.navigator(180))
          ]),
        ),
      ),
      onEnd: () {
        if (Static.sidebarStart == 1)
          Static.sidebarStart = 0;
        else
          Static.sidebarStart = 1;
      },
    );
  }
}
