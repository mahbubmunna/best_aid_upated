import 'package:bestaid/src/models/registerinfo.dart';
import 'package:bestaid/src/pages/overviewprofile.dart';
import 'package:flutter/material.dart';

class MedicalHistoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MedicalHistoryState();
  }
}

class _MedicalHistoryState extends State<MedicalHistoryPage> {
  String history = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(RegisterInfo.getInfo().photo);
  }

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
            Text(
              'Medical History',
              textScaleFactor: 1.2,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24.0, right: 24.0),
              child: TextField(
                autocorrect: false,
                keyboardType: TextInputType.text,
                maxLines: 7,
                decoration: InputDecoration(
                  hintText: 'Write your medical history',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                onChanged: (value) {
                  history = value;
                },
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24.0, right: 24.0),
              child: MaterialButton(
                height: 56.0,
                onPressed: () {
                  RegisterInfo.getInfo().history = history;
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => OverviewProfile()));
                },
                color: Theme.of(context).primaryColor,
                child: Text(
                  'NEXT',
                  textScaleFactor: 1.5,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            InkWell(
              onTap: () {
                RegisterInfo.getInfo().history = history;
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => OverviewProfile()));
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 32.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      "Skip",
                      textScaleFactor: 1.5,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
