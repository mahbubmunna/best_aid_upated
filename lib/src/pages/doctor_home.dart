import 'package:bestaid/src/pages/doctor_problems.dart';
import 'package:bestaid/src/pages/doctor_solved.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DoctorHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DoctorHomeState();
  }
}

class _DoctorHomeState extends State<DoctorHome> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
        ),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Image.asset(
                'assets/img/logo.png',
                height: 220,
                width: 220,
              ),
              SizedBox(
                height: 36.0,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DoctorProblemList()));
                },
                child: Card(
                  color: Colors.white,
                  child: ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.only(left: 56.0),
                      child: Image.asset(
                        'assets/img/36.png',
                        height: 24.0,
                        width: 24.0,
                      ),
                    ),
                    title: Text(
                      'Problems',
                      textAlign: TextAlign.left,
                      textScaleFactor: 1.2,
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 36.0,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DoctorSolvedProblems()));
                },
                child: Card(
                  color: Colors.white,
                  child: ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.only(left: 56.0),
                      child: Image.asset(
                        'assets/img/37.png',
                        height: 24.0,
                        width: 24.0,
                      ),
                    ),
                    title: Text(
                      'Solved',
                      textAlign: TextAlign.left,
                      textScaleFactor: 1.2,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
