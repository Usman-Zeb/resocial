import 'package:flutter/material.dart';
import 'package:ReSocial/helper/constants.dart';
import 'package:ReSocial/services/database.dart';
import 'package:ReSocial/widgets/widget.dart';



class ConversationScreen extends StatefulWidget {
  final String chatRoomId;
  ConversationScreen(this.chatRoomId);
  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  DatabaseMethods databaseMethods = DatabaseMethods();
  TextEditingController messageController = TextEditingController();
  Stream chatMessagesStream;

  Widget chatMessageList() {

    return StreamBuilder(
      stream: chatMessagesStream,
      builder: (context, snapshot){
        if(snapshot.data !=null){
          return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index){
              return MessageTile(message: snapshot.data.documents[index].data()["message"],
                  isSentByMe: snapshot.data.documents[index].data()["sentBy"] == Constants.myName);
            },
          );
        }
        else{
          return CircularProgressIndicator();
        }
      },
    );
  }

  sendMessage(){
    if(messageController.text.isNotEmpty){
      Map<String,dynamic> messageMap = {
        "message" : messageController.text,
        "sentBy" : Constants.myName,
        "timestamp" : DateTime.now().millisecondsSinceEpoch,
      };
      databaseMethods.addConversationMessages(widget.chatRoomId, messageMap);
      messageController.text ="";
    }
  }
  @override

  void initState(){
    databaseMethods.getConversationMessages(widget.chatRoomId).then((value){
      setState(() {
        chatMessagesStream = value;
      });

    });
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      //appBar: appBarMain(context),
      body: Container(
        
        child: Stack(
          children: [
            Container(
                //height: MediaQuery.of(context).size.height,
                child: chatMessageList()),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                  color: Colors.grey[700],
                  padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                  child: Row(
                    children: [
                      Expanded(child:
                      TextField(
                        controller: messageController,
                        decoration: InputDecoration(
                          hintText: "message",
                          hintStyle: TextStyle(
                            color: Colors.white54,
                          ),
                          border: InputBorder.none,
                        ),
                      )),
                      GestureDetector(
                        onTap: () {
                          sendMessage();
                          print("THIS SHOULD WORK");
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
                            child: Icon(Icons.arrow_right, color: Colors.white54,)
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


class MessageTile extends StatelessWidget {
  final String message;
  final bool isSentByMe;

  MessageTile({this.message, this.isSentByMe});
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: isSentByMe? 0 : 24, right: isSentByMe ? 24 : 0),
      margin: EdgeInsets.symmetric(vertical: 8.0),
      width: MediaQuery.of(context).size.width,
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isSentByMe ? [
              Colors.greenAccent,
              Colors.green,
            ] : [
            Color(0xff5A4F7C),
            Colors.indigo,
            ]
          ),
          borderRadius: isSentByMe ?
              BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
                bottomLeft: Radius.circular(20.0),
              ) :
              BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
               bottomRight: Radius.circular(20.0),
              )
        ),
        child: Text(message, style: TextStyle(
          color: Colors.white,
          fontSize: 17.0,
        )),
      ),
    );
  }
}
