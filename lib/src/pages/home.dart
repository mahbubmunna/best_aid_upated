
import 'package:bestaid/src/models/route_argument.dart';
import 'package:flutter/material.dart';


class HomeWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  HomeWidget({Key key, this.parentScaffoldKey}) : super(key: key);
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {

  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.only(top: 80, left: 20, right: 20),
        child: ListView(
          children: <Widget>[
            Image.asset('assets/img/logo.png', ),
            SizedBox(height: 20,),
            MaterialButton(
              elevation: 8,
              color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: Image.asset('assets/img/expert.png'),
                    title: Text('Expert Option', style: TextStyle(color: Theme.of(context).primaryColor,),),
                    trailing: Icon(Icons.arrow_forward_ios, color: Theme.of(context).primaryColor,),
                  ),
                ), onPressed: () {Navigator.of(context).pushNamedAndRemoveUntil('/Pages', ModalRoute.withName('/'), arguments: RouteArgument(param: 1));},
              ),
            SizedBox(height: 20,),
            MaterialButton(
              elevation: 8,
              color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: Image.asset('assets/img/consultancy.png'),
                    title: Text('Online Doctor Consultancy', style: TextStyle(color: Theme.of(context).primaryColor,),),
                    trailing: Icon(Icons.arrow_forward_ios, color: Theme.of(context).primaryColor,),
                  ),
                ), onPressed: () {Navigator.of(context).pushNamed('/OnlineConsultancy');},
              ),
            SizedBox(height: 20,),
            MaterialButton(
              elevation: 8,
              color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: Image.asset('assets/img/doctor.png'),
                    title: Text('1Click Doctor', style: TextStyle(color: Theme.of(context).primaryColor,),),
                    trailing: Icon(Icons.arrow_forward_ios, color: Theme.of(context).primaryColor,),
                  ),
                ), onPressed: () {Navigator.of(context).pushNamed('/OneClickDoctor');},
              ),

          ],
        ),
      )
    );
  }
}
