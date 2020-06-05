import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UploadPicture extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _UploadPictureState();
  }
}

class _UploadPictureState extends State<UploadPicture> {
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
            Center(
              child: Image.asset(
                'assets/img/user.png',
                height: 96,
                width: 96,
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            Text(
              'Upload Profile Picture',
              textScaleFactor: 1.5,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 24.0,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 24.0,
                right: 24.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: MaterialButton(
                      color: Theme.of(context).primaryColor,
                      onPressed: () {},
                      child: Text(
                        'Open Gallery',
                        textScaleFactor: .8,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    flex: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Or',
                    ),
                  ),
                  Flexible(
                    child: OutlineButton(
                        disabledBorderColor: Theme.of(context).primaryColor,
                        color: Theme.of(context).primaryColor,
                        highlightColor: Theme.of(context).primaryColor,
                        child: Row(
                          children: <Widget>[
                            Text(
                              "Open Camera",
                              textScaleFactor: .8,
                            ),
                            Icon(
                              Icons.camera_alt,
                              color: Theme.of(context).primaryColor,
                            ),
                          ],
                        ),
                        onPressed: () {},
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(8.0),
                        )),
                    flex: 1,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Padding(
              padding: const EdgeInsets.only(right:32.0),
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
          ],
        ),
      ),
    );
  }
}
