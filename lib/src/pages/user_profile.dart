import 'dart:convert';

import 'package:bestaid/config/strings.dart';
import 'package:bestaid/src/models/user.dart';
import 'package:bestaid/src/providers/shared_pref_provider.dart';
import 'package:bestaid/src/repository/user_repository.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../splash.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  User appUser;

  GlobalKey<FormState> _profileSettingsFormKey = new GlobalKey<FormState>();
  final nameController = TextEditingController();
  final weightController = TextEditingController();
  DateTime dob = DateTime.now();
  final addressController = TextEditingController();
  final heightController = TextEditingController();
  final phoneController = TextEditingController();
  final medicalHistoyController = TextEditingController();

  String name;
  String weight;
  String address;
  String height;
  String phone;
  String history;
  String path;
  ImagePicker mPicker = ImagePicker();
  PickedFile _pickedFile;
  bool pickedImage = false;

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
        print(appUser.name);
        name = appUser.name;
        weight = appUser.weight;
        height = appUser.height;
        phone = appUser.phone;
        address = appUser.location;
        history = appUser.history;
        path = appUser.photo;
      });
    } catch (e) {
      // do something
      print(e);
    }
  }

  pickImageFromGallery(ImageSource source) async {
    final imageFile = await mPicker.getImage(
        source: source, maxWidth: 96, maxHeight: 96, imageQuality: 90);
    setState(() {
      _pickedFile = imageFile;
      pickedImage = true;
      path = _pickedFile.path;
    });
    Navigator.pop(context);
  }

  pickImageFromCamera(ImageSource source) async {
    final imageFile = await mPicker.getImage(
        source: source, maxHeight: 96, maxWidth: 96, imageQuality: 90);

    setState(() {
      _pickedFile = imageFile;
      pickedImage = true;
      path = _pickedFile.path;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.edit,
            color: Colors.white,
          ),
          onPressed: () {
            _showUpdateProfileDialog();
          },
        ),
        appBar: AppBar(
          /*leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
          ),*/
          actions: <Widget>[
            InkWell(
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                bool user = await prefs?.remove('user');
                bool token = await prefs?.remove('access_token');
                print('$user $token');
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => Splash()));
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                    child: Text(
                  'Log out',
                  textScaleFactor: 1.3,
                )),
              ),
            ),
          ],
          /*title: Text('Back'),*/
          elevation: 0,
        ),
        body: appUser != null
            ? ListView(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  CircleAvatar(
                    radius: 72,
                    backgroundColor: Colors.transparent,
                    child: ClipOval(
                      child: appUser.photo != null &&
                                  appUser.photo.endsWith('.jpg') ||
                              appUser.photo.endsWith('png') ||
                              appUser.photo.endsWith('jpeg')
                          ? /*Image.network(
                              appUser.photo,
                              fit: BoxFit.cover,
                            )*/
                          FadeInImage(
                              fit: BoxFit.fill,
                              height: 100,
                              width: 100,
                              placeholder: AssetImage('assets/img/user.png'),
                              image: NetworkImage(appUser.photo),
                            )
                          : Image.asset(
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
                                    appUser.dob != null || appUser.dob != ""
                                        ? dob.toIso8601String().substring(0, 10)
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
                                appUser.phone != null
                                    ? appUser.phone
                                    : '01XXX XXXXXX',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor),
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
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor),
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
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
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
                            history == null || history == ""
                                ? medical_history
                                : history,
                            textScaleFactor: 1.3,
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )
            : Center(
                child: CircularProgressIndicator(),
              ));
  }

  _showUpdateProfileDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            contentPadding: EdgeInsets.symmetric(horizontal: 20),
            titlePadding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            title: Row(
              children: <Widget>[
                Icon(Icons.people),
                SizedBox(width: 10),
                Text(
                  'Profile Settings',
                  style: Theme.of(context).textTheme.body2,
                )
              ],
            ),
            children: <Widget>[
              Form(
                key: _profileSettingsFormKey,
                child: Column(
                  children: <Widget>[
                    FormField<String>(
                      builder: (FormFieldState<String> state) {
                        return DateTimeField(
                          decoration: getInputDecoration(
                              hintText: '1996-12-31', labelText: 'Birth Date'),
                          format: new DateFormat('yyyy-MM-dd'),
                          initialValue: dob,
                          onChanged: (dateTime) {
                            dob = dateTime;
                          },
                          /*onSaved: (dateTime) {
                            dob = dateTime;
                          },*/
                          onShowPicker: (context, currentValue) async {
                            return showDatePicker(
                                context: context,
                                firstDate: DateTime(1900),
                                initialDate: currentValue ?? DateTime.now(),
                                lastDate: DateTime(2100));
                          },
                        );
                      },
                    ),
                    new TextFormField(
                      controller: weightController,
                      style: TextStyle(
                          color: Theme.of(context).textTheme.subtitle.color),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        weight = value;
                      },
                      decoration: getInputDecoration(
                          hintText: '60', labelText: 'Weight'),
                    ),
                    new TextFormField(
                      controller: addressController,
                      onChanged: (value) {
                        address = value;
                      },
                      style: TextStyle(
                          color: Theme.of(context).textTheme.subtitle.color),
                      keyboardType: TextInputType.text,
                      decoration: getInputDecoration(
                          hintText: 'Mirpur 11, Block A, Road 1, House 11',
                          labelText: 'Address'),
//                          validator: (input) => input.trim().length < 3 ? 'Not a valid full name' : null,
                    ),
                    new TextFormField(
                      controller: heightController,
                      onChanged: (value) {
                        height = value;
                      },
                      style: TextStyle(
                          color: Theme.of(context).textTheme.subtitle.color),
                      keyboardType: TextInputType.number,
                      /*validator: (height) =>
                          double.parse(height) > 8 || double.parse(height) < 4
                              ? 'not vaid value'
                              : null,*/
                      decoration: getInputDecoration(
                          hintText: '5.11', labelText: 'Height'),
                    ),
                    TextFormField(
                      controller: medicalHistoyController,
                      onChanged: (value) {
                        history = value;
                      },
                      style: TextStyle(
                          color: Theme.of(context).textTheme.subtitle.color),
                      keyboardType: TextInputType.text,
                      decoration: getInputDecoration(
                          hintText: 'history', labelText: 'Medical History'),
                    ),
                    new TextFormField(
                      controller: phoneController,
                      onChanged: (value) {
                        phone = value;
                      },
                      style: TextStyle(
                          color: Theme.of(context).textTheme.subtitle.color),
                      keyboardType: TextInputType.phone,
                      decoration: getInputDecoration(
                          hintText: '01XXX XXXXXX', labelText: 'Phone'),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: <Widget>[
                  MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel'),
                  ),
                  MaterialButton(
                    onPressed: _submit,
                    child: Text(
                      'Save',
                      style: TextStyle(color: Theme.of(context).accentColor),
                    ),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.end,
              ),
              SizedBox(height: 10),
            ],
          );
        });
  }

  InputDecoration getInputDecoration({String hintText, String labelText}) {
    return new InputDecoration(
      hintText: hintText,
      labelText: labelText,
      hintStyle: Theme.of(context).textTheme.body1.merge(
            TextStyle(color: Theme.of(context).hintColor),
          ),
      enabledBorder: UnderlineInputBorder(
          borderSide:
              BorderSide(color: Theme.of(context).hintColor.withOpacity(0.2))),
      focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).hintColor)),
      hasFloatingPlaceholder: true,
      labelStyle: Theme.of(context).textTheme.body1.merge(
            TextStyle(color: Theme.of(context).hintColor),
          ),
    );
  }

  void _submit() async {
    _profileSettingsFormKey.currentState.save();
    print('image path $path');
    if (_profileSettingsFormKey.currentState.validate()) {
      Map<String, dynamic> updatedUserData = {
        'name': name == null ? appUser.name : name,
        'location': address == null ? appUser.location : address,
        'phone': phone == null ? appUser.phone : phone,
        'dob': dob == null ? appUser.dob : dob.toIso8601String(),
        'weight': weight == null ? appUser.weight : weight,
        'height': height == null ? appUser.height : height,
        'history': history == null ? appUser.history : history,
      };

      if (path != null && path != appUser.photo) {
        await UserRepository.updateUserDataWithPhoto(path, updatedUserData)
            .then((response) async {
          Map<String, dynamic> data = json.decode(response);
          UserResponse mResponse = UserResponse.fromJson(data);

          bool result =
              await SharedPrefProvider.saveUser('user', mResponse.user);
          appUser = mResponse.user;
          showSnackBar(result);
        });
      } else {
        await UserRepository.updateUserData(updatedUserData)
            .then((response) async {
          appUser = response.user;
          print("Updated user is ${response.user}");
          bool result =
              await SharedPrefProvider.saveUser('user', response.user);
          showSnackBar(result);
        });
      }
    }
  }

  void showSnackBar(bool result) {
    if (result) {
      setState(() {
        loadSharedPrefs();
      });
      Navigator.pop(context);
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Your Profile data successfully updated'),
      ));
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Update Error! Couldn\'t update your profile....'),
      ));
    }
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget remindButton = FlatButton(
      child: Text("Use Camera"),
      onPressed: () {
        pickImageFromCamera(ImageSource.camera);
      },
    );
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget launchButton = FlatButton(
      child: Text("From Gallery"),
      onPressed: () {
        pickImageFromGallery(ImageSource.gallery);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("New Profile Picture"),
      content: Text("Update your profile picture"),
      actions: [
        remindButton,
        launchButton,
        cancelButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
