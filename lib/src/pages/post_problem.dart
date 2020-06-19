import 'dart:math' as math;

import 'package:bestaid/config/database.dart';
import 'package:bestaid/generated/l10n.dart';
import 'package:bestaid/src/models/problem_response.dart';
import 'package:bestaid/src/pages/your_history.dart';
import 'package:bestaid/src/repository/problem_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PostProblem extends StatefulWidget {
  @override
  _PostProblemState createState() => _PostProblemState();
}

class _PostProblemState extends State<PostProblem>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  final _postInputController = TextEditingController();
  final _postHeadLineInputController = TextEditingController();

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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => YourHistory()));
          },
          backgroundColor: Theme.of(context).accentColor,
          child: Icon(
            Icons.chat,
            color: Colors.white,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 50, right: 50),
          child: ListView(
            children: <Widget>[
              RaisedButton(
                color: Colors.white,
                textColor: Theme.of(context).accentColor,
                shape: StadiumBorder(),
                onPressed: () {},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          'Post Your Problem',
                          textScaleFactor: 1.2,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Transform.rotate(
                              angle: 90 * math.pi / 180,
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: Theme.of(context).accentColor,
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                maxLines: 2,
                controller: _postHeadLineInputController,
                decoration: InputDecoration(
                    focusColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: S.of(context).post_headline),
              ),
              SizedBox(
                height: 16,
              ),
              TextField(
                maxLines: 12,
                controller: _postInputController,
                decoration: InputDecoration(
                    focusColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: S.of(context).post_hint),
              ),
              SizedBox(
                height: 16,
              ),
              Center(
                child: Builder(builder: (BuildContext context) {
                  return MaterialButton(
                    color: Colors.white,
                    shape: StadiumBorder(),
                    textColor: Theme.of(context).accentColor,
                    onPressed: () {
                      if (_postHeadLineInputController.text.isNotEmpty &&
                          _postInputController.text.isNotEmpty) {
                        _postProblemToTheServer(context);
                      } else {
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[Text('Fields can not be empty')],
                          ),
                          backgroundColor: Theme.of(context).primaryColor,
                        ));
                      }
                    },
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40),
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
    );
  }

  _postProblemToTheServer(BuildContext context) {
    Map post = {
      'title': _postHeadLineInputController.text,
      'message': _postInputController.text
    };
    ProblemRepository.postDataToProblem(post).then((value) {
      ProblemResponse response = ProblemResponse.fromJson(value);
      DatabaseHelper.createChatRoom(response.problem);
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      _postInputController.clear();
      _postHeadLineInputController.clear();
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[Text('Posted Successfully')],
        ),
        backgroundColor: Theme.of(context).accentColor,
      ));
    }).catchError((onError) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[Text('Something went wrong')],
        ),
        backgroundColor: Theme.of(context).accentColor,
      ));
    });
  }
}
