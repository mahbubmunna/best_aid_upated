import 'package:bestaid/src/models/post.dart';
import 'package:bestaid/src/models/route_argument.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PostDetails extends StatefulWidget {
  final RouteArgument routeArgument;
  Post post;
  PostDetails({this.routeArgument}) {
    post = routeArgument.param as Post;
  }
  @override
  _PostDetailsState createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
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
        padding: EdgeInsets.only(top: 30, left: 10, right: 10),
        child: ListView(
          children: <Widget>[
            Card(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(DateFormat('MMM d yyyy').format(widget.post.time), textScaleFactor: 1.2, style: TextStyle(color: Theme.of(context).hintColor),),
                    SizedBox(height: 20,),
                    Text(widget.post.body, textScaleFactor: 1.2,),
                    SizedBox(height: 20,),
                    Row(
                      children: <Widget>[
                        CircleAvatar(backgroundImage: AssetImage('assets/img/expert.png'), backgroundColor: Colors.white,),
                        SizedBox(width: 10,),
                        Text('Dr. Habib Iftekhar', textScaleFactor: 1.2,)
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}
