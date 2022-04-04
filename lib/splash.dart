import 'dart:async';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:njawani/constant.dart';
import 'package:njawani/home.dart';
import 'package:njawani/onboard.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();

    User? firebaseUser = FirebaseAuth.instance.currentUser;

    Widget firstWidget;

    if (firebaseUser != null) {
      firstWidget = Home();
    } else {
      firstWidget = Onboard();
    }

    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => firstWidget)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
                colors: [prblue, prgreen])),
        child: const Center(
          child: Image(
            image: AssetImage("assets/img/logo.png"),
            width: 120.0,
          ),
        ),
      ),
    );
  }
}
