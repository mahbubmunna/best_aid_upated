import 'dart:math' as math;

import 'package:bestaid/config/helper.dart';
import 'package:bestaid/splash.dart';
import 'package:bestaid/src/models/discussion.dart';
import 'package:bestaid/src/models/openproblem.dart';
import 'package:bestaid/src/models/route_argument.dart';
import 'package:bestaid/src/models/user.dart';
import 'package:bestaid/src/providers/shared_pref_provider.dart';
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

  User mUser;

  @override
  void initState() {
    // TODO: implement initState
    loadSharedPrefs();
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
          height: 196,
          child: Card(
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 16.0, top: 8.0),
                      child: RichText(
                        strutStyle: StrutStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                            style:
                                TextStyle(color: Theme.of(context).accentColor),
                            text: activeProblem.name),
                      ),
                    ),
                    Switch(
                      value: isSwitched,
                      onChanged: (value) {
                        isSwitched = value;
                        showAlertDialog(context, activeProblem);
                      },
                      activeTrackColor: Colors.lightGreenAccent,
                      activeColor: Colors.green,
                    )
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Divider(
                    color: Colors.black,
                    height: 36,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                  ),
                  child: RichText(
                    textAlign: TextAlign.start,
                    strutStyle: StrutStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                        style: TextStyle(color: Colors.green),
                        text: activeProblem.title),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 16,
                    right: 16,
                  ),
                  child: Text(
                    activeProblem.message != null ? activeProblem.message : "",
                    maxLines: 1,
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 16.0),
                        child: RichText(
                          strutStyle: StrutStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                              style: TextStyle(color: Colors.grey),
                              text: activeProblem.createdAt.substring(0, 10)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 24.0),
                        child: SizedBox(
                          height: 25,
                          width: 100,
                          child: MaterialButton(
                            shape: StadiumBorder(),
                            color: Theme.of(context).accentColor,
                            textColor: Colors.white,
                            onPressed: () {
                              //  print(activeProblem.replyBy + " ${appUser.id}");
                              int id = mUser.doctor.id;
                              print("$id ${activeProblem}");
                              if (activeProblem.replyBy == null ||
                                  activeProblem.replyBy == id) {
                                Navigator.of(context).pushNamed(
                                    '/ProblemDetails',
                                    arguments:
                                        RouteArgument(param: activeProblem));
                              } else if (activeProblem.replyBy != null) {
                                if (activeProblem.replyBy != id) {
                                  showErrorDialog(
                                      context,
                                      "Permission Denied",
                                      "Another Doctor is already working on it",
                                      "close");
                                }
                              }
                            },
                            child: Text(
                              'Read More',
                              textScaleFactor: .8,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
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

  showAlertDialog(BuildContext context, Problem activeProblem) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("No"),
      onPressed: () {
        setState(() {
          isSwitched = false;
        });
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Yes"),
      onPressed: () {
        setState(() {
          isSwitched = false;
        });
        ProblemRepository.markAsSolved(activeProblem.id).then((value) {
          setState(() {
            _futureProblems = ProblemRepository.getOpenProblems();
          });
          Navigator.pop(context);
        });
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Confirm"),
      content: Text("Are you sure the problem is solved?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  loadSharedPrefs() async {
    try {
      User user = await SharedPrefProvider.read('user');
      print(user);
      setState(() {
        mUser = user;

        print(appUser.role);
      });
    } catch (e) {
      // do something
      print(e);
    }
  }
}
