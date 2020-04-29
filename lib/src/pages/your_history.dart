import 'package:flutter/material.dart';
import 'dart:math' as math;

class YourHistory extends StatefulWidget {
  @override
  _YourHistoryState createState() => _YourHistoryState();
}

class _YourHistoryState extends State<YourHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {Navigator.pop(context);},
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.white,),
        title: Text('Back'),
        elevation: 0,
        backgroundColor: Theme.of(context).accentColor,),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Center(
                  child: RaisedButton(
                      color: Colors.white,
                      textColor: Theme.of(context).accentColor,
                      shape: StadiumBorder(),
                      onPressed: () {},
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            SizedBox(
                              width: 30,
                            ),
                            Text(
                              'YOUR PROBLEMS',
                              textScaleFactor: 1.2,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Transform.rotate(
                                angle: 90 * math.pi / 180,
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Theme.of(context).accentColor,
                                )),
                          ],
                        ),
                      )),
                ),
              ),
              Flexible(
                flex: 3,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: <Widget>[
                            Flexible(
                              flex: 2,
                              fit: FlexFit.tight,
                              child: Column(
                                children: <Widget>[
                                  Text('Active', textScaleFactor: 1.5, style: TextStyle(color: Theme.of(context).primaryColor),),
                                  Text('17 April 2019'),
                                ],
                              ),
                            ),
                            VerticalDivider(
                              color: Theme.of(context).primaryColor,
                              thickness: 1,
                            ),
                            Flexible(
                              flex: 3,
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit,derit in voluptate velit, meri kahne ka houl soum'),
                                    SizedBox(
                                      height: 25,
                                      width: 100,
                                      child: MaterialButton(
                                        shape: StadiumBorder(),
                                        color: Theme.of(context).accentColor,
                                        textColor: Colors.white,
                                        onPressed: () {},
                                        child: Text(
                                          'Read More',
                                          textScaleFactor: .8,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ));
                  },
                ),
              ),
              Flexible(
                flex: 1,
                child: Center(
                  child: RaisedButton(
                      color: Colors.white,
                      textColor: Theme.of(context).accentColor,
                      shape: StadiumBorder(),
                      onPressed: () {},
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            SizedBox(
                              width: 30,
                            ),
                            Text(
                              'YOUR HISTORY',
                              textScaleFactor: 1.2,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Transform.rotate(
                                angle: 90 * math.pi / 180,
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Theme.of(context).accentColor,
                                )),
                          ],
                        ),
                      )),
                ),
              ),
              Flexible(
                flex: 3,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: <Widget>[
                            Flexible(
                              flex: 2,
                              fit: FlexFit.tight,
                              child: Column(
                                children: <Widget>[
                                  Text('Solved', textScaleFactor: 1.5, style: TextStyle(color: Theme.of(context).accentColor),),
                                  Text('17 April 2019'),
                                ],
                              ),
                            ),
                            VerticalDivider(
                              color: Theme.of(context).primaryColor,
                              thickness: 1,
                            ),
                            Flexible(
                              flex: 3,
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit,derit in voluptate velit, meri kahne ka houl soum'),
                                    SizedBox(
                                      height: 25,
                                      width: 100,
                                      child: MaterialButton(
                                        shape: StadiumBorder(),
                                        color: Theme.of(context).accentColor,
                                        textColor: Colors.white,
                                        onPressed: () {},
                                        child: Text(
                                          'Read More',
                                          textScaleFactor: .8,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ));
                  },
                ),
              ),
            ],
          ),
        ),
    );
  }
}
