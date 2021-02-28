import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
Widget appBarMain(BuildContext context){
  return AppBar(
    title: Text('Resocial'),
    elevation: 0,
  );
}

InputDecoration textInputDecoration(String hint){
  return InputDecoration(
    hintText: hint,
    hintStyle: GoogleFonts.openSans(color: Colors.white70),
    focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.greenAccent,
                                    width: 2,
                                    style: BorderStyle.solid
                                ),
                            ),enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 2,
                                    style: BorderStyle.solid
                                ),
                                borderRadius: BorderRadius.circular(20)
  ));
}

TextStyle simpleTextStyle(){
  return GoogleFonts.openSans(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold);
}

TextStyle mediumTextStyle(){
  return GoogleFonts.openSans(color: Colors.white,fontSize:  18,fontWeight: FontWeight.bold);
}
final spinkit = SpinKitSquareCircle(
    color: Colors.white,
    size: 50.0,
  );
class WaitScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
        return Container(
            child:Column(
                mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  //Text("",style: TextStyle(color: Colors.white),),
                  Image.asset("assets/images/applogo.jpg"),
                  spinkit,
                ]
            )
    );
  }
}