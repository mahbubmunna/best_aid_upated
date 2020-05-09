
import 'package:bestaid/src/models/route_argument.dart';
import 'package:bestaid/src/pages/1click_doctor.dart';
import 'package:bestaid/src/pages/expert_opinion.dart';
import 'package:bestaid/src/pages/login.dart';
import 'package:bestaid/src/pages/news_feed.dart';
import 'package:bestaid/src/pages/online_consultancy.dart';
import 'package:bestaid/src/pages/pages.dart';
import 'package:bestaid/src/pages/post_detail.dart';
import 'package:bestaid/src/pages/post_problem.dart';
import 'package:bestaid/src/pages/problem_detail.dart';
import 'package:bestaid/src/pages/register.dart';
import 'package:bestaid/src/pages/starter.dart';
import 'package:bestaid/src/pages/your_history.dart';
import 'package:bestaid/splash.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Splash());
      case '/Starter':
        return MaterialPageRoute(builder: (_) => Starter());
      case '/Login':
        return MaterialPageRoute(builder: (_) => LoginWidget());
      case '/Register':
        return MaterialPageRoute(builder: (_) => RegisterWidget());
      case '/ExpertOpinion':
        return MaterialPageRoute(builder: (_) => ExpertOpinion());
      case '/PostProblem':
        return MaterialPageRoute(builder: (_) => PostProblem());
      case '/YourHistory':
        return MaterialPageRoute(builder: (_) => YourHistory());
      case '/NewsFeed':
        return MaterialPageRoute(builder: (_) => NewsFeed());
      case '/OnlineConsultancy':
        return MaterialPageRoute(builder: (_) => OnlineConsultancy());
      case '/OneClickDoctor':
        return MaterialPageRoute(builder: (_) => OneClickDoctor());
      case '/ProblemDetails':
        return MaterialPageRoute(builder: (_) => ProblemDetails(routeArgument: args as RouteArgument,));
      case '/PostDetails':
        return MaterialPageRoute(builder: (_) => PostDetails(routeArgument: args as RouteArgument,));
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return MaterialPageRoute(builder: (_) => PagesTestWidget(currentTab: 2, routeArgument: args as RouteArgument,));
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
