import 'dart:math' as math;

import 'package:bestaid/config/helper.dart';
import 'package:bestaid/src/models/doctors.dart';
import 'package:bestaid/src/repository/doctor_repository.dart';
import 'package:bestaid/src/widgets/doctor_list_item.dart';
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
          left: 18,
          right: 18,
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
                  return Center();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _postListWidget(data) {
    print(data);
    if (data is DoctorResponse) {
      if (data.doctors.isEmpty) {
        return Center(
          child: Text(
            'Sorry, currently no doctor is available',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      }
      return ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: data.doctors.length,
        itemBuilder: (context, index) {
          Doctors post = data.doctors[index];
          return DoctorItem(post);
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
