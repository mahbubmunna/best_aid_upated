import 'package:bestaid/config/strings.dart';
import 'package:bestaid/generated/l10n.dart';
import 'package:bestaid/src/models/problems.dart';
import 'package:bestaid/src/models/route_argument.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class ProblemDetails extends StatefulWidget {
  final RouteArgument routeArgument;
  Problem problem;

  ProblemDetails({this.routeArgument}) {
    problem = routeArgument.param as Problem;
  }

  @override
  _ProblemDetailsState createState() => _ProblemDetailsState();
}

class _ProblemDetailsState extends State<ProblemDetails> {
  TextEditingController _postInputController = TextEditingController();
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
        padding: EdgeInsets.only(top: 30, left: 10, right: 10),
        child: ListView(
          children: <Widget>[
            Card(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      DateFormat('MMM d yyyy').format(widget.problem.time),
                      textScaleFactor: 1.2,
                      style: TextStyle(color: Theme.of(context).hintColor),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      widget.problem.title,
                      textScaleFactor: 1.2,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/img/user.png'),
                              backgroundColor: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Mahbub',
                              textScaleFactor: 1.2,
                            )
                          ],
                        ),
                        IconButton(
                          icon: Icon(Icons.chat_bubble_outline),
                          splashColor: Theme.of(context).primaryColor,
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => Dialog(
                                backgroundColor: Colors.transparent,
                                child: Card(
                                  child: Padding(
                                    padding: EdgeInsets.all(20),
                                    child: ListView(
                                      shrinkWrap: true,
                                      children: <Widget>[
                                        SizedBox(
                                          height: 30,
                                        ),
                                        TextField(
                                          maxLines: 8,
                                          //controller: _postInputController,
                                          decoration: InputDecoration(
                                              focusColor: Colors.white,
                                              border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(10))),
                                              fillColor: Colors.white,
                                              filled: true,
                                              hintText: 'write...'),
                                        ),
                                        SizedBox(
                                          height: 30,
                                        ),
                                        Center(
                                          child: Builder(
                                              builder: (BuildContext context) {
                                                return MaterialButton(
                                                  color: Theme.of(context).primaryColor,
                                                  shape: StadiumBorder(),
                                                  textColor: Colors.white,
                                                  onPressed: () {
                                                     _postProblemToTheServer(context, widget.problem);
                                                  },
                                                  child: Padding(
                                                      padding: EdgeInsets.symmetric(
                                                          horizontal: 40),
                                                      child: Text(
                                                        'SEND',
                                                        textScaleFactor: 1.2,
                                                      )),
                                                );
                                              }),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            );
                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 30),
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        DateFormat('MMM d yyyy').format(DateTime.now()),
                        textScaleFactor: 1.2,
                        style: TextStyle(color: Theme.of(context).hintColor),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        lorem_ipsum,
                        textScaleFactor: 1.2,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: <Widget>[
                          CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/img/expert.png'),
                            backgroundColor: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Dr. Habib Iftekar',
                            textScaleFactor: 1.2,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }
  _postProblemToTheServer(BuildContext context, Problem problem) {
    Map post = {'message': _postInputController.text};
    Dio().post('$api_base_url/problem/${problem.id}', data: post).then((value) {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      _postInputController.clear();
    }).catchError((onError) {
      print(onError.toString());
    });
  }
}
