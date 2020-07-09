import 'package:bestaid/src/pages/expert_opiniontwo.dart';
import 'package:bestaid/src/pages/online_consultancy.dart';
import 'package:flutter/material.dart';

class HomeWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  HomeWidget({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _animation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(_controller);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward();
    return FadeTransition(
      opacity: _animation,
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.only(top: 80, left: 20, right: 20),
        child: ListView(
          children: <Widget>[
            Image.asset(
              'assets/img/logo.png',
            ),
            SizedBox(
              height: 20,
            ),
            Hero(
              tag: 'expert',
              child: MaterialButton(
                elevation: 8,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: Image.asset(
                      'assets/img/expert.png',
                      color: Theme.of(context).accentColor,
                    ),
                    title: Text(
                      'Expert Option',
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ExpertOpinion()));
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            MaterialButton(
              elevation: 8,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  leading: Image.asset(
                    'assets/img/consultancy.png',
                    color: Theme.of(context).accentColor,
                  ),
                  title: Text(
                    'Online Doctor Consultancy',
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ),
              onPressed: () {
                //Navigator.of(context).pushNamed('/OnlineConsultancy');
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => OnlineConsultancy()));
              },
            ),
            SizedBox(
              height: 20,
            ),
            MaterialButton(
              elevation: 8,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  leading: Image.asset(
                    'assets/img/doctor.png',
                  ),
                  title: Text(
                    '1Click Doctor',
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed('/OneClickDoctor');
              },
            ),
          ],
        ),
      )),
    );
  }
}
