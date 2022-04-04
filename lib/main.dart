import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:njawani/constant.dart';
import 'package:njawani/home.dart';
import 'package:njawani/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.indigo,
          textTheme: const TextTheme(
              headline1: TextStyle(
                  fontSize: 36.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              headline4: TextStyle(
                  fontSize: 32.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              headline2: TextStyle(
                  fontSize: 36.0, color: dark, fontWeight: FontWeight.bold),
              headline3: TextStyle(
                  fontSize: 17.0, color: prgreen, fontWeight: FontWeight.bold),
              bodyText2: TextStyle(fontSize: 13.0, color: Colors.white)),
          fontFamily: 'Poppins'),
      home: Splash(),
    );
  }
}
