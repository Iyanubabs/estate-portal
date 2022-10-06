import 'package:estate_portal/pages/occupant_signin_page.dart';
import 'package:estate_portal/screens/home_page.dart';

import 'package:estate_portal/screens/main_screen.dart';
import 'package:estate_portal/services/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 4),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => Homepage(),
            )));
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Constants.purpleDark,
        body: Center(
          child: Text(
            'WELCOME',
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ));
  }
}
