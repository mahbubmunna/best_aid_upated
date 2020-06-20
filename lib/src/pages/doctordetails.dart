import 'package:bestaid/config/helper.dart';
import 'package:bestaid/src/models/doctordetails.dart';
import 'package:bestaid/src/providers/doctor_provider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DoctorDetailsPage extends StatefulWidget {
  int id;

  DoctorDetailsPage(this.id);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DoctorDetailsState();
  }
}

class DoctorDetailsState extends State<DoctorDetailsPage> {
  var doctorDetails;

  @override
  void initState() {
    // TODO: implement initState
    doctorDetails = DoctorProvider.getDoctorDetails(widget.id);
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
        padding: EdgeInsets.only(left: 36, right: 36),
        child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 350,
                    width: 300,
                    child: FutureBuilder(
                      future: doctorDetails,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          print(snapshot.data.toString());
                          if (snapshot.error != null) {
                            buildErrorWidget(snapshot.error);
                          }
                          return _buildDoctorInfoWidget(snapshot.data);
                        } else if (snapshot.hasError) {
                          return buildErrorWidget(snapshot.error);
                        } else {
                          return buildLoadingWidget();
                        }
                      },
                    ),
                  ),
                ),
              ),
              top: 90,
            ),
            Positioned(
              child: Container(
                height: 144,
                child: Image.asset('assets/img/33.png'),
              ),
              top: 40,
            ),
            Positioned(
              bottom: 36.0,
              child: MaterialButton(
                height: 44.0,
                color: Colors.white,
                textColor: Colors.white,
                elevation: 8,
                shape: StadiumBorder(),
                onPressed: () {
                  launch("tel:21213123123");
                },
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'GET AN APPOINTMENT',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDoctorInfoWidget(data) {
    if (data is DoctorDetails) {
      Doctor doctor = data.doctor;
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 90.0,
            ),
            Text(
              "${doctor.designation} ${doctor.name}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textScaleFactor: 1.5,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 18.0,
            ),
            RichText(
              maxLines: 1,
              textScaleFactor: 1.2,
              text: new TextSpan(
                // Note: Styles for TextSpans must be explicitly defined.
                // Child text spans will inherit styles from parent
                style: new TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  new TextSpan(
                      text: 'Qualifications:',
                      style: new TextStyle(fontWeight: FontWeight.bold)),
                  new TextSpan(
                    text: ' ${doctor.qualification}',
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            RichText(
              maxLines: 1,
              textScaleFactor: 1.2,
              text: new TextSpan(
                // Note: Styles for TextSpans must be explicitly defined.
                // Child text spans will inherit styles from parent
                style: new TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  new TextSpan(
                      text: 'Speciality:',
                      style: new TextStyle(fontWeight: FontWeight.bold)),
                  new TextSpan(
                    text: ' ${doctor.specialistId}',
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            RichText(
              maxLines: 1,
              textScaleFactor: 1.2,
              text: new TextSpan(
                // Note: Styles for TextSpans must be explicitly defined.
                // Child text spans will inherit styles from parent
                style: new TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  new TextSpan(
                      text: 'Language Spoken:',
                      style: new TextStyle(fontWeight: FontWeight.bold)),
                  new TextSpan(
                    text: ' ${doctor.language}',
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            RichText(
              maxLines: 1,
              textScaleFactor: 1.2,
              text: new TextSpan(
                // Note: Styles for TextSpans must be explicitly defined.
                // Child text spans will inherit styles from parent
                style: new TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  new TextSpan(
                      text: 'Email',
                      style: new TextStyle(fontWeight: FontWeight.bold)),
                  new TextSpan(
                    text: ' ${doctor.email}',
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            RichText(
              maxLines: 1,
              textScaleFactor: 1.2,
              text: new TextSpan(
                // Note: Styles for TextSpans must be explicitly defined.
                // Child text spans will inherit styles from parent
                style: new TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  new TextSpan(
                      text: 'Designation:',
                      style: new TextStyle(fontWeight: FontWeight.bold)),
                  new TextSpan(
                    text: ' ${doctor.designation}',
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            RichText(
              maxLines: 1,
              textScaleFactor: 1.2,
              text: new TextSpan(
                // Note: Styles for TextSpans must be explicitly defined.
                // Child text spans will inherit styles from parent
                style: new TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  new TextSpan(
                      text: 'Institute:',
                      style: new TextStyle(fontWeight: FontWeight.bold)),
                  new TextSpan(
                    text: ' ${doctor.institute}',
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }
}
