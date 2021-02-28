import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ReSocial/helper/helperfunctions.dart';
import 'package:ReSocial/services/auth.dart';
import 'package:ReSocial/services/database.dart';
import 'package:ReSocial/widgets/widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'chatrooms.dart';


class SignIn extends StatefulWidget {
  final Function toggle;
  SignIn({this.toggle});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final formKey = GlobalKey<FormState>();
  AuthMethods authMethods = AuthMethods();
  DatabaseMethods databaseMethods = DatabaseMethods();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  bool isLoading = false;
  QuerySnapshot snapshotUserInfo;
  signIn() async{

    if(formKey.currentState.validate()){
      HelperFunctions.saveUserEmailSharedPreference(emailTextEditingController.text);
      //HelperFunctions.saveUserNameSharedPreference(userNameTextEditingController.text);
      setState(() {
        isLoading=true;
      });
      //Get User details
      await databaseMethods.getUserByEmail(emailTextEditingController.text)
      .then((val){
        snapshotUserInfo = val;
        HelperFunctions.saveUserIDSharedPreference(snapshotUserInfo.docs[0].id); 
        HelperFunctions.saveUserNameSharedPreference(snapshotUserInfo.docs[0].data()["name"]);
      });

      authMethods.signInWithEmailAndPassword(emailTextEditingController.text, passwordTextEditingController.text)
      .then((val){
        if(val != null){

          HelperFunctions.saveUserLoggedInSharedPreference(true);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ChatRoom()));
        }
      });

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: isLoading? Container(
        child: Center(child: WaitScreen()),
      ):SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 50.0,
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Form(
                key: formKey,
                child: Column(
                  children: [Image.asset("assets/images/applogo.jpg",height: 230,),
                    TextFormField(
                      controller: emailTextEditingController,
                      style: simpleTextStyle(),
                      decoration: textInputDecoration("email"),
                      validator: (val){
                        return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val)? null : "Enter a proper email";
                        }
                        ),
                        SizedBox(height: 16,),
                    TextFormField(
                      obscureText: true,
                      validator: (val){
                        return val.length > 5 ? null : "Enter a proper password of length 5 or more";
                        },
                      controller: passwordTextEditingController,
                      style: simpleTextStyle(),
                      decoration: textInputDecoration("password"),
                    ),
                  ],
                ),
              ),
              SizedBox(height:8.0,),
              Container(
                alignment: Alignment.centerRight,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0,),
                  child: Text("Forgot password?", style: simpleTextStyle()),
                ),
              ),
              SizedBox(height:8.0,),
              GestureDetector(
                onTap: (){
                  signIn();
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xff5A4F7C),
                        Colors.indigo,
                        
                      ],
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text("Sign In", style: GoogleFonts.openSans(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),)
                ),
              ),
              SizedBox(height:16.0),
              Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Colors.greenAccent,
                        Colors.green,
                    ]),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text("Sign In with Google", style: GoogleFonts.openSans(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),)
              ),
              SizedBox(height:16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Don't have an account? ", style: mediumTextStyle()),
                  GestureDetector(
                    onTap: (){
                      widget.toggle();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text("Register now", style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        decoration: TextDecoration.underline,
                      ),),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50.0),
            ],
          ),
        ),
      ),

    );
  }
}
