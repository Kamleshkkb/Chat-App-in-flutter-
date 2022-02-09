

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
class Service{
  FirebaseAuth auth=FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
Future  createAccount(String name,String email,String password,BuildContext context)async{
  try {
    CollectionReference ref =FirebaseFirestore.instance.collection('user');
  
await auth.createUserWithEmailAndPassword(email: email, password: password);
                  // auth.currentUser!.updateDisplayName(name);
print("regiter successful");
ref.add({
  'name':name,
  'email':email,
  
});
 auth.currentUser!.updateDisplayName(name);
  showDialog(context: context, builder: (BuildContext context){
                            return AlertDialog(
                              title: Text("Account created successfully"),
                            );
                          });
  } catch (e) {
     showDialog(context: context, builder: (BuildContext context){
                            return AlertDialog(
                              title: Text("$e"),
                            );
                          });
  }
  
 


}
Future loginAccount(String email,String password,BuildContext context)async{

  try {
    await auth.signInWithEmailAndPassword(email: email, password: password);
  } catch (e) {
     showDialog(context: context, builder: (BuildContext context){
                            return AlertDialog(
                              title: Text("$e"),
                            );
                          });
    print(e);
  }

}

logout(){
  auth.signOut();
}

Future sendMessage(String username,String subject,String message)async{
  await _firestore
  .collection('message')
  .doc(username)
  .collection('chats')
  .add({
      'sendby':auth.currentUser!.displayName,
      'sentto':username,
      'subject':subject,
      'message':message,
    });

     await _firestore
  .collection('sent')
  .doc(auth.currentUser!.displayName)
  .collection('chats')
  .add({
      'sendby':auth.currentUser!.displayName,
      'sentto':username,
      'subject':subject,
      'message':message,
    });




    print('add data successfully');
}


}