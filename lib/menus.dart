import 'package:flutter/material.dart';
import 'package:kiosq_web/components/widgets/atglance.dart';
import 'package:kiosq_web/static.dart';

import 'components/widgets/feedbacks.dart';
import 'components/widgets/theteam.dart';
import 'components/widgets/features.dart';
import 'components/widgets/header.dart';
import 'components/widgets/showcase.dart';

class Menus {
  static final Map<String, Widget> _widgets = {
    'Main': Header(),
    'At Glance': AtGlance(),
    'Showcase': Showcase(),
    'Features': Features(),
    'The Team': TheTeam(),
    'Feedback': Feedbacks(),
  };
  static final Map<String, GlobalKey> keys = Map.fromIterables(
      _widgets.keys, Iterable.generate(_widgets.length, (i) => GlobalKey()));

  static List<Widget> navigator(double width) {
    List<Widget> names = [];
    _widgets.forEach((key, value) => names.add(headerButton(key, width)));
    return names;
  }

  static List<Widget> get widgets {
    List<Widget> names = [];
    _widgets.forEach((key, value) => names.add(value));
    return names;
  }

  static Widget headerButton(String text, double width) {
    return Container(
      padding: EdgeInsets.only(left: 10),
      child: TextButton(
          style: Styles.headerBtnStyle,
          onPressed: () {
            Static.hideSidebarCallback.call();
            Scrollable.ensureVisible(keys[text].currentContext,
                duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
          },
          child: Text(text)),
      width: width,
      height: 30,
    );
  }
}
