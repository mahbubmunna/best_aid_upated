import 'package:bestaid/src/pages/login.dart';
import 'package:bestaid/src/providers/shared_pref_provider.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
  String verifyString = "Verification";
  String otpDetails = "You'll get a OTP via SMS.";

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
      appBar: codeSent
          ? AppBar(
              backgroundColor: Colors.transparent,
              leading: IconButton(
                onPressed: () {},
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
            )
          : AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
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
                Center(
                  child: codeSent
                      ? Column(
                          children: <Widget>[
                            Text(
                              verifyString,
                              textScaleFactor: 1.5,
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              otpDetails,
                              textScaleFactor: 1.2,
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        )
                      : Text(
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
                  child: codeSent
                      ? TextField(
                          controller: codeController,
                          autocorrect: false,
                          keyboardType: TextInputType.number,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.all(8),
                          ),
                          onChanged: (value) {
                            code = value;
                          },
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Flexible(
                              child: CountryCodePicker(
                                onChanged: (code) {
                                  print(
                                      "on init ${code.name} ${code.dialCode}");
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
                                  print(
                                      "on init ${code.name} ${code.dialCode}");
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
                        ),
                ),
                SizedBox(
                  height: 24.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                  child: MaterialButton(
                    onPressed: () {
                      if (codeSent) {
                        signIn();
                      } else {
                        phoneNumber = "$dialCode$phoneNumber";
                        print(phoneNumber);
                        verifyOTP(phoneNumber);
                      }
                    },
                    color: Theme.of(context).primaryColor,
                    child: Text(
                      codeSent ? 'Verify' : 'Next',
                      textScaleFactor: 1.2,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                codeSent
                    ? InkWell(
                        onTap: () {
                          codeSent = false;
                        },
                        child: RichText(
                          text: new TextSpan(
                            // Note: Styles for TextSpans must be explicitly defined.
                            // Child text spans will inherit styles from parent
                            style: new TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                  text:
                                      "Didn't receive the verification code?"),
                              TextSpan(
                                text: 'Resend Code',
                                style: new TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : SizedBox(
                        height: 16.0,
                      ),
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

    print('the phone $phone');
    _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async {
          AuthResult result = await _auth.signInWithCredential(credential);
          FirebaseUser user = result.user;
          bool otp = await SharedPrefProvider.setBool('otp', false);
          if (otp) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => LoginWidget()));
          }
        },
        verificationFailed: (AuthException exception) {
          print(exception.message.toString());
        },
        codeSent: (String verificationId, [int forceSendingToken]) async {
          this.verificationId = verificationId;
          codeSent = true;
          FirebaseAuth.instance.currentUser().then((user) {
            if (user != null) {
              Fluttertoast.showToast(msg: "Code has been sent to your phone");
            } else {
              signIn();
            }
          });
        },
        codeAutoRetrievalTimeout: (String verId) {
          print(verId);
        });
  }

  signIn() {
    AuthCredential authCredential = PhoneAuthProvider.getCredential(
        verificationId: verificationId, smsCode: code);
    FirebaseAuth.instance
        .signInWithCredential(authCredential)
        .then((user) async {
      bool result = await SharedPrefProvider.setBool('otp', false);
      if (result) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => LoginWidget()));
      }
    }).catchError((e) {
      setState(() {
        codeSent = false;
      });
      Fluttertoast.showToast(msg: e.toString());
      print(e.toString());
    });
  }
}
