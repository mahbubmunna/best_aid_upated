import 'dart:math' as math;

import 'package:bestaid/config/helper.dart';
import 'package:bestaid/src/models/openproblem.dart';
import 'package:bestaid/src/repository/problem_repository.dart';
import 'package:flutter/material.dart';

class DoctorProblemList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DoctorProblemState();
  }
}

class _DoctorProblemState extends State<DoctorProblemList> {
  var _futureProblems;
  List<Problem> openProblemList;
  bool isSwitched = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _futureProblems = ProblemRepository.getOpenProblems();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 24.0,
        ),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 16.0,
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
                          'Problems',
                          textScaleFactor: 1.5,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Transform.rotate(
                          angle: 90 * math.pi / 180,
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 4,
              child: FutureBuilder(
                future: _futureProblems,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.problem == null &&
                        snapshot.data.problem.length > 0) {
                      buildErrorWidget("No Problem found..");
                    }
                    return _activeProblemsListView(snapshot.data);
                  } else if (snapshot.hasError) {
                    return buildErrorWidget(snapshot.error);
                  } else {
                    return buildLoadingWidget();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  _activeProblemsListView(var problems) {
    if (problems is OpenProblemResponse) {
      openProblemList = problems.problem;
    }
    if (openProblemList.length == 0) {
      return Center(
          child: Column(
        children: <Widget>[
          Icon(
            Icons.cancel,
            color: Colors.white,
          ),
          Text(
            'No Problem Found.....',
            textScaleFactor: 1.5,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ));
    }
    return ListView.separated(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: openProblemList.length,
      itemBuilder: (context, index) {
        Problem activeProblem = openProblemList[index];
        return Container(
          height: 156,
          child: Card(
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Column(

              children: <Widget>[
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        child: Padding(
                          padding: EdgeInsets.only(left: 16.0, top: 16.0),
                          child: RichText(
                            strutStyle: StrutStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                                style: TextStyle(
                                    color: Theme.of(context).accentColor),
                                text: activeProblem.title),
                          ),
                        ),
                        flex: 2,
                      ),
                      Flexible(
                        child: Switch(
                          value: isSwitched,
                          onChanged: (value) {
                            isSwitched = value;
                          },
                          activeTrackColor: Colors.lightGreenAccent,
                          activeColor: Colors.green,
                        ),
                        flex: 1,
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                    child: Divider(
                      color: Colors.black,
                      height: 36,
                    ),
                  ),
                  flex: 1,
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          height: 10,
        );
      },
    );
  }
}
