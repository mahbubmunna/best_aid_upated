import 'package:animated_splash/animated_splash.dart';
import 'package:bestaid/src/pages/login.dart';
import 'package:bestaid/src/pages/pages.dart';
import 'package:bestaid/src/providers/shared_pref_provider.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}



class _SplashState extends State<Splash> {
  Map<dynamic, Widget> returnValueAndHomeScreen = {1: LoginWidget(), 2: PagesTestWidget()};
  bool isLogged = false;

  @override
  void initState() {
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
    if ( await SharedPrefProvider.getString('access_token') == null
        ||  await SharedPrefProvider.getString('access_token') == '') {
      isLogged = false;
    } else isLogged = true;
  }

  properNavigation() {
    if(isLogged) {
      return 2;
    } else return 1;
  }
}
