import 'package:bestaid/config/helper.dart';
import 'package:bestaid/splash.dart';
import 'package:bestaid/src/models/discussion.dart';
import 'package:bestaid/src/models/route_argument.dart';
import 'package:bestaid/src/models/user.dart';
import 'package:bestaid/src/providers/shared_pref_provider.dart';
import 'package:bestaid/src/repository/problem_repository.dart';
import 'package:bestaid/src/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class ProblemDetails extends StatefulWidget {
  final RouteArgument routeArgument;
  Problem problem;

  ProblemDetails({this.routeArgument}) {
    problem = routeArgument.param as Problem;
    print("${problem.id}");
  }

  @override
  _ProblemDetailsState createState() => _ProblemDetailsState();
}

class _ProblemDetailsState extends State<ProblemDetails> {
  User mUser;
  TextEditingController _postInputController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    loadSharedPrefs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
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
        body: Stack(
          children: <Widget>[
            Positioned.fill(
                child: Column(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 30, left: 10, right: 10),
                    child: ListView(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).accentColor,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              topLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0.0, 1.0), //(x,y)
                                blurRadius: 6.0,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  widget.problem.title,
                                  textScaleFactor: 1.2,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  widget.problem.message,
                                  textScaleFactor: 1.2,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                /*Row(
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
                    )*/
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 24.0,
                        ),
                        FutureBuilder(
                          future: ProblemRepository.getDiscussions(
                              widget.problem.id),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              /* if(snapshot.data.error != null && snapshot.data.error.length > 0){
                    buildErrorWidget(snapshot.data.error);
                  }*/
                              return _buildConversationsList(snapshot.data);
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
                ),
                Container(
                  color: Theme.of(context).accentColor,
                  height: 61,
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.add_circle_outline),
                        color: Colors.white,
                        onPressed: () {},
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.0),
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0, 3),
                                  blurRadius: 5,
                                  color: Colors.grey)
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 8.0,
                            ),
                            child: TextField(
                              controller: _postInputController,
                              decoration: InputDecoration(
                                  hintText: "Type Something...",
                                  border: InputBorder.none),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                        onPressed: () async {
                          _postProblemToTheServer(context, widget.problem);
                        },
                      )
                    ],
                  ),
                ),
              ],
            ))
          ],
        ));
  }

  _buildConversationsList(var data) {
    if (data is DiscussionResponse) {
      DiscussionResponse mResponse = data;
      List<Discussion> discussions = mResponse.problem.discussion;
      if (discussions.length == 0) {
        return Center(
            child: Column(
          children: <Widget>[
            Icon(
              Icons.cancel,
              color: Colors.white,
            ),
            Text(
              'No reply yet',
              textScaleFactor: 2,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ));
      }
      return ListView.separated(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: discussions.length,
        itemBuilder: (context, index) {
          if (discussions[index].type == 'question') {
            return _userConversationItem(discussions[index]);
          }

          if (discussions[index].type == 'reply') {
            return _doctorConversationItem(discussions[index]);
          }
          return buildErrorWidget('No reply yet');
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: 10,
          );
        },
      );
    }
  }

  _postProblemToTheServer(BuildContext context, Problem problem) async {
    Map replay = {'message': _postInputController.text};
    print(replay.containsKey('message'));
    ProblemRepository.postDataToProblemDiscussion(
            problem.id, replay, mUser.role)
        .then((value) {
      _postInputController.clear();
      ProblemRepository.getDiscussions(widget.problem.id).then((onValue) {
        setState(() {});
      });
    }).catchError((onError) {
      print(onError.toString());
    });
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    // Navigator.of(context).pop();
  }

  _doctorConversationItem(Discussion discussion) {
    return ReceivedMessagesWidget(discussion: discussion);
  }

  _userConversationItem(Discussion discussion) {
    return SentMessageWidget(
      discussion: discussion,
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                fillColor: Colors.white,
                                filled: true,
                                hintText: 'write...'),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Center(
                            child: Builder(builder: (BuildContext context) {
                              return MaterialButton(
                                color: Theme.of(context).primaryColor,
                                shape: StadiumBorder(),
                                textColor: Colors.white,
                                onPressed: () async {
                                  _postProblemToTheServer(
                                      context, widget.problem);
                                },
                                child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 40),
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
                )).then((onValue) {
          ProblemRepository.getDiscussions(widget.problem.id).then((onValue) {
            setState(() {});
          });
        });
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
