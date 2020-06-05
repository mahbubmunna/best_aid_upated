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
  TextEditingController presentAddressEditingController =
      TextEditingController();
  TextEditingController permanentAddressEditingController =
      TextEditingController();

  String gender = "Male";

  List<String> genderList = ['Male', 'Female', 'Other'];

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
                      onChanged: (value) {},
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
                      onChanged: (value) {},
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
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'Height (in feet)',
                      ),
                      onChanged: (value) {},
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
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'Weight (in kg)',
                      ),
                      onChanged: (value) {},
                    ),
                    flex: 1,
                  )
                ],
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
                onChanged: (value) {},
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
                  hintText: 'Address Permanent',
                ),
                onChanged: (value) {},
              ),
              SizedBox(
                height: 36.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                child: MaterialButton(
                  height: 56.0,
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => UploadPicture()));
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
