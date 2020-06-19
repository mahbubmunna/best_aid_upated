import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';

import 'app_config.dart' as config;

String handleError(Error error) {
  String errorDescription = "";
  if (error is DioError) {
    DioError dioError = error as DioError;
    switch (dioError.type) {
      case DioErrorType.CANCEL:
        errorDescription = "Request to API server was cancelled";
        break;
      case DioErrorType.CONNECT_TIMEOUT:
        errorDescription = "Connection timeout with API server";
        break;
      case DioErrorType.DEFAULT:
        errorDescription =
            "Connection to API server failed due to internet connection";
        break;
      case DioErrorType.RECEIVE_TIMEOUT:
        errorDescription = "Receive timeout in connection with API server";
        break;
      case DioErrorType.RESPONSE:
        errorDescription =
            "Received invalid status code: ${dioError.response.statusCode}";
        break;
      case DioErrorType.SEND_TIMEOUT:
        errorDescription = "Send timeout in connection with API server";
        break;
    }
  } else {
    errorDescription = "Unexpected error occured";
  }
  return errorDescription;
}

showProgressBar() {
  return Column(
    children: <Widget>[CircularProgressIndicator()],
  );
}

//
showErrorDialog(
    BuildContext context, String title, String content, String action) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(title),
          content: new Text(content),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text(action),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
}

showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: new Row(
      children: [
        CircularProgressIndicator(),
        Container(margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

buildErrorWidget(String error) {
  return Center(
      child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text("Something went wrong"),
      //Text("Network Error"),
    ],
  ));
}

buildLoadingWidget() {
  return Center(
      child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Loading(
        indicator: BallPulseIndicator(),
        size: 50,
        color: config.Colors().primaryColor(1),
      )
    ],
  ));
}
