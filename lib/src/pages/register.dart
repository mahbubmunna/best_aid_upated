import 'package:bestaid/config/helper.dart';
import 'package:bestaid/src/providers/shared_pref_provider.dart';
import 'package:bestaid/src/repository/token_repository.dart';
import 'package:bestaid/src/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'login.dart';

class RegisterWidget extends StatefulWidget {
  @override
  _RegisterWidgetState createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
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
            Text('Register', style: TextStyle(fontSize: 30, color: Theme.of(context).secondaryHeaderColor),),
            SizedBox(height: 20,),
            TextField(decoration: InputDecoration(hintText: 'Full Name',), controller: _nameController,),
            SizedBox(height: 20,),
            TextField(decoration: InputDecoration(hintText: 'Email'), controller: _emailController,),
            SizedBox(height: 20,),
            TextField(decoration: InputDecoration(hintText: 'Password'), controller: _passwordController, obscureText: true,),
            SizedBox(height: 20,),
//            Row(
//              mainAxisAlignment: MainAxisAlignment.spaceBetween,
//              children: <Widget>[
//                Row(
//                  children: <Widget>[
//                    Checkbox(
//                      value: true,
//                      onChanged: (value){},
//                    ),
//                    Text('Remember')
//                  ],
//                ),
//                FlatButton(
//                  onPressed: (){},
//                    child: Text('Forgot Password?'))
//              ],
//            ),
            SizedBox(height: 20,),
            ButtonTheme(
              height: 50,
              child: RaisedButton(
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                onPressed: (){
                  _register();
                },
                child: _isLoading ? showProgressBar() : Text('Register', style: TextStyle(fontSize: 20),),
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
                  onPressed: () {Navigator.of(context).pushNamed('/Login');},
                  child: Text('Back to login', style: TextStyle(fontSize: 20),),
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

  _register() {
    setState(() {
      _isLoading = true;
      _getAndSaveToken();
    });
  }

  _getAndSaveToken() async {
    var registrationInfo = {
      'name': _nameController.text,
      'email': _emailController.text,
      'password': _passwordController.text,
    };
    print(registrationInfo);
    var tokenResponse = await TokenRepository.getToken(registrationInfo);

    if (!(tokenResponse.error == "" || tokenResponse.error == null)) {
      setState(() {
        _isLoading = false;
        tokenResponse.error == 'Invalid credential' ? showErrorDialog(
            context, "Failure", tokenResponse.error, "close") : showErrorDialog(
            context, "Failure", "Failed to Login, try again", "close");
      });
    } else {
      print(tokenResponse.token);
      SharedPrefProvider.setString('access_token', tokenResponse.token);
      _isLoading = false;
      UserRepository.postUser(registrationInfo).then((user) {
        appUser = user.user;
      });
      setState(() {
        //Scaffold.of(context).showSnackBar(SnackBar(content: Text('Successfully logged in'),));
        Navigator.of(context).pushNamedAndRemoveUntil('/Starter', ModalRoute.withName('/'));
      });
      var token = await SharedPrefProvider.getString('access_token');
      print('fucking token: $token');
    }
  }

}
