
import 'package:ReSocial/helper/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class DatabaseMethods{
  uploadUserDP(String url) async {
    return await FirebaseFirestore.instance.collection("users").doc(
        Constants.myID)
        .update({"url": url});
  }

uploadUserBio(String bio) async{
    return await FirebaseFirestore.instance.collection("users")
        .doc(Constants.myID)
        .update({"bio": bio});
  }
  getAllUsers() async{
    String userclass = await getUserClass();
    print(userclass.toString());
    return await FirebaseFirestore.instance.collection("users").get();
   }

  getRecomended() async {
    String userclass = await getUserClass();
    print(userclass.toString());
    return await FirebaseFirestore.instance.collection("users").where("userclass", isEqualTo: userclass).get();
  }
   getUserByUsername(String username)async {
    return await FirebaseFirestore.instance.collection("users")
        .where("name", isEqualTo: username)
        .get();
  }

   getUserByEmail(String userEmail)async {
     return await FirebaseFirestore.instance.collection("users")
         .where("email", isEqualTo: userEmail)
         .get();
   }

  
   uploadUserInfo(userMap) async{
   await FirebaseFirestore.instance.collection("users")
        .add(userMap).then((val) {
      Constants.myID = val.id;
    });

  }
  createChatRoom(String chatRoomId, chatRoomMap) async{
     await FirebaseFirestore.instance.collection("chatroom")
         .doc(chatRoomId).set(chatRoomMap).catchError((e){
       print(e.toString());
     });
  }

  getConversationMessages(String chatRoomId) async{
     return await FirebaseFirestore.instance.collection("chatroom")
         .doc(chatRoomId)
         .collection("chats")
         .orderBy("timestamp", descending: false)
         .snapshots();
  }
  Future<String> getUserClass() async{

    String userclass;
    await FirebaseFirestore.instance.collection("users").where("name", isEqualTo: Constants.myName).get().then((value) => {
      userclass = value.docs[0].data()['userclass'].toString()
    });
    print(userclass);
    return userclass;
  }
   addConversationMessages(String chatRoomId, messageMap)async{
     await FirebaseFirestore.instance.collection("chatroom")
         .doc(chatRoomId)
         .collection("chats")
         .add(messageMap).catchError((e){e.toString();});
   }

   getChatRooms(String userName) async{
     return await FirebaseFirestore.instance.collection("chatroom")
         .where("users", arrayContains: userName)
         .snapshots();
   }
}