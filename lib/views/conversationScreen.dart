import 'package:buny_chat/helper/constants.dart';
import 'package:buny_chat/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../services/database.dart';

class ConversationScreen extends StatefulWidget {
  final String chatroomId;
  const ConversationScreen({required this.chatroomId});



  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}
   Stream<QuerySnapshot>? chats;
    var data;
class _ConversationScreenState extends State<ConversationScreen> {
  DatabaseMethods databaseMethods= new DatabaseMethods();
  TextEditingController messageController= new TextEditingController();
  Widget ChatMessageList( ) {
    return StreamBuilder(
      stream: chats,
        builder: (context, snapshot) {
          data = snapshot.data!;
          return snapshot.hasData ? ListView.builder(

              itemCount: data!.docs.length,
              itemBuilder: (context, index) {
                  print(data.docs[index]['message'].toString());
            return MessageTile(

              message:data.docs[0]['message'].toString(),


              sendByMe:  Constants.myName == data?.docs[0]['sendby'].toString(),
            );

          }) : Container();
        },
    );

  
      }

  //Stream? chatMessageStream;
     sendMessage(){
       if(messageController.text.isNotEmpty) {
         Map<String, String> messageMap = {
           "message": messageController.text,
           "sendby": Constants.myName


         };
         databaseMethods.addConversationsMesssages(widget.chatroomId,messageMap );
       }
  }
  @override
  void initState() {
      databaseMethods.getConversationsMesssages(widget.chatroomId).then((value){
      setState(() {
        chats=value;
      });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(  preferredSize: const Size.fromHeight(50),child: appBarMain(context)
      ),
      body: Container(
        child: Stack(
          children: [
            ChatMessageList(),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Color(0x54FFFFFF),
                padding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
                child: Row(
                  children: [
                    Expanded(

                      child:TextField(
                        controller:messageController ,
                        style: TextStyle(
                            color: Colors.white
                        ),
                        decoration: InputDecoration(
                            hintText: "Message",
                            hintStyle: TextStyle(
                                color: Colors.white54
                            ),
                            border: InputBorder.none
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {

                      sendMessage();
                      },
                      child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                const Color(0x36FFFFFF),
                                const Color(0x0FFFFFFF)
                              ]

                              ),
                              borderRadius: BorderRadius.circular(40)
                          ),
                          padding: EdgeInsets.all(12),
                          child: Image.asset("assets/images/send.png")
                      ),
                    )

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
  final bool sendByMe;

  MessageTile({required this.message, required this.sendByMe});


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 8,
          bottom: 8,
          left: sendByMe ? 0 : 24,
          right: sendByMe ? 24 : 0),
      alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: sendByMe
            ? EdgeInsets.only(left: 30)
            : EdgeInsets.only(right: 30),
        padding: EdgeInsets.only(
            top: 17, bottom: 17, left: 20, right: 20),
        decoration: BoxDecoration(
            borderRadius: sendByMe ? BorderRadius.only(
                topLeft: Radius.circular(23),
                topRight: Radius.circular(23),
                bottomLeft: Radius.circular(23)
            ) :
            BorderRadius.only(
                topLeft: Radius.circular(23),
                topRight: Radius.circular(23),
                bottomRight: Radius.circular(23)),
            gradient: LinearGradient(
              colors: sendByMe ? [
                const Color(0xff007EF4),
                const Color(0xff2A75BC)
              ]
                  : [
                const Color(0x1AFFFFFF),
                const Color(0x1AFFFFFF)
              ],
            )
        ),
        child: Text(message,
            textAlign: TextAlign.start,
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'OverpassRegular',
                fontWeight: FontWeight.w300)),
      ),
    );
  }
}