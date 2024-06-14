import 'package:flutter/material.dart';

import 'display_maps_view.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DisplayMapsView(),
    );
  }

}