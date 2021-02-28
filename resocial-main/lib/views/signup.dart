import 'package:flutter/material.dart';
import 'package:ReSocial/helper/helperfunctions.dart';
import 'package:ReSocial/services/auth.dart';
import 'package:ReSocial/views/chatrooms.dart';
import 'package:ReSocial/views/questionpage.dart';
import 'package:ReSocial/widgets/widget.dart';
import 'package:ReSocial/services/database.dart';

class SignUp extends StatefulWidget {
  final Function toggle;
  SignUp({this.toggle});
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController userNameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  bool isLoading=false;
  AuthMethods authMethods = AuthMethods();
  final formKey = GlobalKey<FormState>();
  DatabaseMethods databaseMethods = DatabaseMethods();
  //HelperFunctions helperFunctions = HelperFunctions();

  signMeUp()async{
    if(formKey.currentState.validate())
      {
        setState(() {
          isLoading=true;
        });
         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => QuestionPage(username: userNameTextEditingController.text,email: emailTextEditingController.text,password: passwordTextEditingController.text,)));
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: isLoading? Container(
        child: Center(child: CircularProgressIndicator()),
      ):SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 50.0,
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
             Form(
               key: formKey,
               child: Column(
                 children: <Widget>[
                   Image.asset("assets/images/applogo.jpg",height: 230,),
                   TextFormField(
                     controller: userNameTextEditingController,
                     validator: (val){
                       return val.isEmpty || val.length< 2 ? "Please provide proper username": null;
                     },
                     style: simpleTextStyle(),
                     decoration: textInputDecoration("username"),
                   ),
                   SizedBox(height: 16,),
                   TextFormField(
                     controller: emailTextEditingController,
                     validator: (val){
                       return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val)? null : "Enter a proper email";
                     },
                     style: simpleTextStyle(),
                     decoration: textInputDecoration("email"),
                   ),
                   SizedBox(height: 16,),
                   TextFormField(
                     obscureText: true,
                     validator: (val){
                       return val.isEmpty || val.length<5 ? "Enter a proper password of length 5 or more" : null;
                     },
                     controller: passwordTextEditingController,
                     style: simpleTextStyle(),
                     decoration: textInputDecoration("password"),
                   ),
                   SizedBox(height: 16,)
                 ],
               ),
             ),

              SizedBox(height:8.0,),
              GestureDetector(
                onTap: (){
                  signMeUp();
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
                    child: Text("Register", style: simpleTextStyle(),)
                ),
              ),
              SizedBox(height:16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Already have an account? ", style: mediumTextStyle()),
                  GestureDetector(
                    onTap: (){
                      widget.toggle();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical:8.0),
                      child: Text("Sign In now", style: TextStyle(
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
