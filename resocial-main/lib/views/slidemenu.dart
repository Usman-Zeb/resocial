import 'package:flutter/material.dart';
import 'package:ReSocial/helper/constants.dart';
import 'package:ReSocial/helper/helperfunctions.dart';
import 'package:ReSocial/services/auth.dart';
import 'package:ReSocial/helper/authenticate.dart';
import 'package:ReSocial/services/database.dart';
import 'package:ReSocial/views/search.dart';
import 'package:ReSocial/widgets/widget.dart';
import 'settings.dart';
class NavDrawer extends StatefulWidget {
  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
AuthMethods authMethods = AuthMethods();
double _discreteValue=10;
RangeValues values = RangeValues(1, 100);    
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
                       Color(0xff5A4F7C),
                        Colors.indigo,
                    ]
          ) 
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Container(
                child: Image(image: AssetImage('assets/images/applogotransparent.png'),),
              )
            ),
            ListTile(
              leading: Icon(Icons.verified_user),
              title: Text('Profile'),
              onTap: () => {
                Navigator.push(context,  MaterialPageRoute(builder: (context) => Settings()))
                },
            ),
            ListTile(
              leading: Icon(Icons.border_color),
              title: Text('Feedback'),
              onTap: () => {Navigator.of(context).pop()},
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout'),
               onTap: ()async{
                await authMethods.signOut();
                Navigator.pushReplacement(context,  MaterialPageRoute(builder: (context) => Authenticate()));
              }
            ),
            Divider(height: 10,),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Column(
                children: [
                    Text("Adjust Range",style: simpleTextStyle(),),
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
                ],
              ),
            ),
                ),
          ],
        ),
      ),
    );
  }
}