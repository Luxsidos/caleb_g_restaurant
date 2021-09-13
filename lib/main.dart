import 'package:caleb_j_restaurant/authentication/auth.dart';
import 'package:caleb_j_restaurant/constants.dart';
import 'package:caleb_j_restaurant/screens/get_started/get_started.dart';

import 'package:caleb_j_restaurant/screens/home/myHomePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Authentication _authentication = Authentication();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CALEB J RESTAURANT',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: kBackgroundColor,
        textTheme: GoogleFonts.actorTextTheme(
          TextTheme(
            bodyText1: TextStyle(color: kTextColor),
            bodyText2: TextStyle(color: kTextColor),
          ),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: _authentication.authUser.currentUser == null
          ? GetStarted()
          : MyHomePage(),
    );
  }
}
