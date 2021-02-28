import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class Selector extends StatefulWidget {
  final String question;
  final Function callback;
  final int answerindex ;
  final List<String> options;
  Selector({this.question,this.callback,this.answerindex,this.options});
  @override
  _SelectorState createState() => _SelectorState();
}

class _SelectorState extends State<Selector> {
  String dropDownValue = "Select";
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
          Text(
            widget.question,
              style: GoogleFonts.openSans(color: Colors.white,fontSize: 20),
              textAlign: TextAlign.center,
          ),
          SizedBox(height: 25,),
        Container(
          alignment: Alignment.center,
          //width: 300,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 2.0, style: BorderStyle.solid,color: Colors.greenAccent),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
          ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                value: dropDownValue,
                icon: Icon(Icons.arrow_drop_down,size: 50,color: Colors.greenAccent,),
                iconSize: 24,
                elevation: 18,
                style: GoogleFonts.openSans(color: Colors.white),
                onChanged: (String str){
                  setState(() {
                    dropDownValue=str;
                    int _ans=0;
                    for(int i = 0 ; i<widget.options.length; i++){
                      if(widget.options[i] == str){
                        _ans=i;
                      }
                    }
                    widget.callback(widget.answerindex,_ans);
                  });
                },
                items: widget.options.map<DropdownMenuItem<String>>((String val) {
                  return DropdownMenuItem<String>(
                    value: val,
                    child: Text(val),
                  );
                }).toList(),
              ),
            ),
        ),
        SizedBox(height: 25,),
      Divider(
        height: 20,
        color: Colors.white,
      )
      ],
    );
  }
}