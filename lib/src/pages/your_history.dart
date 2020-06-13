import 'dart:math' as math;

import 'package:bestaid/config/helper.dart';
import 'package:bestaid/src/models/discussion.dart';
import 'package:bestaid/src/models/route_argument.dart';
import 'package:bestaid/src/repository/problem_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class YourHistory extends StatefulWidget {
  @override
  _YourHistoryState createState() => _YourHistoryState();
}

class _YourHistoryState extends State<YourHistory> {
  var _futureProblems;
  List<Problem> _problemHistories;
  List<Problem> _activeProblems;
  int active = 1;
  int closed = 0;

  @override
  void initState() {
    _futureProblems = ProblemRepository.getProblems();
    super.initState();
  }

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
                            'Your History',
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
              child: FutureBuilder(
                future: _futureProblems,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.error != null &&
                        snapshot.data.error.length > 0) {
                      buildErrorWidget(snapshot.data.error);
                    }
                    return _activeProblemsListView(snapshot.data.posts);
                  } else if (snapshot.hasError) {
                    return buildErrorWidget(snapshot.error);
                  } else {
                    return buildLoadingWidget();
                  }
                },
              ),
            ),
            /*   Flexible(
              flex: 1,
              child: Center(
                child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
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
                            'HISTORY',
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
            ),*/
            Flexible(
              flex: 3,
              child: FutureBuilder(
                future: _futureProblems,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.error != null &&
                        snapshot.data.error.length > 0) {
                      buildErrorWidget(snapshot.data.error);
                    }
                    return _historyListView(snapshot.data.posts);
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

  _historyListView(List<Problem> problems) {
    _problemHistories =
        problems.where((problem) => problem.status == closed).toList();
    if (_problemHistories.length == 0) {
      return Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Center(
            child: Column(
          children: <Widget>[
            Icon(
              Icons.cancel,
              color: Colors.white,
            ),
            Text(
              'No Solved Cases',
              textScaleFactor: 2,
              style: TextStyle(color: Colors.white),
            ),
          ],
        )),
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: _problemHistories.length,
      itemBuilder: (context, index) {
        Problem solvedProblem = _problemHistories[index];
        return Card(
            color: Theme.of(context).primaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: <Widget>[
                Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Solved',
                        textScaleFactor: 1.5,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Text(solvedProblem.updatedAt.substring(0, 10)),
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
                        Text(solvedProblem.title,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.white)),
                        SizedBox(
                          height: 25,
                          width: 100,
                          child: MaterialButton(
                            shape: StadiumBorder(),
                            color: Colors.white,
                            textColor: Theme.of(context).primaryColor,
                            onPressed: () {
                              Navigator.of(context).pushNamed('/ProblemDetails',
                                  arguments:
                                      RouteArgument(param: solvedProblem));
                            },
                            child: Text(
                              'Read More',
                              textScaleFactor: .8,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ));
      },
    );
  }

  _activeProblemsListView(List<Problem> problems) {
    _activeProblems =
        problems.where((problem) => problem.status == active).toList();
    if (_activeProblems.length == 0) {
      return Center(
          child: Column(
        children: <Widget>[
          Icon(
            Icons.cancel,
            color: Colors.white,
          ),
          Text(
            'You didn\'t post a problem yet',
            textScaleFactor: 2,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ));
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: _activeProblems.length,
      itemBuilder: (context, index) {
        Problem activeProblem = _activeProblems[index];
        return Container(
          height: 112,
          child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: <Widget>[
                  Flexible(
                    flex: 2,
                    fit: FlexFit.tight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Active',
                          textScaleFactor: 1.5,
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(activeProblem.updatedAt.substring(0, 10)),
                      ],
                    ),
                  ),
                  VerticalDivider(
                    color: Colors.grey.shade300,
                    thickness: 1,
                  ),
                  Flexible(
                    flex: 3,
                    fit: FlexFit.tight,
                    child: Padding(
                        padding: EdgeInsets.all(4),
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              top: 2,
                              child: Text(
                                activeProblem.title,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                activeProblem.message,
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: SizedBox(
                                height: 25,
                                width: 88,
                                child: MaterialButton(
                                  shape: StadiumBorder(),
                                  color: Theme.of(context).accentColor,
                                  textColor: Colors.white,
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(
                                        '/ProblemDetails',
                                        arguments: RouteArgument(
                                            param: activeProblem));
                                  },
                                  child: Text(
                                    'Read More',
                                    textScaleFactor: .6,
                                  ),
                                ),
                              ),
                            )
                          ],
                        )),
                  ),
                ],
              )),
        );
      },
    );
  }
}
