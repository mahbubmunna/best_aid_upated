import 'package:bestaid/config/helper.dart';
import 'package:bestaid/src/models/user.dart';
import 'package:bestaid/src/pages/registerfinal.dart';
import 'package:bestaid/src/providers/shared_pref_provider.dart';
import 'package:bestaid/src/repository/token_repository.dart';
import 'package:bestaid/src/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../splash.dart';

class LoginWidget extends StatefulWidget {
  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).accentColor,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        child: Container(
          color: Theme.of(context).accentColor,
        ),
        preferredSize: Size.fromHeight(40),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 40),
        child: ListView(
          children: <Widget>[
            Text(
              'Sign In',
              style: TextStyle(
                  fontSize: 30, color: Theme.of(context).secondaryHeaderColor),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              decoration: InputDecoration(hintText: 'Email'),
              controller: _emailController,
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              decoration: InputDecoration(hintText: 'Password'),
              obscureText: true,
              controller: _passwordController,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Checkbox(
                      value: true,
                      onChanged: (value) {},
                    ),
                    Text('Remember')
                  ],
                ),
                FlatButton(onPressed: () {}, child: Text('Forgot Password?'))
              ],
            ),
            SizedBox(
              height: 20,
            ),
            ButtonTheme(
              height: 50,
              child: RaisedButton(
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                onPressed: () {
                  _login();
                },
                child: _isLoading
                    ? showProgressBar()
                    : Text(
                        'Sign In',
                        style: TextStyle(fontSize: 20),
                      ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
                child: Text(
              'Or',
              style: TextStyle(fontSize: 16),
            )),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 70),
              child: ButtonTheme(
                height: 60,
                buttonColor: Colors.white,
                child: OutlineButton(
                  borderSide: BorderSide(
                      color: Theme.of(context).primaryColor, width: 2),
                  textColor: Theme.of(context).primaryColor,
                  onPressed: () {
                    //Navigator.of(context).pushNamed('/Register');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterPage()));
                  },
                  child: Text(
                    'Create Account',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(child: Text('Already have account?'))
          ],
        ),
      ),
    );
  }

  _login() {
    setState(() {
      _isLoading = true;
      _getAndSaveToken();
    });
  }

  _getAndSaveToken() async {
    var loginInfo = {
      'email': _emailController.text,
      'password': _passwordController.text,
      'device_token': token,
    };
    print(loginInfo);
    var tokenResponse = await TokenRepository.getToken(loginInfo);

    if (!(tokenResponse.error == "" || tokenResponse.error == null)) {
      setState(() {
        _isLoading = false;
        tokenResponse.error == 'Invalid credential'
            ? showErrorDialog(context, "Failure", tokenResponse.error, "close")
            : showErrorDialog(
                context, "Failure", "Failed to Login, try again", "close");
      });
    } else {
      print(tokenResponse.token);
      SharedPrefProvider.setString('access_token', tokenResponse.token);
      _isLoading = false;
      UserRepository.postUser(loginInfo).then((user) async {
        UserResponse mResponse = user;
        appUser = mResponse.user;
        print(mResponse.user);
        SharedPrefProvider.setString('access_token', mResponse.accessToken);

      bool result = await  SharedPrefProvider.saveUser('user', mResponse.user);
      if(result){
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/Starter', ModalRoute.withName('/'));
      }
      });

      setState(() {
        //Scaffold.of(context).showSnackBar(SnackBar(content: Text('Successfully logged in'),));

      });

      var token = await SharedPrefProvider.getString('access_token');
      print('token: $token');
    }
  }
}
