import 'package:bestaid/elements/DrawerWidget.dart';
import 'package:bestaid/src/pages/expert_opinion.dart';
import 'package:flutter/material.dart';


import 'home.dart';

// ignore: must_be_immutable
class PagesTestWidget extends StatefulWidget {
  int currentTab;
  Widget currentPage = HomeWidget();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  PagesTestWidget({
    Key key,
    this.currentTab,
  }) {
    currentTab = currentTab != null ? currentTab : 2;
  }

  @override
  _PagesTestWidgetState createState() {
    return _PagesTestWidgetState();
  }
}

class _PagesTestWidgetState extends State<PagesTestWidget> {
  initState() {
    super.initState();
    _selectTab(widget.currentTab);
  }

  @override
  void didUpdateWidget(PagesTestWidget oldWidget) {
    _selectTab(oldWidget.currentTab);
    super.didUpdateWidget(oldWidget);
  }

  void _selectTab(int tabItem) {
    setState(() {
      widget.currentTab = tabItem;
      switch (tabItem) {
        case 1:
          widget.currentPage = ExpertOpinion(parentScaffoldKey: widget.scaffoldKey,);
          break;
        case 2:
          widget.currentPage = HomeWidget(parentScaffoldKey: widget.scaffoldKey,);

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: widget.scaffoldKey,
        drawer: DrawerWidget(),
        body: widget.currentPage,
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Theme.of(context).accentColor,
          selectedFontSize: 16,
          unselectedFontSize: 0,
          iconSize: 36,
          elevation: 0,
          backgroundColor: Colors.white,
          selectedIconTheme: IconThemeData(size: 40, color: Theme.of(context).accentColor),
          unselectedItemColor: Color(0xFF079E8A),
          currentIndex: widget.currentTab,
          onTap: (int i) {
            this._selectTab(i);
          },
          // this will be set when a new tab is tapped
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.person),
              title: Container(height: 0,),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.dashboard),
              title: Container(height: 0,),
            ),
            BottomNavigationBarItem(
              title: Container(height: 0,),
                icon: Container(
//                  decoration: BoxDecoration(
//                    color: Theme.of(context).accentColor,
//                    borderRadius: BorderRadius.all(
//                      Radius.circular(50),
//                    ),
//                    boxShadow: [
//                      BoxShadow(
//                          color: Theme.of(context).accentColor.withOpacity(0.4), blurRadius: 40, offset: Offset(0, 15)),
//                      BoxShadow(
//                          color: Theme.of(context).accentColor.withOpacity(0.4), blurRadius: 13, offset: Offset(0, 3))
//                    ],
//                  ),
                  child: new Icon(Icons.home),
                )
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.shopping_cart),
              title: Container(height: 0,),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu),
              title: Container(height: 0,),
            ),
          ],
        ),
      ),
    );
  }
}
