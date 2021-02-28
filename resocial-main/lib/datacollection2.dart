import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class WrittenAnswer extends StatefulWidget {
  String question = "";
  final Function callback;
  final int answerindex;
  WrittenAnswer({this.question,this.callback,this.answerindex});
  @override
  _WrittenAnswerState createState() => _WrittenAnswerState();
}

class _WrittenAnswerState extends State<WrittenAnswer> {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Age",
              style: GoogleFonts.openSans(color: Colors.white,fontSize: 20),
              textAlign: TextAlign.center,
          ),
          SizedBox(height: 25,),
          Container(
            alignment: Alignment.center,
            child: TextField(
                        textAlign: TextAlign.center,
                        autofocus: true,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintText: "Enter here",
                            hintStyle: GoogleFonts.openSans(color: Colors.white24),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.greenAccent,
                                    width: 2,
                                    style: BorderStyle.solid
                                ),
                                borderRadius: BorderRadius.circular(20)
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 2,
                                    style: BorderStyle.solid
                                ),
                                borderRadius: BorderRadius.circular(20)
                            )
                        ),
                        controller: controller,
                        onChanged: (String str){
                          setState((){
                            widget.callback(widget.answerindex,int.parse(str));
                            print(str);
                          });
                        },
                      ),
          ),
                    SizedBox(height: 25,),
      Divider(
        height: 20,
        color: Colors.white,
      )
        ],
      ),
    );
  }
}