
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Helper {
  String fun(var s) {
    if (s[0] == 'X' && s[1] == 'X' && s[2] == 'X') {
      print("X player win");
      return 'X';
    } else if (s[0] == 'O' && s[1] == 'O' && s[2] == 'O') {
      print("O player win");
      return 'O';
    } else if (s[6] == 'X' && s[7] == 'X' && s[8] == 'X') {
      print("X player win");
      return 'X';
    } else if (s[6] == 'O' && s[7] == 'O' && s[8] == 'O') {
      print("O player win");
      return 'O';
    } else if (s[0] == 'X' && s[3] == 'X' && s[6] == 'X') {
      print("X player win");
      return 'X';
    } else if (s[0] == 'O' && s[3] == 'O' && s[6] == 'O') {
      print("O player win");
      return 'O';
    } else if (s[2] == 'X' && s[5] == 'X' && s[8] == 'X') {
      print("X player win");
      return 'X';
    } else if (s[2] == 'O' && s[5] == 'O' && s[8] == 'O') {
      print("O player win");
      return 'O';
    } else if (s[0] == 'X' && s[4] == 'X' && s[8] == 'X') {
      print("X player win");
      return 'X';
    } else if (s[0] == 'O' && s[4] == 'O' && s[8] == 'O') {
      print("O player win");
      return 'O';
    } else if (s[2] == 'X' && s[4] == 'X' && s[6] == 'X') {
      print("X player win");
      return 'X';
    } else if (s[2] == 'O' && s[4] == 'O' && s[6] == 'O') {
      print("O player win");
      return 'O';
    }else if (s[1] == 'X' && s[4] == 'X' && s[7] == 'X') {
      print("X player win");
      return 'X';
    } else if (s[1] == 'O' && s[4] == 'O' && s[7] == 'O') {
      print("O player win");
      return 'O';
    } else if (s[3] == 'X' && s[4] == 'X' && s[5] == 'X') {
      print("X player win");
      return 'X';
    } else if (s[3] == 'O' && s[4] == 'O' && s[5] == 'O') {
      print("O player win");
      return 'O';
    } 
    return '';
  }

  mydialog() {
    AlertDialog alert = AlertDialog(
      title: Text("Simple Alert"),
      content: Text("This is an alert message."),
      actions: [],
    );
  }

  displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('TextField AlertDemo'),
          );
        });
  }

   create(String roomid)async{
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    FirebaseAuth auth=FirebaseAuth.instance;
    await _firestore
  .collection('game')
  .doc(roomid)
  .collection('room')
  .add({
    'draw':0,
    'winner':'false',
     'play':'false',
     'createdname':auth.currentUser!.displayName,
     'joinedname':'waiting',
     'createdturn':'true',
     'joinedturn':'false',
      'createdturnname':'X',
    'joinedturnname':'O',
     '0': '',
                                                '1': '',
                                                '2': '',
                                                '3': '',
                                                '4': '',
                                                '5': '',
                                                '6': '',
                                                '7': '',
                                                '8': '',
     'time':DateTime.now()
    });
  
  }
   join(String createdname,String createdturn)async{
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    FirebaseAuth auth=FirebaseAuth.instance;
    Map <String ,dynamic> usermap;
   
  
    await _firestore
  .collection('game')
  .doc('a')
  .collection('room')
  .add({
    'draw':0,
    'winner':'false',
    'play':'false',
    'createdname':createdname,
    'createdturn':createdturn,
    'joinedname':auth.currentUser!.displayName,
    'joinedturn':'false',
    'createdturnname':'X',
    'joinedturnname':'O',
     '0': '',
                                                '1': '',
                                                '2': '',
                                                '3': '',
                                                '4': '',
                                                '5': '',
                                                '6': '',
                                                '7': '',
                                                '8': '',
     'time':DateTime.now()
    
    });
  }
  createname(String n){
    return n;
  }
  joinname(String n){
    return n;
  }

   joined()async{
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    FirebaseAuth auth=FirebaseAuth.instance;
    Map <String ,dynamic> usermap;
   
  
    await _firestore
  .collection('game')
  .doc('a')
  .collection('room')
   .orderBy('time',descending: false)
  .get()
  .then((value){
      usermap =value.docs.last.data();
      join(usermap['createdname'], usermap['createdturn']);
  });
  }

 
  add(
    String draw,String winner,String play,String createdname,
    String joinedname,String createdturn,String joinedturn,
    String createdturnname,String joinedturnname,String one,
    String two,String three,String four,String five,String six,
    String seven,String eight,String nine
  )async{
      FirebaseFirestore _firestore = FirebaseFirestore.instance;
      
        
     await _firestore
                                                  .collection('game')
                                                  .doc('a')
                                                  .collection('room')
                                                  .add({
                                                'draw':draw,
                                                'winner': winner,
                                                'play': play,
                                                'createdname': createdname,
                                                'joinedname': joinedname,
                                                'createdturn': createdturn,
                                                'joinedturn': joinedturn,
                                                'createdturnname': createdturnname,
                                                
                                                'joinedturnname': joinedturnname,
                                                '0': one,
                                                '1': two,
                                                '2': three,
                                                '3': four,
                                                '4': five,
                                                '5': six,
                                                '6': seven,
                                                '7': eight,
                                                '8': nine,
                                                'time': DateTime.now()
                                              });

  }



   win(
    String draw,String winner,String play,String createdname,
    String joinedname,String createdturn,String joinedturn,
    String createdturnname,String joinedturnname,String one,
    String two,String three,String four,String five,String six,
    String seven,String eight,String nine
  )async{
      FirebaseFirestore _firestore = FirebaseFirestore.instance;
     await _firestore
                                                  .collection('game')
                                                  .doc('a')
                                                  .collection('room')
                                                  .add({
                                                'draw':draw,
                                                'winner': winner,
                                                'play': play,
                                                'createdname': createdname,
                                                'joinedname': joinedname,
                                                'createdturn': createdturn,
                                                'joinedturn': joinedturn,
                                                'createdturnname': createdturnname,
                                                
                                                'joinedturnname': joinedturnname,
                                                '0': one,
                                                '1': two,
                                                '2': three,
                                                '3': four,
                                                '4': five,
                                                '5': six,
                                                '6': seven,
                                                '7': eight,
                                                '8': nine,
                                                'time': DateTime.now()
                                              });

  }

nameadd(String username)async{
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth auth=FirebaseAuth.instance;
   var name=auth.currentUser!.displayName;
  String roomid="$name$username";

await _firestore
                  .collection('chat')
                  .doc(auth.currentUser!.displayName)
                  .collection('name')
                  .add(
                    {  
                      'name':username,
                      'roomid':roomid,
                      'time':DateTime.now(),

                    }
                  );
}

nameadd2(String username)async{
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth auth=FirebaseAuth.instance;
   var name=auth.currentUser!.displayName;
  String roomid="$name$username";

await _firestore
                  .collection('chat')
                  .doc(username)
                  .collection('name')
                  .add(
                    {
                      'name':auth.currentUser!.displayName,
                      'roomid':roomid,
                      'time':DateTime.now(),
                      
                    }
                  );
}

sendmessage(String username,String roomid,String message)async{
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
FirebaseAuth auth=FirebaseAuth.instance;
await _firestore
                  .collection('chatting')
                  .doc(roomid)
                  .collection('message')
                  .add(
                    {
                      'sendby':auth.currentUser!.displayName,
                      'sendto':username,
                      'message':message,
                      'time':DateTime.now(),
                      
                    }
                  );
}

String currentusername(){
  FirebaseAuth auth=FirebaseAuth.instance;
  var name=auth.currentUser!.displayName;
  return "$name";
}

String currentuseremail(){
  FirebaseAuth auth=FirebaseAuth.instance;
  var name=auth.currentUser!.email;
  return "$name";
}

}
