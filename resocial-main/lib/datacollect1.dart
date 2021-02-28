import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionAnswer extends StatefulWidget {
  final String question;
  final List<String> possibleanswers;
  final Function callback;
  final int answerindex;
  QuestionAnswer({this.question,this.possibleanswers,this.callback,this.answerindex});
  @override
  _QuestionAnswerState createState() => _QuestionAnswerState();
}

class _QuestionAnswerState extends State<QuestionAnswer> {
  int _ans = 0;
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(widget.question,style: GoogleFonts.openSans(color: Colors.white,fontSize: 20)),
        SizedBox(height: 25,),
        ListTile(
          title: Text(widget.possibleanswers[0],style: GoogleFonts.openSans(color: Colors.white),),
          focusColor: Colors.white,
          leading: Radio(
            value: 0,
            groupValue: _ans,
            onChanged: (int value) {
              setState(() {
                _ans = value;
                widget.callback(widget.answerindex,_ans);
                print(_ans);
              });
            },
          ),
        ),
        ListTile(
          title: Text(widget.possibleanswers[1],style: GoogleFonts.openSans(color: Colors.white),),
          focusColor: Colors.white,
          leading: Radio(
            value: 1,
            groupValue: _ans,
            onChanged: (int value) {
              setState(() {
                _ans = value;
                widget.callback(widget.answerindex,_ans);
                print(_ans);
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
    );
  }
}

class QuestionAnswer3 extends StatefulWidget {
  final String question;
  final List<String> possibleanswers;
  final Function callback;
  final int answerindex;
  QuestionAnswer3({this.question,this.possibleanswers,this.callback,this.answerindex});
  @override
  _QuestionAnswer3State createState() => _QuestionAnswer3State();
}

class _QuestionAnswer3State extends State<QuestionAnswer3> {
  int _ans = 3;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(widget.question,style: GoogleFonts.openSans(color: Colors.white,fontSize: 20)),
        SizedBox(height: 25,),
        ListTile(
          title: Text(widget.possibleanswers[0],style: GoogleFonts.openSans(color: Colors.white),),
          focusColor: Colors.white,
          leading: Radio(
            value: 0,
            groupValue: _ans,
            onChanged: (int value) {
              setState(() {
                _ans = value;
                widget.callback(widget.answerindex,_ans);
                print(_ans);
              });
            },
          ),
        ),
        ListTile(
          title: Text(widget.possibleanswers[1],style: GoogleFonts.openSans(color: Colors.white),),
          focusColor: Colors.white,
          leading: Radio(
            value: 1,
            groupValue: _ans,
            onChanged: (int value) {
              setState(() {
                _ans = value;
                widget.callback(widget.answerindex,_ans);
                print(_ans);
              });
            },
          ),
        ),
        ListTile(
          title: Text(widget.possibleanswers[2],style: GoogleFonts.openSans(color: Colors.white),),
          focusColor: Colors.white,
          leading: Radio(
            value: 2,
            groupValue: _ans,
            onChanged: (int value) {
              setState(() {
                _ans = value;
                widget.callback(widget.answerindex,_ans);
                print(_ans);
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
    );
  }
}
class QuestionAnswer4 extends StatefulWidget {
  final String question;
  final List<String> possibleanswers;
  final Function callback;
  final int answerindex;
  QuestionAnswer4({this.question,this.possibleanswers,this.callback,this.answerindex});
  @override
  _QuestionAnswer4State createState() => _QuestionAnswer4State();
}

class _QuestionAnswer4State extends State<QuestionAnswer4> {
  int _ans = 3;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(widget.question,style: GoogleFonts.openSans(color: Colors.white,fontSize: 20)),
        SizedBox(height: 25,),
        ListTile(
          title: Text(widget.possibleanswers[0],style: GoogleFonts.openSans(color: Colors.white),),
          focusColor: Colors.white,
          leading: Radio(
            value: 0,
            groupValue: _ans,
            onChanged: (int value) {
              setState(() {
                _ans = value;
                widget.callback(widget.answerindex,_ans);
                print(_ans);
              });
            },
          ),
        ),
        ListTile(
          title: Text(widget.possibleanswers[1],style: GoogleFonts.openSans(color: Colors.white),),
          focusColor: Colors.white,
          leading: Radio(
            value: 1,
            groupValue: _ans,
            onChanged: (int value) {
              setState(() {
                _ans = value;
                widget.callback(widget.answerindex,_ans);
                print(_ans);
              });
            },
          ),
        ),
        ListTile(
          title: Text(widget.possibleanswers[2],style: GoogleFonts.openSans(color: Colors.white),),
          focusColor: Colors.white,
          leading: Radio(
            value: 2,
            groupValue: _ans,
            onChanged: (int value) {
              setState(() {
                _ans = value;
                widget.callback(widget.answerindex,_ans);
                print(_ans);
              });
            },
          ),
        ),
        ListTile(
          title: Text(widget.possibleanswers[3],style: GoogleFonts.openSans(color: Colors.white),),
          focusColor: Colors.white,
          leading: Radio(
            value: 3,
            groupValue: _ans,
            onChanged: (int value) {
              setState(() {
                _ans = value;
                widget.callback(widget.answerindex,_ans);
                print(_ans);
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
    );
  }
}