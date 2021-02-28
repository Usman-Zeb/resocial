import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class LocationRange extends StatefulWidget {
  @override
  _LocationRangeState createState() => _LocationRangeState();
}

class _LocationRangeState extends State<LocationRange> {
double _discreteValue=10;
RangeValues values = RangeValues(1, 100);       
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("Adjust Location Range",style: GoogleFonts.openSans(color: Colors.white,fontSize: 20),),
          Container(
            child: Slider(
                      activeColor: Colors.greenAccent,
                      inactiveColor: Colors.white24,
                      value: _discreteValue,
                      min: 10,
                      max: 200,
                      divisions: 20,
                      label: '${_discreteValue.round()}KM',
                      onChanged: (double value) {
                        setState(() {
                          _discreteValue = value;
                        });
                      },
                    ),
                ),
                Container(
                  height: 50,
                  width: 250,
                  child: RaisedButton(
                      onPressed: () {
                        
                      },
                      color: Color(0xff5A4F7C),
                      child: Text(
                        "Apply",
                        style: GoogleFonts.openSans(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(color: Color(0xff5A4F7C))
                      ),
                    ),
                ),
        ],
      )
      );
  }
}