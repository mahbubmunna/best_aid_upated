import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gifimage/flutter_gifimage.dart';

class OneClickDoctor extends StatefulWidget {
  @override
  _OneClickDoctorState createState() => _OneClickDoctorState();
}

class _OneClickDoctorState extends State<OneClickDoctor>
    with SingleTickerProviderStateMixin, TickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;
  bool isLoaded = false;
  GifController _gifController;

  @override
  void initState() {
    // TODO: implement initState
    _gifController = GifController(vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _gifController.repeat(
          min: 0, max: 90, period: Duration(milliseconds: 3000));
    });
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
    _animation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(_controller);

    Timer(Duration(seconds: 3), () async {
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
        body: Stack(
          children: <Widget>[
            Column(
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
            isLoaded
                ? Container(
                    child: Center(),
                  )
                : Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    color: Colors.white.withOpacity(.8),
                    child: Center(
                      child: GifImage(
                        controller: _gifController,
                        image: AssetImage(
                          'assets/img/best_aid_pulse.gif',
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
