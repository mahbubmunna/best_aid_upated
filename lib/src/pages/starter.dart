
import 'package:bestaid/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:bestaid/config/app_config.dart' as config;
import 'package:intl/intl.dart';

class Starter extends StatefulWidget {
  @override
  _StarterState createState() => _StarterState();
}

class _StarterState extends State<Starter> {
  Color _backgroundForBangla;
  Color _backgroundForEnglish;

  @override
  void initState() {
    _backgroundForBangla = config.Colors().accentDarkColor(1);
    _backgroundForEnglish = config.Colors().mainColor(1);
    S.load(Locale(Intl.getCurrentLocale()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Center(child: Text('Hi', style: Theme.of(context).accentTextTheme.display3.copyWith(color: Colors.white),)),
            SizedBox(height: 60,),
            Center(child: Text('Language:', style: Theme.of(context).accentTextTheme.body1,)),
            Chip(
              avatar: CircleAvatar(
                backgroundColor: Colors.grey.shade800,
                child: Image.asset('assets/img/england_flag.png'),
              ),
              label: Text('ENG'),
              deleteIcon: CircleAvatar(
                backgroundColor: _backgroundForEnglish,
              ),
              onDeleted: (){
                setState(() {
                  _backgroundForEnglish = Theme.of(context).accentColor;
                  _backgroundForBangla = Theme.of(context).unselectedWidgetColor;
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
              onDeleted: (){
                setState(() {
                  _backgroundForBangla = Theme.of(context).accentColor;
                  _backgroundForEnglish = Theme.of(context).unselectedWidgetColor;
                  S.load(Locale('bn', 'BD'));
                });
              },
            ),
            SizedBox(height: 40,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 100),
              child: ButtonTheme(
                height: 50,
                buttonColor: Colors.white,
                child: RaisedButton(
                  child: Text('GET STARTED', style: TextStyle(fontSize: 20, color: Theme.of(context).accentColor),),
                  shape: StadiumBorder(),
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil('/Pages', ModalRoute.withName('/'));
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
