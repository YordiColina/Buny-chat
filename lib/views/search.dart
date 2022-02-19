

import 'package:buny_chat/helper/constants.dart';
import 'package:buny_chat/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import'package:flutter/material.dart';
import '../helper/helperfunctions.dart';
import '../services/database.dart';
import 'conversationScreen.dart';

    class SearchScreen extends StatefulWidget {
      const SearchScreen({Key? key}) : super(key: key);

      @override
      _SearchScreenState createState() => _SearchScreenState();
    }
 String _myName="";
    class _SearchScreenState extends State<SearchScreen> {

      DatabaseMethods databaseMethods=new DatabaseMethods();
      TextEditingController searchController= new TextEditingController();

       QuerySnapshot? resultSearch;
      initiateSearch(){

        databaseMethods.getUserByUsername(
            searchController.text).then((val){
              print(val.toString());
            setState(() {
              resultSearch=val;
            });


            });
            }


//////////////////////////////////////////////////////////////////
      Widget searchList( ) {


          return resultSearch != null ? ListView.builder(
              itemCount: resultSearch?.docs.length,
              shrinkWrap: true,

              itemBuilder: (context, index) {
                return SearchTile(
                  username: resultSearch?.docs[index].get("name"),
                  userEmail: resultSearch?.docs[index].get("email"),
                );
              }) : Container();

      }

      /// creacion de sala de chat

      roomToStartConversation( {required String username}){
       if (username !=Constants.myName){
         String chatRoomId= getChatRoomId(username, Constants.myName);
         List<String> users=[username,Constants.myName];
         Map<String,dynamic> chatRoomMap={
           "users": users,
           "chatRoomId": chatRoomId
         };
         DatabaseMethods().createChatRoom(chatRoomId, chatRoomMap);
         Navigator.push(context, MaterialPageRoute(
             builder: (context)=> ConversationScreen()
         ));
       }else
         {
           print("you cannot send message to yourself");
         }

      }

      Widget SearchTile({ required String username,
      required String userEmail}){
        return Container(
            padding: EdgeInsets.symmetric(vertical: 16,horizontal: 24),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment:CrossAxisAlignment.start ,
                  children: [
                    Text(username,style: MediumTextStyle(),),
                    Text(userEmail,style: MediumTextStyle(),),
                  ],
                ),
                Spacer(),
                GestureDetector(
                  onTap: (){
                      roomToStartConversation(username: username);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(25)
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                    child: Text("Message",style: MediumTextStyle(),),

                  ),
                ),

              ],
            )

        );

    }
      
      @override
  void initState() {
getUserInfo();
    super.initState();
  }

  getUserInfo()async{
        _myName=(await HelperFunctions.getUserNameloggedlocalInfo())! ;
        setState(() {

        });
  }



      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: PreferredSize(  preferredSize: const Size.fromHeight(50),child: appBarMain(context),
          ),
          body: Container(
            child: Column(
              children: [
                Container(
                  color: Color(0x54FFFFFF),
                  padding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
                  child: Row(
                    children: [
                      Expanded(

                      child:TextField(
                        controller: searchController,
                        style: TextStyle(
                      color: Colors.white
                  ),
                        decoration: InputDecoration(
                          hintText: "search username",
                          hintStyle: TextStyle(
                            color: Colors.white54
                          ),
                          border: InputBorder.none
                        ),
                      ),
                      ),
                      GestureDetector(
                        onTap: () {

                          initiateSearch();
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
                            child: Image.asset("assets/images/search_white.png")
                        ),
                      )

                    ],
                  ),
                ),
                searchList(),
              ],
            ),
          ),
        );
      }
    }








    getChatRoomId(String a, String b){
      if(a.substring(0,1).codeUnitAt(0)>b.substring(0,1).codeUnitAt(0)){
        return "$b\_$a";
      }else{
        return "$a\_$b";
      }

    }
