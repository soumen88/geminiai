import 'package:flutter/material.dart';
import 'package:geminiai/views/splash_screen.dart';
import 'display_maps_view.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
    );
  }

}