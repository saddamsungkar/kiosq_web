import 'package:flutter/material.dart';
import 'package:kiosq_web/static.dart';

import 'components/widgets/footer.dart';
import 'components/sidebar.dart';
import 'components/widgets/header.dart';
import 'menus.dart';

void main() {
  runApp(WebApp());
}

class WebApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KiosQ App Showcase',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'ProductSans'),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPage createState() => _MainPage();
}

class _MainPage extends State<MainPage> {
  double lastScroll = 0;
  _scrollListener() {
    setState(() {
      if (Static.scrollController.offset > lastScroll)
        Static.headerEnd = -1;
      else
        Static.headerEnd = 0;
      lastScroll = Static.scrollController.offset;
      if (Static.scrollController.offset > 0)
        Static.headerState = true;
      else if (!Static.sidebarState) Static.headerState = false;
    });
  }

  @override
  void initState() {
    Static.scrollController = ScrollController();
    Static.scrollController.addListener(_scrollListener);
    Static.hideSidebarCallback = toggleSidebar;
    super.initState();
  }

  @override
  void dispose() {
    Static.scrollController.dispose();
    super.dispose();
  }

  void toggleSidebar() {
    setState(() {
      Static.sidebarState = !Static.sidebarState;
      if (Static.sidebarState) {
        Static.sidebarEnd = 0;
        Static.headerState = true;
      } else {
        Static.sidebarEnd = 1;
        if (Static.scrollController.offset == 0) Static.headerState = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
        child: Stack(children: [
          SingleChildScrollView(
            controller: Static.scrollController,
            child: Column(
              children: [
                Column(children: Menus.widgets),
                Footer(),
              ],
            ),
          ),
          SideBar(callback: toggleSidebar),
          DynamicHeader(
            callback: toggleSidebar,
          ),
        ]));
  }
}
