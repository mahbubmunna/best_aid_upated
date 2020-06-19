import 'package:bestaid/config/app_config.dart' as config;
import 'package:bestaid/generated/l10n.dart';
import 'package:bestaid/src/models/user.dart';
import 'package:bestaid/src/providers/shared_pref_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Starter extends StatefulWidget {
  @override
  _StarterState createState() => _StarterState();
}

class _StarterState extends State<Starter> with SingleTickerProviderStateMixin {
  Color _backgroundForBangla;
  Color _backgroundForEnglish;
  User appUser;
  AnimationController _controller;
  Animation _animation;


  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _animation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(_controller);
    _backgroundForBangla = config.Colors().accentDarkColor(1);
    _backgroundForEnglish = config.Colors().accentColor(1);
    S.load(Locale(Intl.getCurrentLocale()));
    super.initState();
    loadSharedPrefs();
  }

  loadSharedPrefs() async {
    try {
      User user = await SharedPrefProvider.read('user');
      print(user);
      setState(() {
        appUser = user;
        print(appUser.role);
      });
    } catch (e) {
      // do something
      print(e);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    _controller.forward();
    return FadeTransition(
      opacity: _animation,
      child: Scaffold(
        body: Center(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Center(
                  child: Text(
                'Hi',
                style: Theme.of(context)
                    .accentTextTheme
                    .display3
                    .copyWith(color: Colors.white),
              )),
              SizedBox(
                height: 60,
              ),
              Center(
                  child: Text(
                'Language:',
                style: Theme.of(context).accentTextTheme.body1,
              )),
              Chip(
                avatar: CircleAvatar(
                  backgroundColor: Colors.grey.shade800,
                  child: Image.asset('assets/img/england_flag.png'),
                ),
                label: Text('ENG'),
                deleteIcon: CircleAvatar(
                  backgroundColor: _backgroundForEnglish,
                ),
                onDeleted: () {
                  setState(() {
                    _backgroundForEnglish = Theme.of(context).accentColor;
                    _backgroundForBangla =
                        Theme.of(context).unselectedWidgetColor;
                    S.load(Locale('en', 'US'));
                  });
                },
              ),
              Chip(
                avatar: CircleAvatar(
                  backgroundColor: Colors.grey.shade800,
                  child: Image.asset('assets/img/bangladesh_flag.png'),
                ),
                label: Text('BAN'),
                deleteIcon: CircleAvatar(
                  backgroundColor: _backgroundForBangla,
                ),
                onDeleted: () {
                  setState(() {
                    _backgroundForBangla = Theme.of(context).accentColor;
                    _backgroundForEnglish =
                        Theme.of(context).unselectedWidgetColor;
                    S.load(Locale('bn', 'BD'));
                  });
                },
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 100),
                child: ButtonTheme(
                  height: 50,
                  buttonColor: Colors.white,
                  child: RaisedButton(
                    child: Text(
                      'GET STARTED',
                      style: TextStyle(
                          fontSize: 20, color: Theme.of(context).accentColor),
                    ),
                    shape: StadiumBorder(),
                    onPressed: () {
                     if(appUser.role == "user"){
                       Navigator.of(context).pushNamedAndRemoveUntil(
                           '/Pages', ModalRoute.withName('/'));
                     }else{
                       Navigator.of(context).pushNamedAndRemoveUntil(
                           '/PageDoctor', ModalRoute.withName('/'));
                     }
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
