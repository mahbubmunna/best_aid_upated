import 'package:bestaid/config/strings.dart';
import 'package:bestaid/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).accentColor,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark
    ));
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
//        leading: IconButton(
//          onPressed: () {
//            Navigator.pop(context);
//          },
//          icon: Icon(Icons.arrow_back_ios),
//          color: Colors.white,
//        ),
//        title: Text('Back'),
        elevation: 0,
//        bottom: PreferredSize(
//          preferredSize: Size.fromHeight(30),
//          child: SizedBox(
//            height: 20,
//          ),
//        )
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 20,),
          SizedBox(
            height: 150, width: 150,
            child: CircleAvatar(
              backgroundColor: Theme.of(context).accentColor,
              child: Image.asset('assets/img/user.png', ),
            ),
          ),
          SizedBox(height: 20,),
          Center(child: Text(appUser.name, textScaleFactor: 2, style: TextStyle(color: Theme.of(context).accentColor, fontWeight: FontWeight.bold), )),
          SizedBox(height: 20,),
          Divider(color: Theme.of(context).primaryColor, thickness: 1.5,),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(Icons.date_range,  color: Theme.of(context).primaryColor,),
                        SizedBox(width: 10,),
                        Text('Birth Date', style: TextStyle(color: Theme.of(context).primaryColor),)
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: <Widget>[
                        Icon(Icons.location_on, color: Theme.of(context).primaryColor,),
                        SizedBox(width: 10,),
                        Text('Location', style: TextStyle(color: Theme.of(context).primaryColor),)
                      ],
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(Icons.alarm_on, color: Theme.of(context).primaryColor,),
                        SizedBox(width: 10,),
                        Text('60 Kg', style: TextStyle(color: Theme.of(context).primaryColor),)
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: <Widget>[
                        Icon(Icons.accessibility, color: Theme.of(context).primaryColor,),
                        SizedBox(width: 10,),
                        Text('Height', style: TextStyle(color: Theme.of(context).primaryColor),)
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          Divider(color: Theme.of(context).primaryColor, thickness: 1.5,),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.phone, color: Theme.of(context).primaryColor,),
                    SizedBox(width: 10,),
                    Text('01XXX XXXXXX', style: TextStyle(color: Theme.of(context).primaryColor),)
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  children: <Widget>[
                    Icon(Icons.mail, color: Theme.of(context).primaryColor,),
                    SizedBox(width: 10,),
                    Text(appUser.email, style: TextStyle(color: Theme.of(context).primaryColor),)
                  ],
                ),
              ],
            ),
          ),
          Container(
            color: Theme.of(context).primaryColor,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Medical History', textScaleFactor: 2, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                  Divider(color: Colors.white, thickness: 1.5, endIndent: 180,),
                  SizedBox(height: 10,),
                  Text(lorem_ipsum, textScaleFactor: 1.3, style: TextStyle(color: Colors.white),)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
