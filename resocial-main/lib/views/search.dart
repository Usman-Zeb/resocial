import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ReSocial/helper/constants.dart';
import 'package:ReSocial/helper/helperfunctions.dart';
import 'package:ReSocial/widgets/widget.dart';
import 'package:ReSocial/services/database.dart';
import 'package:ReSocial/views/conversation.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchTextEditingController = TextEditingController();
  DatabaseMethods databaseMethods = DatabaseMethods();



QuerySnapshot searchSnapshot;
fullList(){
    databaseMethods.getAllUsers().then((val){
      print(val.toString());
      setState(() {
        searchSnapshot = val;
      });
    });
  }
  RecomendedList(){
    databaseMethods.getRecomended().then((val){
      print(val.toString());
      setState(() {
        searchSnapshot = val;
      });
    });
  }
  initiateSearch(){
    databaseMethods.getUserByUsername(searchTextEditingController.text).then((val) {
      print(val.toString());
      setState(() {
        searchSnapshot = val;
      });
    });
  }


//Search for a User

  Widget searchList(){

    return searchSnapshot != null ? ListView.builder(
      itemCount: searchSnapshot.docs.length,
      shrinkWrap: true,
      itemBuilder: (context,index){
        return searchTile(
            user: searchSnapshot.docs[index].data());},)
        : Container();
  }

  //Create Chat Room and send user to convo room

  createRoomAndStartConversation({String userName}){

    if(userName != Constants.myName){
      String chatRoomId = getChatRoomId(userName, Constants.myName);
      List<String> users = [userName, Constants.myName];
      Map<String, dynamic> chatRoomMap ={
        "users" : users,
        "chatroomid" : chatRoomId
      };

      DatabaseMethods().createChatRoom(chatRoomId, chatRoomMap);
      Navigator.push(context, MaterialPageRoute(builder: (context) => ConversationScreen(chatRoomId)));
    }
    else
      print("you cannot send message to yourself");
  }

  Widget searchTile({Map user}){

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      child: Column(
        children: [
          Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children:[
                        Icon(Icons.person_outline,),
                    Text(user["name"], style: simpleTextStyle()),]),
                     Row(
                      children:[
                        Icon(Icons.email_outlined,),
                    Text(user["email"], style: simpleTextStyle()),]),
                  ],
                ),
                Spacer(),
                GestureDetector(
                  onTap: (){
                    createRoomAndStartConversation(userName: user["name"]);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                    child: Icon(Icons.message_rounded),
                  ),
                ),
              ]
          ),
          Divider(height: 7, color: Colors.greenAccent,thickness: 1.2,)
        ],
      ),
    );
  }

  @override
  void initState(){
    getUserInfo();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        height: MediaQuery.of(context).size.height - 50.0,
        child: Column(
          children: [
            Container(
              color: Colors.grey[700],
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Row(
                children: [
                  
                  Expanded(child:
                  TextField(
                    controller: searchTextEditingController,
                    style: simpleTextStyle(),
                    decoration: InputDecoration(
                      hintText: "search",
                      hintStyle: TextStyle(
                        color: Colors.white54,
                      ),
                      border: InputBorder.none,
                    ),
                  )),
                  GestureDetector(
                    onTap: () async{
                      initiateSearch();
                      },
                    child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              const Color(0x36FFFFFF),
                              const Color(0x0FFFFFFF),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        padding: EdgeInsets.all(8),
                        child: Icon(Icons.search, color: Colors.white54,)
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                      onTap: (){
                        RecomendedList();
                      },
                      child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width/2.3,
                          padding: EdgeInsets.symmetric(vertical: 20.0),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                               Color(0xff5A4F7C),
                        Colors.indigo,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text("Recomended", style: simpleTextStyle(),)
                      )),
                  GestureDetector(
                      onTap: (){
                        fullList();
                      },
                      child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width/2.3,
                          padding: EdgeInsets.symmetric(vertical: 20.0),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.greenAccent,
                              Colors.green,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text("Show All", style: simpleTextStyle(),)
                      )),
                ],
              ),
            ),
            Expanded(child: searchList()),
              
          ],
        ),
      ),
    );
  }
}

getUserInfo() async{
  dynamic _myName = await HelperFunctions.getUserNameSharedPreference();
  setState(){
  }
  print("this is my name: ${_myName}");
}


getChatRoomId(String a, String b){
  if (a.substring(0,1).codeUnitAt(0) > b.substring(0,1).codeUnitAt(0)){
    return "$b\_$a";
  }
  else{
    return "$a\_$b";
  }
}