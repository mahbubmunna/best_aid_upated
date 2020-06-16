import 'dart:io';

import 'package:bestaid/src/models/registerinfo.dart';
import 'package:bestaid/src/pages/medicalhistory.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadPicture extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _UploadPictureState();
  }
}

class _UploadPictureState extends State<UploadPicture> {
  ImagePicker mPicker = ImagePicker();
  PickedFile _pickedFile;
  bool pickedImage = false;
  String path = "";

  pickImageFromGallery(ImageSource source) async {
    final imageFile = await mPicker.getImage(
        source: source, maxWidth: 96, maxHeight: 96, imageQuality: 90);
    setState(() {
      _pickedFile = imageFile;
      pickedImage = true;
      path = _pickedFile.path;
    });
  }

  pickImageFromCamera(ImageSource source) async {
    final imageFile = await mPicker.getImage(
        source: source, maxHeight: 96, maxWidth: 96, imageQuality: 90);

    setState(() {
      _pickedFile = imageFile;
      pickedImage = true;
      path = _pickedFile.path;
    });
  }

  Widget showImage() {
    return Container(
      height: 96.0,
      width: 96.0,
      decoration: new BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0x33A6A6A6)),
        image: DecorationImage(
            image: Image.file(
              File(
                path,
              ),
            ).image,
            fit: BoxFit.fill),
        // image: new Image.asset(_image.)
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(RegisterInfo.getInfo().email + RegisterInfo.getInfo().name);
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
            Center(
              child: pickedImage
                  ? showImage()
                  : Image.asset(
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
                      onPressed: () {
                        pickImageFromGallery(ImageSource.gallery);
                      },
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
                      onPressed: () {
                        pickImageFromCamera(ImageSource.camera);
                      },
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(8.0),
                      ),
                    ),
                    flex: 1,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 24.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24.0, right: 24.0),
              child: MaterialButton(
                height: 56.0,
                onPressed: () {
                  RegisterInfo.getInfo().photo = path;
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MedicalHistoryPage()));
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
              height: 16.0,
            ),
            InkWell(
              onTap: () {
                RegisterInfo.getInfo().photo = path;
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MedicalHistoryPage()));
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
