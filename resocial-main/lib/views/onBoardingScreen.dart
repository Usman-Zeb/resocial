import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ReSocial/helper/authenticate.dart';
import 'package:path_provider/path_provider.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final int _numPages = 3;
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
      resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
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
                children: <Widget>[
                  Container(
                    height: 610.0,
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
                          padding: EdgeInsets.all(40.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Center(
                                child: Image(
                                  image: AssetImage(
                                    'assets/images/applogo.jpg',
                                  ),
                                  height: 300.0,
                                  width: 300.0,
                                ),
                              ),
                              SizedBox(height: 30.0),
                              Text(
                                'Lets get social',
                                style: GoogleFonts.openSans(color: Colors.white,fontSize: 32),
                              ),
                              SizedBox(height: 15.0),
                              Text(
                                'Re-Social aims to help people making strong social bonds',
                                style: GoogleFonts.openSans(color: Colors.white,fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(40.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Center(
                                child: Image(
                                  image: AssetImage(
                                    'assets/images/ai3.png',
                                  ),
                                  height: 300.0,
                                  width: 300.0,
                                ),
                              ),
                              SizedBox(height: 30.0),
                              Text(
                                'AI makes it easy',
                                style: GoogleFonts.openSans(color: Colors.white,fontSize: 32),
                              ),
                              SizedBox(height: 15.0),
                              Text(
                                'AI helps in making your connections even better by suggesstions based on your personality',
                                style: GoogleFonts.openSans(color: Colors.white,fontSize: 16),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(40.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Center(
                                child: Image(
                                  image: AssetImage(
                                    'assets/images/around.png',
                                  ),
                                  height: 300.0,
                                  width: 300.0,
                                ),
                              ),
                              SizedBox(height: 30.0),
                              Text(
                                'Location matters',
                                style: GoogleFonts.openSans(color: Colors.white,fontSize: 32),
                              ),
                              SizedBox(height: 15.0),
                              Text(
                                'Re-Social looks for people nearby you',
                                style: GoogleFonts.openSans(color: Colors.white,fontSize: 16),
                              )
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
                  SizedBox(height: 25,),
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
                  Container(
                    alignment: Alignment.center,
                    child: FlatButton(
                      onPressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Authenticate()));
                      },
                      child: Text(
                        'Skip',
                        style: GoogleFonts.openSans(color: Colors.greenAccent,fontSize: 18,fontWeight: FontWeight.bold)
                      ),
                    ),
                  ),
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
        decoration: BoxDecoration(
          gradient: LinearGradient(
                        colors: [
                         Color(0xff5A4F7C),
                        Colors.indigo,
                        ],
                      ),
        ),
        child: GestureDetector(
          onTap: () {
              print("THis must work");
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Authenticate()));
          },
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: 30.0),
              child: Text(
                'Get started',
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