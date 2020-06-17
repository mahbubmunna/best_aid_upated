import 'package:animated_splash/animated_splash.dart';
import 'package:bestaid/src/models/user.dart';
import 'package:bestaid/src/pages/login.dart';
import 'package:bestaid/src/pages/otpverify.dart';
import 'package:bestaid/src/pages/pages.dart';
import 'package:bestaid/src/providers/shared_pref_provider.dart';
import 'package:flutter/material.dart';

import 'src/repository/user_repository.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  Map<dynamic, Widget> returnValueAndHomeScreen = {
    1: LoginWidget(),
    2: PagesTestWidget(),
    3: VerifyCode(),
  };

  bool isLogged = false;
  bool isFirstTime = true;

  @override
  void initState() {
    checkIfOnlyFirstTime();
    checkLoggedInOrNot();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplash(
      imagePath: 'assets/splash.png',
      home: LoginWidget(),
      duration: 2500,
      customFunction: properNavigation,
      type: AnimatedSplashType.BackgroundProcess,
      outputAndHome: returnValueAndHomeScreen,
    );
  }

  checkLoggedInOrNot() async {
    if (await SharedPrefProvider.getString('access_token') == null ||
        await SharedPrefProvider.getString('access_token') == '') {
      isLogged = false;
    } else {
      isLogged = true;
      await UserRepository.getUser().then((user) {
        appUser = user.user;
      });
    }
  }

  properNavigation() {
    if (isFirstTime) {
      return 3;
    } else {
      if (isLogged) {
        return 2;
      } else {
        return 1;
      }
    }
  }

  void checkIfOnlyFirstTime() async {
    if (await SharedPrefProvider.getBool('otp') == null) {
      bool result = await SharedPrefProvider.setBool('otp', true);
      print('shared pref is $result');
      setState(() {
        isFirstTime = true;
      });
    } else if (await SharedPrefProvider.getBool('otp') != null &&
        await SharedPrefProvider.getBool('otp') == false) {
      bool result = await SharedPrefProvider.getBool('otp');
      print('the result is $result');
      setState(() {
        isFirstTime = false;
      });
    }
  }
}

User appUser;
var token;
