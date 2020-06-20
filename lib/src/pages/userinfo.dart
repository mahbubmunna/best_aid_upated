import 'package:bestaid/src/models/registerinfo.dart';
import 'package:bestaid/src/pages/uploadpropic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UserInfoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _UserInfoState();
  }
}

class _UserInfoState extends State<UserInfoPage> {
  TextEditingController firstNameEditingController = TextEditingController();
  TextEditingController lastNameEditingController = TextEditingController();
  TextEditingController heightEditingController = TextEditingController();
  TextEditingController weightEditingController = TextEditingController();
  TextEditingController dobEditingController = TextEditingController();
  TextEditingController presentAddressEditingController =
      TextEditingController();
  TextEditingController permanentAddressEditingController =
      TextEditingController();

  String gender = "Male";

  DateTime selectedDate = DateTime.now();

  List<String> genderList = ['Male', 'Female', 'Other'];

  String name = "";
  String firstName = "";
  String lastName = "";
  String height = "";
  String weight = "";
  String presentAddress = "";
  String permanentAddress = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1901, 1),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        dobEditingController.value = TextEditingValue(text: picked.toString().substring(0,10));
      });
    else if (picked == selectedDate){
      setState(() {
        dobEditingController.value = TextEditingValue(text: picked.toString().substring(0,10));
      });
    }
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
      body: Padding(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
        ),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: TextField(
                      controller: firstNameEditingController,
                      autocorrect: false,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'First Name',
                      ),
                      onChanged: (value) {
                        firstName = value;
                      },
                    ),
                    flex: 1,
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Flexible(
                    child: TextField(
                      controller: lastNameEditingController,
                      autocorrect: false,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'Last Name',
                      ),
                      onChanged: (value) {
                        lastName = value;
                      },
                    ),
                    flex: 1,
                  )
                ],
              ),
              SizedBox(
                height: 16.0,
              ),
              Container(
                height: 56.0,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(
                    5.0,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        'Gender',
                        textAlign: TextAlign.center,
                        textScaleFactor: 1.2,
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      flex: 1,
                    ),
                    SizedBox(
                      width: 16.0,
                    ),
                    Flexible(
                      child: DropdownButton<String>(
                        value: gender,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.grey, fontSize: 18),
                        onChanged: (String data) {
                          setState(() {
                            gender = data;
                          });
                        },
                        items: genderList
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      flex: 1,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: TextField(
                      controller: heightEditingController,
                      autocorrect: false,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Height (in feet)',
                      ),
                      onChanged: (value) {
                        height = value;
                      },
                    ),
                    flex: 1,
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Flexible(
                    child: TextField(
                      controller: weightEditingController,
                      autocorrect: false,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Weight (in kg)',
                      ),
                      onChanged: (value) {
                        weight = value;
                      },
                    ),
                    flex: 1,
                  )
                ],
              ),
              SizedBox(
                height: 16.0,
              ),
              GestureDetector(
                onTap: () {
                  _selectDate(context);
                },
                child: AbsorbPointer(
                  child: TextField(
                    controller: dobEditingController,
                    autocorrect: false,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                      hintText: 'Date of Birth',
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              TextField(
                controller: presentAddressEditingController,
                autocorrect: false,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'Address Present',
                ),
                onChanged: (value) {
                  presentAddress = value;
                },
              ),
              SizedBox(
                height: 16.0,
              ),
              TextField(
                controller: permanentAddressEditingController,
                autocorrect: false,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'Address Permanent',
                ),
                onChanged: (value) {
                  permanentAddress = value;
                },
              ),
              SizedBox(
                height: 36.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                child: MaterialButton(
                  height: 56.0,
                  onPressed: () {
                    if (firstName != "") {
                      RegisterInfo.getInfo().name = firstName + " " + lastName;
                    } else {
                      RegisterInfo.getInfo().name = firstName;
                    }
                    RegisterInfo.getInfo().gender = gender;
                    RegisterInfo.getInfo().height = height;
                    RegisterInfo.getInfo().weight = weight;
                    RegisterInfo.getInfo().location = presentAddress;
                    RegisterInfo.getInfo().permanentLocation = permanentAddress;
                    RegisterInfo.getInfo().dob = dobEditingController.text;
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => UploadPicture()));
                  },
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    'NEXT',
                    textScaleFactor: 1.5,
                    style: TextStyle(
                      color: Colors.white,
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
