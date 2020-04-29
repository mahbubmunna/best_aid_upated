import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginWidget extends StatefulWidget {
  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Theme.of(context).accentColor,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark
    ));

    return Scaffold(
      appBar: PreferredSize(
        child: Container(color: Theme.of(context).accentColor,),
        preferredSize: Size.fromHeight(40),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 40),
        child: ListView(
          children: <Widget>[
            Text('Sign In', style: TextStyle(fontSize: 30, color: Theme.of(context).secondaryHeaderColor),),
            SizedBox(height: 20,),
            TextField(decoration: InputDecoration(hintText: 'Email'),),
            SizedBox(height: 20,),
            TextField(decoration: InputDecoration(hintText: 'Password'),),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Checkbox(
                      value: true,
                      onChanged: (value){},
                    ),
                    Text('Remember')
                  ],
                ),
                FlatButton(
                  onPressed: (){},
                    child: Text('Forgot Password?'))
              ],
            ),
            SizedBox(height: 20,),
            ButtonTheme(
              height: 50,
              child: RaisedButton(
                color: Theme.of(context).secondaryHeaderColor,
                textColor: Colors.white,
                onPressed: (){
                  Navigator.of(context).
                  pushNamedAndRemoveUntil(
                      '/Starter', ModalRoute.withName('/'));
                },
                child: Text('Sign In', style: TextStyle(fontSize: 20),),
              ),
            ),
            SizedBox(height: 20,),
            Center(child: Text('Or', style: TextStyle(fontSize: 16),)),
            SizedBox(height: 20,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 70),
              child: ButtonTheme(
                height: 60,
                buttonColor: Colors.white,
                child: OutlineButton(
                  borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2),
                  textColor: Theme.of(context).primaryColor,
                  onPressed: () {Navigator.of(context).pushNamed('/Register');},
                  child: Text('Create Account', style: TextStyle(fontSize: 20),),
                ),
              ),
            ),
            SizedBox(height: 10,),
            Center(child: Text('Already have account?'))
          ],
        ),
      ),
    );
  }
}
