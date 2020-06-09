import 'package:bestaid/config/strings.dart';
import 'package:bestaid/src/models/user.dart';
import 'package:bestaid/src/pages/user_update.dart';
import 'package:bestaid/src/providers/shared_pref_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  User appUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadSharedPrefs();
  }

  loadSharedPrefs() async {
    try {
      User user = User.fromJson(await SharedPrefProvider.read('user'));
      setState(() {
        appUser = user;
        print(appUser.name);
      });
    } catch (e) {
      // do something
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).accentColor,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark));
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        child: UserProfileChangeDialog(
          onChanged: () {
            setState(() {});
          },
        ),
        onPressed: () {},
      ),
//      appBar: AppBar(
////        leading: IconButton(
////          onPressed: () {
////            Navigator.pop(context);
////          },
////          icon: Icon(Icons.arrow_back_ios),
////          color: Colors.white,
////        ),
////        title: Text('Back'),
//        elevation: 0,
////        bottom: PreferredSize(
////          preferredSize: Size.fromHeight(30),
////          child: SizedBox(
////            height: 20,
////          ),
////        )
//      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 50,
            color: Theme.of(context).accentColor,
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 150,
            width: 150,
            child: CircleAvatar(
              backgroundColor: Theme.of(context).accentColor,
              child: Image.asset(
                'assets/img/user.png',
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
              child: Text(
            appUser.name != null ? appUser.name : 'Username',
            textScaleFactor: 2,
            style: TextStyle(
                color: Theme.of(context).accentColor,
                fontWeight: FontWeight.bold),
          )),
          SizedBox(
            height: 20,
          ),
          Divider(
            color: Theme.of(context).primaryColor,
            thickness: 1.5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    MaterialButton(
                      onPressed: () {},
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.date_range,
                            color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            appUser.dob != null
                                ? DateFormat('d MMM yyyy')
                                    .format(DateTime.parse(appUser.dob))
                                : 'Birthday',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          )
                        ],
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {},
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.location_on,
                            color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            appUser.location != null
                                ? appUser.location
                                : 'Address',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    MaterialButton(
                      onPressed: () {},
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.alarm_on,
                            color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            appUser.weight != null
                                ? appUser.weight + 'Kg'
                                : 'Weight',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          )
                        ],
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {},
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.accessibility,
                            color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            appUser.height != null
                                ? appUser.height + 'ft'
                                : 'Height',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          ),
                          //UserProfileChangeDialog()
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Divider(
            color: Theme.of(context).primaryColor,
            thickness: 1.5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                MaterialButton(
                  onPressed: () {},
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.phone,
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        appUser.phone != null ? appUser.phone : '01XXX XXXXXX',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ],
                  ),
                ),
                MaterialButton(
                  onPressed: () {},
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.mail,
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        appUser.email != null ? appUser.email : 'Email',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      )
                    ],
                  ),
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
                  Text(
                    'Medical History',
                    textScaleFactor: 2,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Divider(
                    color: Colors.white,
                    thickness: 1.5,
                    endIndent: 180,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    medical_history,
                    textScaleFactor: 1.3,
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
