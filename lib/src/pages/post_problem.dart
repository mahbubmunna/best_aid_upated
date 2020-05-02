import 'package:bestaid/generated/l10n.dart';
import 'package:bestaid/src/repository/post_repository.dart';
import 'package:bestaid/src/repository/problem_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter/services.dart';

class PostProblem extends StatefulWidget {
  @override
  _PostProblemState createState() => _PostProblemState();
}

class _PostProblemState extends State<PostProblem> {
  final _postInputController =  TextEditingController();

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        leading: IconButton(
          onPressed: () {Navigator.pop(context);},
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.white,),
        title: Text('Back'),
        elevation: 0,
        ),
      body: Padding(
        padding: EdgeInsets.only(left: 50, right: 50),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 80,),
            RaisedButton(
                color: Colors.white,
                textColor: Theme.of(context).accentColor,
                shape: StadiumBorder(),
                onPressed: (){},
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(width: 30,),
                      Text('Post Your Problem', textScaleFactor: 1.2,),
                      SizedBox(width: 15,),
                      Transform.rotate(angle: 90 * math.pi / 180,
                          child: Icon(Icons.arrow_forward_ios, color: Theme.of(context).accentColor,)),
                    ],
                  ),
                )
            ),
            SizedBox(height: 30,),
            TextField(
              maxLines: 16,
              controller: _postInputController,
              decoration: InputDecoration(
                focusColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                fillColor: Colors.white,
                filled: true,
                hintText: S.of(context).post_hint
              ),
            ),
            SizedBox(height: 30,),
            Center(
              child: Builder(
                builder: (BuildContext context) {
                  return MaterialButton(
                    color: Theme.of(context).primaryColor,
                    shape: StadiumBorder(),
                    textColor: Colors.white,
                    onPressed: (){
                      _postProblemToTheServer(context);
                    },
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Text('SEND', textScaleFactor: 1.2,)),
                  );
                }
              ),
            )
          ],
        ),
      ),
    );
  }

 _postProblemToTheServer(BuildContext context) {
    Map post = {'title': _postInputController.text, 'message': _postInputController.text};
    ProblemRepository.postDataToProblem(post).then((value) {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      _postInputController.clear();
      Scaffold.of(context).showSnackBar(SnackBar(content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('Posted Successfully')
        ],
      ), backgroundColor: Theme.of(context).primaryColor,));
    }).catchError((onError) {
      Scaffold.of(context).showSnackBar(SnackBar(content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('Something went wrong')
        ],
      ), backgroundColor: Theme.of(context).primaryColor,));
    });
 }


}
