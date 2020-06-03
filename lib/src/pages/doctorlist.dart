import 'dart:math' as math;

import 'package:bestaid/config/helper.dart';
import 'package:bestaid/src/models/doctors.dart';
import 'package:bestaid/src/pages/doctordetails.dart';
import 'package:bestaid/src/repository/doctor_repository.dart';
import 'package:flutter/material.dart';

class DoctorListScreen extends StatefulWidget {
  String id;
  String title;

  DoctorListScreen(this.id, this.title);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DoctorListState();
  }
}

class DoctorListState extends State<DoctorListScreen> {
  var doctorResponse;

  @override
  void initState() {
    doctorResponse = DoctorRepository.getDoctorList(widget.id);
    // TODO: implement initState
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
          left: 24,
          right: 24,
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
                        widget.title,
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
              height: 24.0,
            ),
            Flexible(
              child: FutureBuilder(
                future: doctorResponse,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    print(snapshot.data.toString());
                    if (snapshot.error != null) {
                      buildErrorWidget(snapshot.error);
                    }
                    return _postListWidget(snapshot.data);
                  } else if (snapshot.hasError) {
                    return buildErrorWidget(snapshot.error);
                  } else {
                    buildLoadingWidget();
                  }
                  return Center(
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _postListWidget(data) {
    if (data is DoctorResponse) {
      print(data.doctors.length);
      return ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: data.doctors.length,
        itemBuilder: (context, index) {
          Doctors post = data.doctors[index];

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Container(
                height: 120,
                child: Card(
                  child: Center(
                    child: ListTile(
                      leading: Image.asset(
                        'assets/img/17.png',
                      ),
                      title: Text(
                        post.name,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        post.qualification,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: SizedBox(
                        height: 25,
                        width: 100,
                        child: MaterialButton(
                          shape: StadiumBorder(),
                          color: Theme.of(context).primaryColor,
                          textColor: Colors.white,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        DoctorDetailsPage(post.id)));
                          },
                          child: Text(
                            'More Details',
                            textScaleFactor: .7,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    } else {
      return Center(
        child: Text(
          'Stay tuned',
          style: TextStyle(color: Colors.white),
        ),
      );
    }
  }
}
