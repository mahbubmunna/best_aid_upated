import 'dart:convert';
import 'dart:io';

import 'package:bestaid/splash.dart';
import 'package:bestaid/src/models/registerinfo.dart';
import 'package:bestaid/src/models/user.dart';
import 'package:bestaid/src/providers/shared_pref_provider.dart';
import 'package:bestaid/src/repository/user_repository.dart';
import 'package:flutter/material.dart';

class OverviewProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _OverviewProfileState();
  }
}

class _OverviewProfileState extends State<OverviewProfile> {
  String filePath = "";
  String weight = "";
  String location = "";
  String height = "";

  RegisterInfo mInfo = RegisterInfo.getInfo();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    filePath = RegisterInfo.getInfo().photo;
    weight = RegisterInfo.getInfo().weight;
    location = RegisterInfo.getInfo().location;
    height = RegisterInfo.getInfo().height;
    print(height);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
          color: Theme.of(context).primaryColor,
        ),
        title: Text(
          'Back',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
        elevation: 0,
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                left: 52.0,
                right: 52.0,
              ),
              child: OutlineButton(
                disabledBorderColor: Theme.of(context).primaryColor,
                child: Text(
                  'Overview Profile',
                  textScaleFactor: 1.5,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                onPressed: () {},
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(
              height: 24.0,
            ),
            Center(
              child: filePath == ""
                  ? Image.asset(
                      'assets/img/user.png',
                      height: 96,
                      width: 96,
                    )
                  : Container(
                      height: 96.0,
                      width: 96.0,
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0x33A6A6A6)),
                        image: DecorationImage(
                            image: Image.file(
                              File(
                                filePath,
                              ),
                            ).image,
                            fit: BoxFit.fill),
                        // image: new Image.asset(_image.)
                      ),
                    ),
            ),
            SizedBox(
              height: 24.0,
            ),
            Container(
              color: Theme.of(context).primaryColor,
              height: 2,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                top: 8.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: FlatButton.icon(
                      onPressed: () {},
                      icon: Image.asset(
                        'assets/img/20.png',
                        height: 24.0,
                        width: 24.0,
                      ),
                      label: Text('Birth date'),
                    ),
                    flex: 1,
                  ),
                  Flexible(
                    child: FlatButton.icon(
                      onPressed: () {},
                      icon: Image.asset(
                        'assets/img/21.png',
                        height: 24.0,
                        width: 24.0,
                      ),
                      label: Text(
                        weight != "" ? weight + ' kg' : '60 kg',
                      ),
                    ),
                    flex: 1,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: FlatButton.icon(
                      onPressed: () {},
                      icon: Image.asset(
                        'assets/img/22.png',
                        height: 24.0,
                        width: 24.0,
                      ),
                      label: Text(
                        location != "" ? location : 'Location',
                      ),
                    ),
                    flex: 1,
                  ),
                  Flexible(
                    child: FlatButton.icon(
                      onPressed: () {},
                      icon: Image.asset(
                        'assets/img/23.png',
                        height: 24.0,
                        width: 24.0,
                      ),
                      label: Text(
                        height != "" ? height : 'Height',
                      ),
                    ),
                    flex: 1,
                  ),
                ],
              ),
            ),
            Container(
              color: Theme.of(context).primaryColor,
              height: 2,
            ),
            SizedBox(
              height: 56.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 36.0, right: 36.0),
              child: MaterialButton(
                height: 56.0,
                onPressed: () {
                  if (filePath.isEmpty) {
                    Map values = RegisterInfo.getInfo().toJson();
                    print(values);
                    UserRepository.registerUser(values).then((value) async {
                      UserResponse mResponse = value;
                      print(mResponse.user);
                      SharedPrefProvider.setString(
                          'access_token', mResponse.accessToken);
                      Map mUser = mResponse.user.toJson();
                      SharedPrefProvider.saveUser('user', mUser);
                      appUser = mResponse.user;
                      if (appUser != null) {
                        setState(() {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              '/Starter', ModalRoute.withName('/'));
                        });
                      }
                    });
                  } else {
                    Map values = RegisterInfo.getInfo().toJsonString();
                    UserRepository.upload(filePath, values).then((value) {
                      Map<String, dynamic> result = json.decode(value);
                      UserResponse mResponse = UserResponse.fromJson(result);
                      print(mResponse.toString());
                      SharedPrefProvider.setString(
                          'access_token', mResponse.accessToken);
                      Map mUser = mResponse.user.toJson();
                      SharedPrefProvider.saveUser('user', mUser);
                      appUser = mResponse.user;
                      if (appUser != null) {
                        setState(() {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              '/Starter', ModalRoute.withName('/'));
                        });
                      }
                    });
                  }
                },
                color: Theme.of(context).primaryColor,
                child: Text(
                  'Confirm and Save',
                  textScaleFactor: 1.3,
                  style: TextStyle(
                    color: Colors.white,
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
