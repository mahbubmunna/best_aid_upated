import 'package:bestaid/config/helper.dart';
import 'package:bestaid/src/models/doctordetails.dart';
import 'package:bestaid/src/providers/doctor_provider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DoctorDetailsFinal extends StatefulWidget {
  int id;

  DoctorDetailsFinal(this.id);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState

    return _DoctorDetailsFinalState();
  }
}

class _DoctorDetailsFinalState extends State<DoctorDetailsFinal> {
  var doctorDetails;
  String phoneNumber;

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
            icon: Icon(
              Icons.arrow_back_ios,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text('Back'),
        elevation: 0,
      ),
      body: Padding(
          padding: EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            top: 16.0,
          ),
          child: Card(
            color: Colors.white,
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: <Widget>[
                    FutureBuilder(
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: MaterialButton(
                          minWidth: MediaQuery.of(context).size.width,
                          height: 44.0,
                          color: Theme.of(context).primaryColor,
                          textColor: Colors.white,
                          elevation: 8,
                          onPressed: () {
                            launch("tel:+8801533443118");
                          },
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              'GET AN APPOINTMENT',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          )),
    );
  }

  Widget _buildDoctorInfoWidget(data) {
    if (data is DoctorDetails) {
      Doctor doctor = data.doctor;
      return Column(
        children: <Widget>[
          SizedBox(
            height: 16.0,
          ),
          Align(
            alignment: Alignment.topCenter,
            child: doctor.photo.endsWith("storage/")
                ? Container(
                    padding: EdgeInsets.only(top: 24.0),
                    height: 144,
                    child: Image.asset('assets/img/33.png'),
                  )
                : Positioned(
                    bottom: 10.0,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black45,
                            offset: Offset(0, 2),
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Image(
                          height: 120.0,
                          width: 120.0,
                          image: NetworkImage(doctor.photo),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
          ),
          SizedBox(
            height: 16.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "${doctor.name}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textScaleFactor: 1.5,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "${doctor.designation}",
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  textScaleFactor: 1.2,
                  style: TextStyle(
                    color: Colors.black,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                child: Text(
                  "${doctor.qualification}",
                  maxLines: 3,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  textScaleFactor: 1.2,
                  style: TextStyle(
                    color: Colors.black,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      "Institute",
                      textScaleFactor: 1.2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${doctor.institute}",
                      textScaleFactor: 1.2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      "About Doctor",
                      textScaleFactor: 1.2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Text(
                      doctor.about != null
                          ? "${doctor.about}"
                          : "Info not found",
                      maxLines: 5,
                      textAlign: TextAlign.center,
                      textScaleFactor: 1.2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      );
    }
  }
}
