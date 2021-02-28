import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ReSocial/views/questionpage.dart';
import 'package:ReSocial/views/onBoardingScreen.dart';


class LoadScreen extends StatefulWidget {
  @override
  _LoadScreenState createState() => _LoadScreenState();
}

class _LoadScreenState extends State<LoadScreen> {
  startTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool firstTime = prefs.getBool('first_time');
    var _duration = new Duration(seconds: 1);
    navigationPageWelcome();
  }
  final spinkit = SpinKitSquareCircle(
    color: Colors.white,
    size: 50.0,
  );
  void navigationPageHome() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => QuestionPage(),settings: RouteSettings(name: '/home')));
  }

  void navigationPageWelcome() {

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => OnboardingScreen(),settings: RouteSettings(name: '/home')));
  }
  @override
  void initState() {
    super.initState();
    // here is the logic
    Future.delayed(Duration(seconds: 2)).then((__) {
      startTime();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body:Container(
            child:Column(
                mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  //Text("",style: TextStyle(color: Colors.white),),
                  Image.asset("assets/images/applogo.jpg"),
                  spinkit,
                ]
            )
        )
    );
  }
}