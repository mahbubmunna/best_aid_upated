import 'package:bestaid/config/strings.dart';
import 'package:bestaid/src/models/problems.dart';
import 'package:bestaid/src/models/route_argument.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
                    Text(DateFormat('MMM d yyyy').format(widget.problem.time), textScaleFactor: 1.2, style: TextStyle(color: Theme.of(context).hintColor),),
                    SizedBox(height: 20,),
                    Text(widget.problem.title, textScaleFactor: 1.2,),
                    SizedBox(height: 20,),
                    Row(
                      children: <Widget>[
                        CircleAvatar(backgroundImage: AssetImage('assets/img/user.png'), backgroundColor: Colors.white,),
                        SizedBox(width: 10,),
                        Text('Mahbub', textScaleFactor: 1.2,)
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
                      Text(DateFormat('MMM d yyyy').format(DateTime.now()), textScaleFactor: 1.2, style: TextStyle(color: Theme.of(context).hintColor),),
                      SizedBox(height: 20,),
                      Text(lorem_ipsum, textScaleFactor: 1.2, maxLines: 2, overflow: TextOverflow.ellipsis,),
                      SizedBox(height: 20,),
                      Row(
                        children: <Widget>[
                          CircleAvatar(backgroundImage: AssetImage('assets/img/expert.png'), backgroundColor: Colors.white,),
                          SizedBox(width: 10,),
                          Text('Dr. Habib Iftekar', textScaleFactor: 1.2,)
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
    );;
  }
}
