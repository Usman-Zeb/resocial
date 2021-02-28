import'package:flutter/material.dart';
import'package:ReSocial/widgets/widget.dart';
import 'package:ReSocial/services/auth.dart';


class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailTextEditingController = TextEditingController();
  AuthMethods authMethods = AuthMethods();
  final formKey = GlobalKey<FormState>();

  resetPassword()async{
    await authMethods.resetPassword(emailTextEditingController.text);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        height: MediaQuery.of(context).size.height - 50.0,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Form(
              key: formKey,
              child: TextFormField(
                  controller: emailTextEditingController,
                  style: simpleTextStyle(),
                  decoration: textInputDecoration("email"),
                  validator: (val){
                    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val)? null : "Enter a proper email";
                  }
              ),
            ),
            SizedBox(height:8.0,),
            GestureDetector(
              onTap: (){
                resetPassword();
              },
              child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xff007EF4),
                        const Color(0xff2A75BC)
                      ],
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text("Send Password reset", style: simpleTextStyle(),)
              ),
            ),
            SizedBox(height:16.0),
          ]
      ),
    ),
    );

  }
}