import 'dart:math' as math;

import 'package:bestaid/config/helper.dart';
import 'package:bestaid/src/models/specialist.dart';
import 'package:bestaid/src/pages/doctorlist.dart';
import 'package:bestaid/src/repository/specialist_repository.dart';
import 'package:flutter/material.dart';

class SpecialistPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SpecialistState();
  }
}

class _SpecialistState extends State<SpecialistPage> {
  var specialistResponse;
  String id = "";
  String title = "";

  @override
  void initState() {
    // TODO: implement initState
    specialistResponse = SpecialistRepository.getSpecialistList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.white,
        ),
        title: Text('Back'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 50,
          right: 50,
        ),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 24.0,
            ),
            MaterialButton(
              height: 56,
              onPressed: () {},
              elevation: 8,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Specialist',
                        textScaleFactor: 1.5,
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Transform.rotate(
                        angle: 90 * math.pi / 180,
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Flexible(
              child: FutureBuilder(
                future: specialistResponse,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.error != null) {
                      buildErrorWidget(snapshot.error);
                    }
                    return _postListWidget(snapshot.data);
                  } else if (snapshot.hasError) {
                    return buildErrorWidget(snapshot.error);
                  } else {
                    return buildLoadingWidget();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _postListWidget(data) {
    if (data is SpecialistResponse) {
    //  print(data.specialist.toString());
      return ListView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemCount: data.specialist.length,
          itemBuilder: (context, index) {
            Specialist post = data.specialist[index];

            return Column(
              children: <Widget>[
                ConstrainedBox(
                  constraints: BoxConstraints(minWidth: double.infinity),
                  child: MaterialButton(
                      height: 44.0,
                      color: Colors.white,
                      textColor: Theme.of(context).accentColor,
                      elevation: 8,
                      shape: StadiumBorder(),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DoctorListScreen(
                                    post.id.toString(), post.name)));
                      },
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Expanded(
                              child: Stack(
                                children: <Widget>[
                                  Center(
                                    child: Text(
                                      post.name,
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                  ),
                                  Positioned(
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      color: Theme.of(context).accentColor,
                                    ),
                                    right: 4,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
                SizedBox(
                  height: 16.0,
                ),
              ],
            );
          });
    }
  }
}
