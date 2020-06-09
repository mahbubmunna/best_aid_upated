import 'package:bestaid/src/models/registerinfo.dart';
import 'package:bestaid/src/pages/userinfo.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RegisterState();
  }
}

class _RegisterState extends State<RegisterPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  String email = "";
  String password = "";
  String confirmPassword = "";

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
              TextField(
                controller: emailController,
                autocorrect: false,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(8),
                  hintText: 'Email Address',
                ),
                onChanged: (value) {
                  email = value;
                },
              ),
              SizedBox(
                height: 16.0,
              ),
              TextField(
                controller: passwordController,
                autocorrect: false,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(8),
                  hintText: 'Password',
                ),
                onChanged: (value) {
                  password = value;
                },
              ),
              SizedBox(
                height: 16.0,
              ),
              TextField(
                controller: confirmPasswordController,
                autocorrect: false,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(8),
                  hintText: 'Confirm Password',
                ),
                onChanged: (value) {
                  confirmPassword = value;
                },
              ),
              SizedBox(
                height: 24.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                child: MaterialButton(
                  height: 56.0,
                  onPressed: () {
                    if (email.isNotEmpty) {
                      if (password == confirmPassword) {
                        RegisterInfo.getInfo().email = email;
                        RegisterInfo.getInfo().password = password;
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => UserInfoPage()));
                      }
                    }
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
