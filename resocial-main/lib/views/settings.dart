import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart'; // For Image Picker
import 'package:path/path.dart';
import 'package:ReSocial/helper/constants.dart';
import 'package:ReSocial/services/database.dart';
import 'package:ReSocial/widgets/widget.dart';
import 'dart:io';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController bioEditingController = TextEditingController();
  TextEditingController currentPasswordEditingController = TextEditingController();
  TextEditingController resetPasswordEditingController = TextEditingController();
  DatabaseMethods databaseMethods = DatabaseMethods();
  static String imgUrl;
  File _image;

  Future getImage() async{
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
      print("The url is: $_image");
    });
  }

  Future uploadImage(BuildContext context) async{
    String fileName = basename(_image.path);
    Reference firebaseStorageRef = FirebaseStorage.instance.ref("profile_images").child(fileName);



    await firebaseStorageRef.putFile(_image);
    String url = await firebaseStorageRef.getDownloadURL();
    //Future url = firebaseStorageRef.getDownloadURL();

    print("THIS IS URL $url");
    imgUrl=url;
    await databaseMethods.uploadUserDP(imgUrl);
    setState(() {

      print("Profile Pic uploaded!");

      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Profile Pic Uploaded")));
    });

  }


  getUpdatedDetails()async{
    QuerySnapshot userDetails;
    await databaseMethods.getUserByUsername(Constants.myName)
        .then((val){
        userDetails = val;
    });
    setState(() {
      imgUrl = userDetails.docs[0].data()["url"].toString();
      bioEditingController.text= userDetails.docs[0].data()["bio"].toString();
      print("THIS IS INIT IMGURL: $imgUrl");
    });
}

  updateBio()async{

      await databaseMethods.uploadUserBio(bioEditingController.text);

  }

@override
  void initState() {
    getUpdatedDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      key: _scaffoldKey,
      body: Container(
        height: MediaQuery.of(context).size.height -80,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 0),
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(50, 0, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    child: ClipOval(
                      child: SizedBox(
                        child: imgUrl == null ? Image.network("https://wallpaperaccess.com/full/2213426.jpg",
                          fit: BoxFit.fill,):
                        Image.network(imgUrl,  fit: BoxFit.fill),
                        height: 100,
                        width: 100,
                      ),
                    ),
                  ),

                  IconButton(
                      alignment: Alignment.centerRight,
                      icon: Icon(Icons.camera_alt_outlined, color: Colors.white,),
                      onPressed: (){
                        getImage();
                      },
                      iconSize: 30,
                      color: Colors.white,
                  ),
                  IconButton(
                    alignment: Alignment.centerRight,
                    icon: Icon(Icons.upload_outlined, color: Colors.white,),
                    onPressed: (){
                      uploadImage(context);

                    },
                    iconSize: 30,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            SizedBox(height: 0),
            Text(Constants.myName, style: simpleTextStyle(),),
            Container(
              child: Column(
                children: [
                  TextField(
                    controller: bioEditingController,
                    style: simpleTextStyle(),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: (bioEditingController.text!=null)?
                    textInputDecoration(bioEditingController.text):
                    textInputDecoration("Enter your bio"),

                  ),

                  SizedBox(height:8),
                  RaisedButton(
                    onPressed: (){
                      print(Constants.myName);
                      print(Constants.myID);
                      updateBio();

                    },
                    color: Colors.indigo,
                    child: Text("Update Bio", style: simpleTextStyle(),),
                  ),

                ],
              ),
            ),
            ExpansionTile(
              title: Text("Password Reset", style: simpleTextStyle(),),
                trailing: Icon(Icons.arrow_drop_down, color: Colors.grey,),
              children: [
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: currentPasswordEditingController,
                        obscureText: true,
                        style: simpleTextStyle(),
                        decoration: textInputDecoration("Enter current password"),
                        validator: (val){
                          return val.length > 5 ? null : "Enter a proper password of length 5 or more";
                        },
                      ),
                      TextFormField(
                        controller: resetPasswordEditingController,
                        obscureText: true,
                        style: simpleTextStyle(),
                        decoration: textInputDecoration("Enter new password"),
                        validator: (val){
                          return val.length > 5 ? null : "Enter a proper password of length 5 or more";
                        },
                      ),
                      SizedBox(height:8),
                      RaisedButton(
                        onPressed: (){},
                        color: Colors.indigo,
                        child: Text("Reset Password", style: simpleTextStyle(),),
                      ),
                    ],
                  ),
                ),
              ]
            ),
          ],
        ),
      ),
    );
  }
}
