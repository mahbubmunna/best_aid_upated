import 'package:bestaid/src/pages/register.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';

class VerifyCode extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _VerifyCodeState();
  }
}

class _VerifyCodeState extends State<VerifyCode> {
  String headerString = "Create Account";
  TextEditingController phoneController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  String phoneNumber = "";
  String dialCode = "";
  bool codeSent = false;
  String code = "";
  String verificationId;

  @override
  void dispose() {
    // TODO: implement dispose
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Padding(
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
          ),
          child: Center(
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                Center(
                  child: Text(
                    headerString,
                    textScaleFactor: 1.5,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 24.0,
                ),
                Container(
                    height: 56.0,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Flexible(
                          child: CountryCodePicker(
                            onChanged: (code) {
                              print("on init ${code.name} ${code.dialCode}");
                              setState(() {
                                dialCode = code.dialCode;
                              });
                            },
                            // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                            initialSelection: 'BD',
                            favorite: ['+88', 'BD'],
                            showFlagDialog: true,
                            showFlag: true,
                            showFlagMain: true,
                            alignLeft: true,
                            comparator: (a, b) => b.name.compareTo(a.name),
                            //Get the country information relevant to the initial selection
                            onInit: (code) {
                              print("on init ${code.name} ${code.dialCode}");
                              dialCode = code.dialCode;
                            },
                          ),
                          flex: 1,
                        ),
                        Flexible(
                          child: TextField(
                            controller: phoneController,
                            autocorrect: false,
                            keyboardType: TextInputType.phone,
                            inputFormatters: <TextInputFormatter>[
                              WhitelistingTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                              hintText: 'Enter your phone number',
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                            ),
                            onChanged: (value) {
                              phoneNumber = value;
                            },
                          ),
                          flex: 2,
                        )
                      ],
                    )
                    /* : Flexible(
                          child: TextField(
                            controller: codeController,
                            autocorrect: false,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                            ),
                            onChanged: (value) {
                              code = value;
                            },
                          ),
                          flex: 2,
                        ),*/
                    ),
                SizedBox(
                  height: 24.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                  child: MaterialButton(
                    onPressed: () {
                      phoneNumber = "$dialCode$phoneNumber";
                      print(phoneNumber);
                      verifyOTP(phoneNumber);
                    },
                    color: Theme.of(context).primaryColor,
                    child: Text(
                      'Next',
                      textScaleFactor: 1.2,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }

  Future<bool> verifyOTP(String phone) async {
    print(phone);
    setState(() {
      phoneNumber = "";
    });
    FirebaseAuth _auth = FirebaseAuth.instance;
    codeSent = true;

    _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async {
          AuthResult result = await _auth.signInWithCredential(credential);
          FirebaseUser user = result.user;
          print(user.toString());
          if (user != null) {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => RegisterWidget()));
          }
        },
        verificationFailed: (AuthException exception) {
          print(exception.message.toString());
        },
        codeSent: (String verificationId, [int forceSendingToken]) async {
          this.verificationId = verificationId;
          smsCodeDialog(context).then((value) {
            print('Signed in');
          });
        },
        codeAutoRetrievalTimeout: (String verId) {
          print(verId);
        });
  }

  Future<bool> smsCodeDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: Text('Enter sms Code'),
            content: TextField(
              onChanged: (value) {
                this.code = value;
              },
            ),
            contentPadding: EdgeInsets.all(10.0),
            actions: <Widget>[
              new FlatButton(
                child: Text('Done'),
                onPressed: () {
                  FirebaseAuth.instance.currentUser().then((user) {
                    if (user != null) {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushReplacementNamed('/homepage');
                    } else {
                      Navigator.of(context).pop();
                      signIn();
                    }
                  });
                },
              )
            ],
          );
        });
  }

  signIn() {
    AuthCredential authCredential = PhoneAuthProvider.getCredential(
        verificationId: verificationId, smsCode: code);
    FirebaseAuth.instance.signInWithCredential(authCredential).then((user) {
      Navigator.of(context).pushReplacementNamed('/homepage');
    }).catchError((e) {
      print(e);
    });
  }
}
