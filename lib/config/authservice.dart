import 'package:bestaid/src/providers/shared_pref_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  //Handles Auth
/*  handleAuth() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return DashboardPage();
          } else {
            return LoginPage();
          }
        });
  }*/

  //Sign out
  signOut() {
    FirebaseAuth.instance.signOut();
  }

  //SignIn
  signIn(AuthCredential authCredential) {
    FirebaseAuth.instance
        .signInWithCredential(authCredential)
        .then((user) async {
      bool result = await SharedPrefProvider.setBool('otp', false);

      if (result) {
        return true;
      } else {
        return false;
      }
    }).catchError((e) {
      print(e.toString());
    });
  }

  signInWithOTP(smsCode, verId) {
    AuthCredential authCreds = PhoneAuthProvider.getCredential(
        verificationId: verId, smsCode: smsCode);
    bool result = signIn(authCreds);

    return result;
  }
}
