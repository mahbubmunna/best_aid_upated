import 'package:flutter/material.dart';

class OnlineConsultancy extends StatefulWidget {
  @override
  _OnlineConsultancyState createState() => _OnlineConsultancyState();
}

class _OnlineConsultancyState extends State<OnlineConsultancy> {
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.accessible_forward, color: Colors.white, size: 60,),
          Center(child: Text('Stay tuned, coming soon', textScaleFactor: 2, style: TextStyle(color: Colors.white),))
        ],
      ),
    );
  }
}
