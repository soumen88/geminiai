import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geminiai/display_maps_view.dart';
import 'package:geminiai/views/app_intro_screen.dart';
import 'package:introduction_screen/introduction_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AppIntroScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
                'assets/images/logo.webp',
                height: 250,
                width: 250,
            ), // Replace with your logo path
            SizedBox(height: 20.0),
            Container(
              child: Column(
                children: <Widget>[
                  Text(
                    "Programming Hub",
                    style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Learning Made Easy",
                    style: TextStyle(fontSize: 16.0, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

