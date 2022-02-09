import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:one_chat_app/chatapp/chatone.dart';
import 'package:one_chat_app/chatapp/imageupload.dart';
import 'package:one_chat_app/chatapp/login.dart';

class Authenticate extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    if (_auth.currentUser != null) {
      return Chatone(
      );
    } else {
      return LoginScreen();
    }
  }
}