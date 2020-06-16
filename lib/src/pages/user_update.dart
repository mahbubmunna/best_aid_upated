/*
import 'package:bestaid/src/models/user.dart';
import 'package:bestaid/src/providers/shared_pref_provider.dart';
import 'package:bestaid/src/repository/user_repository.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserProfileChangeDialog extends StatefulWidget {
  VoidCallback onChanged;

  UserProfileChangeDialog({Key key, this.onChanged}) : super(key: key);

  @override
  _UserProfileChangeDialogState createState() =>
      _UserProfileChangeDialogState();
}

class _UserProfileChangeDialogState extends State<UserProfileChangeDialog> {
  static User appUser;


  @override
  void initState() {
    // TODO: implement initState
    loadSharedPrefs();
    super.initState();
  }

  loadSharedPrefs() async {
    try {
      User user = await SharedPrefProvider.read('user');
      setState(() {
        appUser = user;
      });
    } catch (e) {
      // do something
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlatButton(
        onPressed: () {

        },
        child: Icon(
          Icons.edit,
          color: Colors.white,
        ));
  }



}
*/
