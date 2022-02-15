

import 'package:buny_chat/services/auth.dart';
import 'package:buny_chat/views/signin.dart';
import 'package:flutter/material.dart';

class chatRoom extends StatefulWidget {
 // const chatRoom({Key? key}) : super(key: key);

  @override
  _chatRoomState createState() => _chatRoomState();
}

class _chatRoomState extends State<chatRoom> {
  AuthMethods authMethods= new AuthMethods();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Image.asset("assets/images/BUNY-CHAT.png", height: 50,),
            backgroundColor: Color.fromARGB(255, 56, 182, 255),
            actions: [
              GestureDetector(
                onTap: (){
                   authMethods.signOut();
                   //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>signin())
                  // );
                    },
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Icon(Icons.exit_to_app)),
              )
            ],
        ),
    );
  }
}
