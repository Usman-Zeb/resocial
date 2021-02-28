import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ReSocial/helper/authenticate.dart';
import 'package:ReSocial/helper/helperfunctions.dart';
import 'package:ReSocial/views/LoadingScreen.dart';
import 'package:ReSocial/views/chatrooms.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool userLoggedIn =false;
  @override

  void initState(){
    getLoggedInState();
    super.initState();
  }
  getLoggedInState() async{
    HelperFunctions.getUserLoggedInSharedPreference().
    then((value){
      userLoggedIn = value;
    });
  }
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Resocial',

      
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),

      home: LoadScreen(),//userLoggedIn ? ChatRoom() :  Authenticate()
    );
  }
}

class IamBlank extends StatefulWidget {
  @override
  _IamBlankState createState() => _IamBlankState();
}

class _IamBlankState extends State<IamBlank> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
