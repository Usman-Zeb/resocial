import 'package:flutter/material.dart';
import 'package:ReSocial/helper/constants.dart';
import 'package:ReSocial/helper/helperfunctions.dart';
import 'package:ReSocial/services/auth.dart';
import 'package:ReSocial/helper/authenticate.dart';
import 'package:ReSocial/services/database.dart';
import 'package:ReSocial/views/search.dart';
import 'package:ReSocial/widgets/widget.dart';
import 'slidemenu.dart';
import 'conversation.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  AuthMethods authMethods = AuthMethods();
  DatabaseMethods databaseMethods = DatabaseMethods();

  Stream chatRoomStream;

  Widget chatRoomList(){
    return StreamBuilder(
      stream: chatRoomStream,
      builder: (context, snapshot){
        return snapshot.hasData ? ListView.builder(
          itemCount: snapshot.data.documents.length,
          itemBuilder: (context, index){
            return ChatRoomsTile(
              userName: snapshot.data.documents[index].data()["chatroomid"]
                  .toString().replaceAll("_", "").replaceAll(Constants.myName, ""),
              chatRoom: snapshot.data.documents[index].data()["chatroomid"],
            );
          },
        ) : Container();
      }
    );
  }

  @override
  void initState(){
    getUserInfo();
    super.initState();
  }

  getUserInfo()async{
    Constants.myName = await HelperFunctions.getUserNameSharedPreference();
    Constants.myID = await HelperFunctions.getUserIDSharedPreference();
    databaseMethods.getChatRooms(Constants.myName).then((val){
      setState(() {
        chatRoomStream = val;
      });
    });
  }
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
          child: Scaffold(
            drawer: NavDrawer(),
            backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Color(0xff5A4F7C),
          title: Text(""),
          bottom: TabBar(tabs: [Tab(
              child: Text("Conversations"),
          ),
                Tab(
                child: Text("Explore"),
                )],),
          actions: [
            GestureDetector(
              onTap: ()async{
                await authMethods.signOut();
                Navigator.pushReplacement(context,  MaterialPageRoute(builder: (context) => Authenticate()));
              },
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Icon(Icons.logout,)),
            )
          ],

        ),
        //body: chatRoomList(),
        body: TabBarView(children: [
           chatRoomList(),
    SearchScreen(),
        ],),
      ),
    );
  }
}

class ChatRoomsTile extends StatelessWidget {
  final String userName;
  final String chatRoom;
  ChatRoomsTile({this.userName, this.chatRoom});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => ConversationScreen(chatRoom)
        ));
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.indigo,Colors.greenAccent
              ]
            ),
            borderRadius: BorderRadius.all(Radius.circular(8)) 
          ),
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            children: [
              Container(
                height:40,
                width:40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(40.0)
                ),
                child: Text("${userName.substring(0,1).toUpperCase()}", style: mediumTextStyle(),)
              ),
              SizedBox(width: 8),
              Text(userName, style: mediumTextStyle())
            ],
          ),
        ),
      ),
    );
  }
}
