import 'package:ReSocial/widgets/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ReSocial/datacollect1.dart';
import 'package:ReSocial/datacollection2.dart';
import 'package:ReSocial/datacollect3.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ReSocial/services/database.dart';
import 'chatrooms.dart';
import 'package:ReSocial/helper/helperfunctions.dart';
import 'package:ReSocial/services/auth.dart';
class QuestionPage extends StatefulWidget {
  final String username;
  final String email;
  final String password;
  QuestionPage({this.username,this.email,this.password});
  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  bool isLoading=false;
  AuthMethods authMethods = AuthMethods();
  DatabaseMethods databaseMethods = DatabaseMethods();
  List<int> answerslist = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
  callback(index,answer) {
    this.answerslist[index] = answer;
  }
  final int _numPages = 7;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Color(0xff5A4F7C) : Colors.grey,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
     return Scaffold(
       backgroundColor: Colors.black,
      body: isLoading? Container(
        child: Center(child: WaitScreen())): 
      SingleChildScrollView(
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 2.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 32, 0, 0),
                    child: Text("Tell us about yourself",style: GoogleFonts.openSans(color: Colors.white,fontSize: 32)),
                  ),
                  Container(
                    height: 590,
                    child: PageView(
                      physics: ClampingScrollPhysics(),
                      controller: _pageController,
                      onPageChanged: (int page) {
                        setState(() {
                          _currentPage = page;
                        });
                      },
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(40),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              WrittenAnswer(question: "Age",callback: this.callback,answerindex: 0,),
                              QuestionAnswer(question: "Gender",possibleanswers: ["Male","Female"],callback: this.callback,answerindex: 1,),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(40.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Selector(question: "Profession",callback: this.callback,answerindex: 2,options: ["Select","Engineer","Doctor","Others"],),
                              QuestionAnswer(question: "Marital status",possibleanswers: ["Married","Single"],callback: this.callback,answerindex: 3,),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(40.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Selector(question: "Education",callback: this.callback,answerindex: 4,options: ["Select","Matric/O-levels","FSC/A-levels","Bachelors","Masters","Doctorate","Others"],),
                              QuestionAnswer(question: "Tea/Coffee",possibleanswers: ["Tea","Coffee"],callback: this.callback,answerindex: 5,),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(40.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              //Selector(question: "Education",callback: this.callback,answerindex: 4,options: ["Select","Matric/O-levels","FSC/A-levels","Bachelors","Masters","Doctorate","Others"],),
                              QuestionAnswer(question: "Biryani/Nihari",possibleanswers: ["Biryani","Nihari",],callback: this.callback,answerindex: 6,),
                              QuestionAnswer(question: "Pizza/Lassagne",possibleanswers: ["Pizza","Lassagne"],callback: this.callback,answerindex: 7,),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(40.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              //Selector(question: "Education",callback: this.callback,answerindex: 4,options: ["Select","Matric/O-levels","FSC/A-levels","Bachelors","Masters","Doctorate","Others"],),
                              QuestionAnswer(question: "Youtube/Tiktok",possibleanswers: ["Youtube","Tiktok",],callback: this.callback,answerindex: 8,),
                              QuestionAnswer(question: "Sports/Gaming",possibleanswers: ["Sports","Gaming"],callback: this.callback,answerindex: 9,),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(40.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              //Selector(question: "Education",callback: this.callback,answerindex: 4,options: ["Select","Matric/O-levels","FSC/A-levels","Bachelors","Masters","Doctorate","Others"],),

                              Selector(question: "Favorite Art",callback: this.callback,answerindex: 10,options: ["Select","Painting","Sketching","Poetry","Singing","Dancing"],),
                              QuestionAnswer(question: "Coke Studio/Velo Station",possibleanswers: ["Coke Studio","Velo Station",],callback: this.callback,answerindex: 11,),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(40.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Selector(question: "Favorite Sports",callback: this.callback,answerindex: 13,options: ["Select","Football","Cricket","Hockey","Badminton","Others"],),

                              Selector(question: "Knowledge-base interests",callback: this.callback,answerindex: 14,options: ["Select","Technology","Fashion","History","Politics","Economics"],),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _buildPageIndicator(),
                  ),
                  SizedBox(height: 10,),
                  _currentPage != _numPages - 1
                      ? Container(
                    width: 250,
                    height: 50,
                    child: RaisedButton(
                      onPressed: () {
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      },
                      color: Color(0xff5A4F7C),
                      child: Text(
                        "Next",
                        style: GoogleFonts.openSans(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(color: Color(0xff5A4F7C))
                      ),
                    ),
                  )
                      : Text(''),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomSheet: _currentPage == _numPages - 1
          ? Container(
        height: 100.0,
        width: double.infinity,
        color: Color(0xff5A4F7C),
        child: GestureDetector(
          onTap: () async {
             setState(() {
               isLoading = true;
             });
            var url = 'https://userclasspredictionapi.herokuapp.com/app';
            var response = await http.post(url,body: {'a':answerslist[0].toString(),'b':answerslist[1].toString(),'c':answerslist[2].toString(),'d':answerslist[3].toString(),'e':answerslist[4].toString(),'f':answerslist[5].toString(),'g':answerslist[6].toString(),'h':answerslist[7].toString(),'i':answerslist[8].toString(),'j':answerslist[9].toString(),'k':answerslist[10].toString(),'l':answerslist[11].toString(),'m':answerslist[12].toString(),'n':answerslist[13].toString()});
            await authMethods.signUpWithEmailAndPassword(widget.email, widget.password).then((val){
            
            Map<String, String> userMap ={
            "name" : widget.username,
            "email" : widget.email,
            "userclass": jsonDecode(response.body)['class']
            };
            HelperFunctions.saveUserEmailSharedPreference(widget.email);
            HelperFunctions.saveUserNameSharedPreference(widget.username);
            databaseMethods.uploadUserInfo(userMap);
            HelperFunctions.saveUserLoggedInSharedPreference(true);
            }
            );
            QuerySnapshot snapshotUserInfo;
            await databaseMethods.getUserByEmail(widget.email)
            .then((val){
              snapshotUserInfo = val;
              HelperFunctions.saveUserIDSharedPreference(snapshotUserInfo.docs[0].id);
        });
           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ChatRoom()));
          },
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: 30.0),
              child: Text(
                'Lets Get Started',
                style: GoogleFonts.openSans(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      )
          : Text(''),
    );
  }
}