import 'package:bestaid/route_generator.dart';
import 'package:bestaid/splash.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_localizations.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:bestaid/config/app_config.dart' as config;
import 'package:bestaid/src/repository/settings_repository.dart' as settingRepo;
import 'package:global_configuration/global_configuration.dart';
import 'generated/l10n.dart';

FirebaseAnalytics analytics = FirebaseAnalytics();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalConfiguration().loadFromAsset("configurations");
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey(debugLabel: "Main Navigator");
  final Firestore _db = Firestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging();
  @override
  void initState() {
    /*_fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        showDialog(context: context, builder: (context) => AlertDialog(
          content: Text(message['notification']['body']),
        ));
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        _goToDeeplyNestedView();
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        _goToDeeplyNestedView();
      },
    );
    _getFirebaseToken();*/
    super.initState();
  }

  _goToDeeplyNestedView() {
    Navigator.of(navigatorKey.currentContext).pushNamed('/YourHistory');
  }

  _getFirebaseToken() async {
    await _fcm.getToken().then((value) {token = value;});
    print(token);
  }

  @override
  Widget build(BuildContext context) {

    return DynamicTheme(
        defaultBrightness: Brightness.light,
        data: (brightness) {
          if (brightness == Brightness.light) {
            return ThemeData(
              fontFamily: 'Poppins',
              scaffoldBackgroundColor: config.Colors().accentColor(1),
              appBarTheme: AppBarTheme(color: config.Colors().accentColor(1)),
              primaryColor: config.Colors().primaryColor(1),
              brightness: brightness,
              accentColor: config.Colors().accentColor(1),
              focusColor: config.Colors().accentColor(1),
              hintColor: config.Colors().primaryColorGray(1),
              secondaryHeaderColor: config.Colors().primaryColorGray(1),
              inputDecorationTheme: InputDecorationTheme(border: OutlineInputBorder()),
              textTheme: TextTheme(
                headline: TextStyle(fontSize: 20.0, color: config.Colors().secondColor(1)),
                display1: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: config.Colors().secondColor(1)),
                display2: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600, color: config.Colors().secondColor(1)),
                display3: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700, color: config.Colors().accentColor(1)),
                display4: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w300, color: config.Colors().secondColor(1)),
                subhead: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500, color: config.Colors().secondColor(1)),
                title: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: config.Colors().accentColor(1)),
                body1: TextStyle(fontSize: 12.0, color: config.Colors().secondColor(1)),
                body2: TextStyle(fontSize: 14.0, color: config.Colors().secondColor(1)),
                caption: TextStyle(fontSize: 12.0, color: config.Colors().accentColor(1)),
              ),
            );
          } else {
            return ThemeData(
              fontFamily: 'Poppins',
              primaryColor: Color(0xFF252525),
              brightness: Brightness.dark,
              scaffoldBackgroundColor: Color(0xFF2C2C2C),
              accentColor: config.Colors().mainDarkColor(1),
              hintColor: config.Colors().secondDarkColor(1),
              focusColor: config.Colors().accentDarkColor(1),
              textTheme: TextTheme(
                headline: TextStyle(fontSize: 20.0, color: config.Colors().secondDarkColor(1)),
                display1:
                TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: config.Colors().secondDarkColor(1)),
                display2:
                TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600, color: config.Colors().secondDarkColor(1)),
                display3:
                TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700, color: config.Colors().mainDarkColor(1)),
                display4:
                TextStyle(fontSize: 22.0, fontWeight: FontWeight.w300, color: config.Colors().secondDarkColor(1)),
                subhead:
                TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500, color: config.Colors().secondDarkColor(1)),
                title: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: config.Colors().mainDarkColor(1)),
                body1: TextStyle(fontSize: 12.0, color: config.Colors().secondDarkColor(1)),
                body2: TextStyle(fontSize: 14.0, color: config.Colors().secondDarkColor(1)),
                caption: TextStyle(fontSize: 12.0, color: config.Colors().secondDarkColor(0.6)),
              ),
            );
          }
        },
        themedWidgetBuilder: (context, theme) {
          return ValueListenableBuilder(
              valueListenable: settingRepo.locale,
              builder: (context, Locale value, _) {
                print(value);
                return MaterialApp(
                  title: 'Basic Starter',
                  initialRoute: '/',
                  navigatorKey: navigatorKey,
                  onGenerateRoute: RouteGenerator.generateRoute,
                  debugShowCheckedModeBanner: false,
                  locale: value,
                  localizationsDelegates: [
                    S.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    CountryLocalizations.delegate,
                  ],
                  supportedLocales: S.delegate.supportedLocales,
                  navigatorObservers: [
                    FirebaseAnalyticsObserver(analytics: analytics),
                  ],
                  theme: theme,
                );
              });
        });
  }
}
