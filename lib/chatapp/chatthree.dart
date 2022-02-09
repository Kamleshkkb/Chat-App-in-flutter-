import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:one_chat_app/chatapp/helper.dart';
import 'package:one_chat_app/chatapp/verifiedemail.dart';

class chatthree extends StatefulWidget {
  
  const chatthree({ Key? key}) : super(key: key);
  @override
  _chatthreeState createState() => _chatthreeState();
}

class _chatthreeState extends State<chatthree> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
   FirebaseAuth auth=FirebaseAuth.instance;
   Helper helper=Helper();

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile Screen'),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
            //  radius: 15.0,
              child: Icon(Icons.person),
            ),
              Text('username :'+helper.currentusername()),
            SizedBox(height: 20,),
            Text('User email :'+helper.currentuseremail())
          ],
        ),
      )

    );
  }
}