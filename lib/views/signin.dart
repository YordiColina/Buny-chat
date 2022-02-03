import 'package:buny_chat/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class signin extends StatefulWidget {
  const signin({Key? key}) : super(key: key);

  @override
  _signinState createState() => _signinState();
}

class _signinState extends State<signin> {
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
              TextField(
                style: simpleTextStyle(),
                decoration: textFieldInputDecoration("email")
              ),
              TextField(
                style: simpleTextStyle(),
                decoration: textFieldInputDecoration("password")
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
              Container(
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
                    Text("Register now",style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      decoration: TextDecoration.underline
                    )
                    ,)
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
