import 'package:bestaid/config/helper.dart';
import 'package:bestaid/src/pages/login.dart';
import 'package:bestaid/src/providers/shared_pref_provider.dart';
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
  String verifyString = "Verification";
  String otpDetails = "You'll get a OTP via SMS.";
  var firebaseAuth = FirebaseAuth.instance;
  var _authCredential;

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
                onPressed: () {
                  if (codeSent) {
                    setState(() {
                      codeSent = false;
                    });
                  }
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
                      /*  bool result =
                            AuthService().signInWithOTP(code, verificationId);
                        if (result) {
                          codeController.clear();
                          AuthService().signOut();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => LoginWidget()));
                        }*/
                      /*   AuthCredential authCredential =
                            PhoneAuthProvider.getCredential(
                                verificationId: verificationId, smsCode: code);
                        _verificationComplete(authCredential, context);
                      } else {*/
                      if (codeSent) {
                        showLoaderDialog(context);
                        _signInWithPhoneNumber(code);
                      } else {
                        phoneNumber = "$dialCode$phoneNumber";
                        startAuth(phoneNumber);
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

/*  signIn() {
    AuthCredential authCredential = PhoneAuthProvider.getCredential(
        verificationId: verificationId, smsCode: code);
    codeController.clear();
    FirebaseAuth.instance
        .signInWithCredential(authCredential)
        .then((user) async {
      bool result = await SharedPrefProvider.setBool('otp', false);
      if (result) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => LoginWidget()));
      }
    }).catchError((e) {
      */ /*setState(() {
        codeSent = false;
      });*/ /*
      //  Fluttertoast.showToast(msg: e.toString());
      print(e.toString());
    });
  }

  Future<void> verifyPhone(phoneNo) async {
    setState(() {
      phoneNumber = "";
      phoneController.clear();
    });
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      AuthService().signIn(authResult);
    };

    final PhoneVerificationFailed verificationfailed =
        (AuthException authException) {
      print('${authException.message}');
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      this.verificationId = verId;
      setState(() {
        this.codeSent = true;
      });
      Fluttertoast.showToast(msg: "Code has been sent to your phone");
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;
    };

    codeSent = true;
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: const Duration(seconds: 60),
        verificationCompleted: verified,
        verificationFailed: verificationfailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }*/

  Future<void> startAuth(phoneNumber) async {
    setState(() {
      this.phoneNumber = "";
    });
    phoneController.clear();
    final PhoneCodeSent phoneCodeSent =
        (String verificationId, [int forceResendingToken]) async {
      this.verificationId = verificationId;
    };
    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      this.verificationId = verificationId;
    };
    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {
      print(authException.message);
    };
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential auth) {
      //_authCredential = auth;

      firebaseAuth
          .signInWithCredential(_authCredential)
          .then((AuthResult value) {
        if (value.user != null) {
          onAuthenticationSuccessful();
        } else {
          _signInWithPhoneNumber(code);
        }
      }).catchError((error) {
        print(error.toString());
      });
    };
    codeSent = true;
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 60),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: phoneCodeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  void _signInWithPhoneNumber(String smsCode) async {
    _authCredential = PhoneAuthProvider.getCredential(
        verificationId: this.verificationId, smsCode: smsCode);
    firebaseAuth
        .signInWithCredential(_authCredential)
        .catchError((error) {})
        .then((AuthResult result) async {
      onAuthenticationSuccessful();
    });
  }

  void onAuthenticationSuccessful() async {
    bool result = await SharedPrefProvider.setBool('otp', false);
    if (result) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => LoginWidget()));
    }
  }
}
