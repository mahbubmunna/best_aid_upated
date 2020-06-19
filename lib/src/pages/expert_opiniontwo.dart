import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpertOpinion extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  ExpertOpinion({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _ExpertOpinionState createState() => _ExpertOpinionState();
}

class _ExpertOpinionState extends State<ExpertOpinion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
          ),
          title: Text('Back'),
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 100, left: 20, right: 20),
          child: ListView(
            children: <Widget>[

              Hero(
                tag: 'expert',
                child: MaterialButton(
                  elevation: 20,
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
                      trailing: Transform.rotate(
                          angle: 90 * math.pi / 180,
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: Theme.of(context).accentColor,
                          )),
                    ),
                  ),
                  onPressed: () {},
                ),
              ),
              SizedBox(
                height: 80,
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  MaterialButton(
                      color: Colors.white,
                      textColor: Theme.of(context).accentColor,
                      shape: StadiumBorder(),
                      onPressed: () {
                        Navigator.of(context).pushNamed('/PostProblem');
                      },
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            SizedBox(
                              width: 30,
                            ),
                            Text(
                              'Post Your Problem',
                              textScaleFactor: 1.5,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Icon(Icons.arrow_forward_ios)
                          ],
                        ),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  MaterialButton(
                      color: Colors.white,
                      textColor: Theme.of(context).accentColor,
                      shape: StadiumBorder(),
                      onPressed: () {
                        Navigator.of(context).pushNamed('/YourHistory');
                      },
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            SizedBox(
                              width: 30,
                            ),
                            Text(
                              'Your History',
                              textScaleFactor: 1.5,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Icon(Icons.arrow_forward_ios)
                          ],
                        ),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  MaterialButton(
                      color: Colors.white,
                      textColor: Theme.of(context).accentColor,
                      shape: StadiumBorder(),
                      onPressed: () {
                        Navigator.of(context).pushNamed('/NewsFeed');
                      },
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            SizedBox(
                              width: 30,
                            ),
                            Text(
                              'News Feed',
                              textScaleFactor: 1.5,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Icon(Icons.arrow_forward_ios)
                          ],
                        ),
                      )),
                ],
              )
            ],
          ),
        ));
  }
}
