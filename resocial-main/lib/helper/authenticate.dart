import 'package:flutter/material.dart';
import 'package:ReSocial/views/signin.dart';
import 'package:ReSocial/views/signup.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void viewToggle()
  {
    setState(() {
      showSignIn= !showSignIn;
    });
  }
  @override
  Widget build(BuildContext context) {
    if (showSignIn)
      {
        return SignIn(toggle: viewToggle);
      }
    else
      {
        return SignUp(toggle: viewToggle);
      }
  }
}
