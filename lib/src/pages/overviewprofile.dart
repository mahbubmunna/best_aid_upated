import 'package:flutter/material.dart';

class OverviewProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _OverviewProfileState();
  }
}

class _OverviewProfileState extends State<OverviewProfile> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
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
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                left: 52.0,
                right: 52.0,
              ),
              child: OutlineButton(
                disabledBorderColor: Theme.of(context).primaryColor,
                child: Text(
                  'Overview Profile',
                  textScaleFactor: 1.5,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                onPressed: () {},
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(
              height: 24.0,
            ),
            Center(
              child: Image.asset(
                'assets/img/user.png',
                height: 96,
                width: 96,
              ),
            ),
            SizedBox(
              height: 24.0,
            ),
            Container(
              color: Theme.of(context).primaryColor,
              height: 2,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                top: 8.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: FlatButton.icon(
                      onPressed: () {},
                      icon: Image.asset(
                        'assets/img/20.png',
                        height: 24.0,
                        width: 24.0,
                      ),
                      label: Text('Birth date'),
                    ),
                    flex: 1,
                  ),
                  Flexible(
                    child: FlatButton.icon(
                      onPressed: () {},
                      icon: Image.asset(
                        'assets/img/21.png',
                        height: 24.0,
                        width: 24.0,
                      ),
                      label: Text('60 kg'),
                    ),
                    flex: 1,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: FlatButton.icon(
                      onPressed: () {},
                      icon: Image.asset(
                        'assets/img/22.png',
                        height: 24.0,
                        width: 24.0,
                      ),
                      label: Text('Location'),
                    ),
                    flex: 1,
                  ),
                  Flexible(
                    child: FlatButton.icon(
                      onPressed: () {},
                      icon: Image.asset(
                        'assets/img/23.png',
                        height: 24.0,
                        width: 24.0,
                      ),
                      label: Text('Height'),
                    ),
                    flex: 1,
                  ),
                ],
              ),
            ),
            Container(
              color: Theme.of(context).primaryColor,
              height: 2,
            ),
            SizedBox(
              height: 56.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 36.0, right: 36.0),
              child: MaterialButton(
                height: 56.0,
                onPressed: () {},
                color: Theme.of(context).primaryColor,
                child: Text(
                  'Confirm and Save',
                  textScaleFactor: 1.3,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
/*FlatButton.icon(
onPressed: () {},
icon: Icon(
Icons.date_range,
color: Theme.of(context).primaryColor,
),
label: Text('Birth date'),
),
FlatButton.icon(
onPressed: () {},
icon: Icon(
Icons.date_range,
color: Theme.of(context).primaryColor,
),
label: Text('Birth date'),
),*/
