import 'dart:math' as math;

import 'package:bestaid/src/pages/specialist_page.dart';
import 'package:flutter/material.dart';

class OnlineConsultancy extends StatefulWidget {
  @override
  _OnlineConsultancyState createState() => _OnlineConsultancyState();
}

class _OnlineConsultancyState extends State<OnlineConsultancy> {
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
        padding: EdgeInsets.only(left: 16.0, right: 16.0),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 30.0,
            ),
            MaterialButton(
              onPressed: () {},
              elevation: 8,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  leading: Image.asset('assets/img/15.png'),
                  title: Text(
                    'Online \nDoctor Consultancy',
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                  trailing: Transform.rotate(
                    angle: 90 * math.pi / 180,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 64.0,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 36.0,
                right: 36.0,
              ),
              child: Column(
                children: <Widget>[
                  ConstrainedBox(
                    constraints: BoxConstraints(minWidth: double.infinity),
                    child: MaterialButton(
                        height: 44.0,
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        elevation: 8,
                        shape: StadiumBorder(),
                        onPressed: () {},
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Expanded(
                                child: Stack(
                                  children: <Widget>[
                                    Center(
                                      child: Text(
                                        'General Practitioner',
                                        style: TextStyle(fontSize: 16.0),
                                      ),
                                    ),
                                    Positioned(
                                      child: Icon(Icons.arrow_forward_ios),
                                      right: 4,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(minWidth: double.infinity),
                    child: MaterialButton(
                      elevation: 8,
                      height: 44.0,
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      shape: StadiumBorder(),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SpecialistPage()));
                      },
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Expanded(
                              child: Stack(
                                children: <Widget>[
                                  Center(
                                    child: Text(
                                      'Specialist',
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                  ),
                                  Positioned(
                                    child: Icon(Icons.arrow_forward_ios),
                                    right: 4,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
