import 'package:buny_chat/helper/helperfunctions.dart';
import 'package:buny_chat/services/auth.dart';
import 'package:buny_chat/views/chatRoomScreen.dart';
import 'package:buny_chat/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../services/database.dart';

class signin extends StatefulWidget {

  final Function toggle;
 // const signin({Key? key, required this.toggle}) : super(key: key);
    signin(this.toggle);
  @override
  _signinState createState() => _signinState();
}

class _signinState extends State<signin> {
  final formkey=GlobalKey<FormState>();
  AuthMethods authMethods= new AuthMethods();
  DatabaseMethods databaseMethods= new DatabaseMethods();
  TextEditingController emailController =new TextEditingController();
  TextEditingController passwordController =new TextEditingController();

  bool isloading=false;
  QuerySnapshot? snapshotUserInfo;
  signIn(){
    if (formkey.currentState!.validate()){
      //HelperFunctions.saveUserNameloggedlocalInfo(usernameController.text);
      HelperFunctions.saveUserEmailloggedlocalInfo(emailController.text);
      databaseMethods.getUserByUserEmail(emailController.text).then((val){
        snapshotUserInfo=val;
        HelperFunctions.saveUserNameloggedlocalInfo(snapshotUserInfo?.docs[0].get("name"));
        print("${snapshotUserInfo?.docs[0].get("name").toString()}");
      });
      setState(() {
        isloading=true;
      });

      
      authMethods.sigInWhitEmailAndPassword(emailController.text, passwordController.text).then((val){
        if (val!=null){

          HelperFunctions.saveUserloggedlocalInfo(true);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> chatRoom()
          ));
        }

      });
      

    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:PreferredSize(  preferredSize: const Size.fromHeight(50),child: appBarMain(context)

      ),
    body: SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height - 50,
        alignment: Alignment.bottomCenter,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Form(
                key: formkey,
                child: Column(
                  children:[
                TextFormField(
                    validator: (val){
                      return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val!) ?
                      null : "Enter correct email";
                    },
                  controller:  emailController,
                  style: simpleTextStyle(),
                  decoration: textFieldInputDecoration("email")
                ),
                TextFormField(
                    obscureText: true,
                    validator:  (val){
                      return val!.length < 6 ? "Enter Password 6+ characters" : null;
                    },
                  controller: passwordController,
                  style: simpleTextStyle(),
                  decoration: textFieldInputDecoration("password")
                ),
             ] ),
              ),
              SizedBox(height: 8,),
              Container(
                alignment: Alignment.centerRight,
              child:Container(
                padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                child: Text("Forgot Password?",style: simpleTextStyle(),),
              ),
              ),
              SizedBox(height: 8,),
              GestureDetector(
                onTap: (){
                  signIn();
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors:[
                      const Color.fromARGB(255, 56, 182, 255),
                      const Color.fromARGB(255, 56, 182, 255)

                    ]

                    ),
                    borderRadius:BorderRadius.circular(30)
                  ),
                  child: Text("Sign In",style: MediumTextStyle()
                  ),
                ),
              ),
              SizedBox(height: 16,),
              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                   color: Colors.white,
                    borderRadius:BorderRadius.circular(30)
                ),
                child: Text("Sign In with Google",style: TextStyle(
                  color: Colors.black87,
                  fontSize:17,
                ),
                ),
              ),
              SizedBox(height: 16,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    Text("Don't have account? ",style: MediumTextStyle(),),
                    GestureDetector(
                      onTap: (){
                        widget.toggle();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical:17),
                        child: Text("Register now",style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          decoration: TextDecoration.underline
                        )
                        ,),
                      ),
                    )
                    ]
                  ),
              SizedBox(height: 50,),
            ],
          ),
        ),

      ),
    ),


    );
  }
}
