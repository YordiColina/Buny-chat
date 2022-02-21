import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
class DatabaseMethods {

 Future getUserByUsername(String Username) async {
    List datos = [];
   CollectionReference users = FirebaseFirestore.instance.collection('users');
     QuerySnapshot result = await users.where("name", isEqualTo: Username).get();
   return result;

    }

 Future getUserByUserEmail(String UserEmail) async {
   List datos = [];
   CollectionReference users = FirebaseFirestore.instance.collection('users');
   QuerySnapshot result = await users.where("email", isEqualTo: UserEmail).get();
   return result;

 }


    uploadUserInfo(userMap) {
      CollectionReference usuarios = FirebaseFirestore.instance.collection(
          'users');
      usuarios.add(userMap);
    }

   createChatRoom(String chatRoomId, chatRoomMap)async{
      CollectionReference chat = FirebaseFirestore.instance.collection('ChatRoom');
      chat.doc(chatRoomId).set(chatRoomMap);
    }

     addConversationsMesssages( String RoomId,messsageMap){
       CollectionReference messagesInstance = FirebaseFirestore.instance.collection('ChatRoom');
       messagesInstance.doc("chatRoomId").collection("chats").add(messsageMap);
     }

      getConversationsMesssages( String RoomId){
       CollectionReference messagesInstance = FirebaseFirestore.instance.collection('ChatRoom');
       messagesInstance.doc("chatRoomId").collection("chats").snapshots();
       }



}
