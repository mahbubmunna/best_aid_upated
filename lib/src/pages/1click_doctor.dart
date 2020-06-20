import 'dart:async';

import 'package:bestaid/config/helper.dart';
import 'package:flutter/material.dart';

class OneClickDoctor extends StatefulWidget {
  @override
  _OneClickDoctorState createState() => _OneClickDoctorState();
}

class _OneClickDoctorState extends State<OneClickDoctor>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;
  bool isLoaded = false;

  @override
  void initState() {
    // TODO: implement initState
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
    _animation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(_controller);
    Timer(Duration(seconds: 2), () async {
      setState(() {
        isLoaded = true;
      });
    });

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
    return isLoaded
        ? FadeTransition(
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
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.accessible_forward,
                    color: Colors.white,
                    size: 60,
                  ),
                  Center(
                      child: Text(
                    'Stay tuned, coming soon',
                    textScaleFactor: 2,
                    style: TextStyle(color: Colors.white),
                  ))
                ],
              ),
            ),
          )
        : Scaffold(
            body: Container(
              color: Colors.white.withOpacity(0.5),
              child: Center(
                child: spinkit,
              ),
            ),
          );
  }
}
