import 'package:bestaid/config/helper.dart';
import 'package:bestaid/src/models/discussion.dart';
import 'package:bestaid/src/models/problems.dart';
import 'package:bestaid/src/models/route_argument.dart';
import 'package:bestaid/src/repository/problem_repository.dart';
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
                              'User',
                              textScaleFactor: 1.2,
                            )
                          ],
                        ),
                        _replayIcon()
                      ],
                    )
                  ],
                ),
              ),
            ),
            FutureBuilder(
              future: ProblemRepository.getDiscussions(widget.problem.id),
              builder: (context, snapshot) {
                if(snapshot.hasData) {
                  if(snapshot.data.error != null && snapshot.data.error.length > 0){
                    buildErrorWidget(snapshot.data.error);
                  }
                  return _buildConversationsList(snapshot.data.discussions);
                } else if (snapshot.hasError) {
                  return buildErrorWidget(snapshot.error);
                } else {
                  return buildLoadingWidget();
                }
              },
            ),
            
          ],
        ),
      ),
    );

  }

  _buildConversationsList(List<Discussion> discussions) {

    if(discussions.length == 0) {
      return Center(child: Column(
        children: <Widget>[
          Icon(Icons.cancel, color: Colors.white,),
          Text('No reply yet', textScaleFactor: 2, style: TextStyle(color: Colors.white),),
        ],
      ));
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: discussions.length,
      itemBuilder: (context, index) {
        if (discussions[index].type == 'question') return _userConversationItem(discussions[index]);
        return _doctorConversationItem(discussions[index]);
      },
    );
  }
  _postProblemToTheServer(BuildContext context, Problem problem) async{
    Map replay = {'message': _postInputController.text};
    print(replay.containsKey('message'));
    ProblemRepository.postDataToProblemDiscussion(problem.id, replay).then((value) {
      _postInputController.clear();
    }).catchError((onError) {
      print(onError.toString());
    });
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    Navigator.of(context).pop();
  }

  _doctorConversationItem(Discussion discussion) {
    return Padding(
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
                discussion.message,
                textScaleFactor: 1.2,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    'Expert',
                    textScaleFactor: 1.2,
                  ),
                  _replayIcon()
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  _userConversationItem(Discussion discussion) {
    return Padding(
      padding: EdgeInsets.only(right: 30),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                DateFormat('MMM d yyyy').format(discussion.time),
                textScaleFactor: 1.2,
                style: TextStyle(color: Theme.of(context).hintColor),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                discussion.message,
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
                        'User',
                        textScaleFactor: 1.2,
                      )
                    ],
                  ),
                  _replayIcon()
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  IconButton _replayIcon() {
    return IconButton(
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
                                    controller: _postInputController,
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
                                            onPressed: () async{
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
                    ).then((onValue) {
                      ProblemRepository.getDiscussions(widget.problem.id).then((onValue) {setState(() {

                      });});
                    });
                  },
                );
  }
}
