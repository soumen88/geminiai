import 'package:flutter/material.dart';
import 'package:geminiai/display_maps_view.dart';
import 'package:introduction_screen/introduction_screen.dart';

class AppIntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<AppIntroScreen> {

  final List<PageViewModel> pages = [
    PageViewModel(
      title: "Welcome to Programming Hub!",
      body: "Learn to code and turn your ideas into reality.",
      image: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(20.0), // Adjust as desired
          ),
          child: Center(
            child: Image.asset("assets/images/logo.webp"),
          ),
        ),
      ),
      decoration: PageDecoration(
        titleTextStyle: TextStyle(color: Colors.black, fontSize: 22.0),
        bodyTextStyle: TextStyle(color: Colors.grey, fontSize: 18.0),
        pageColor: Colors.white,
      ),
    ),
    PageViewModel(
      title: "Learn at your own pace",
      body: "Interactive lessons and exercises make coding fun and accessible.",
      image: Center(
        child: Image.asset("assets/images/logo.webp"), // Replace with your image
      ),
      decoration: PageDecoration(
        titleTextStyle: TextStyle(color: Colors.black, fontSize: 22.0),
        bodyTextStyle: TextStyle(color: Colors.grey, fontSize: 18.0),
        pageColor: Colors.white,
      ),
    ),
    PageViewModel(
      title: "Join the coding community",
      body: "Connect with other learners and get help from experts.",
      image: Center(
        child: Image.asset("assets/images/logo.webp"), // Replace with your image
      ),
      decoration: PageDecoration(
        titleTextStyle: TextStyle(color: Colors.black, fontSize: 22.0),
        bodyTextStyle: TextStyle(color: Colors.grey, fontSize: 18.0),
        pageColor: Colors.white,
      ),
    ),
  ];


  @override
  Widget build(BuildContext context) => IntroductionScreen(
    pages: pages,
    onDone: () {
      // Navigate to your home screen
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DisplayMapsView()));
    },
    onSkip: () {
      // Navigate to your home screen on skip
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DisplayMapsView()));
    },
    showSkipButton: true,
    skip: Text("Skip"),
    next: Text("Next"),
    done: Text("Done"),
  );


}
