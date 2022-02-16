import 'dart:ui';

import 'package:buny_chat/widget.dart';
import'package:flutter/material.dart';

    class SearchScreen extends StatefulWidget {
      const SearchScreen({Key? key}) : super(key: key);

      @override
      _SearchScreenState createState() => _SearchScreenState();
    }

    class _SearchScreenState extends State<SearchScreen> {

      TextEditingController searchController= new TextEditingController();
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
                      Container(
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
                      )

                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }
    }
