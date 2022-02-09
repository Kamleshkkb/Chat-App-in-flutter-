import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:one_chat_app/chatapp/helper.dart';

class chattwo extends StatefulWidget {
  final name;
  final roomid;
  const chattwo({ Key? key, this.name, this.roomid }) : super(key: key);

  @override
  _chattwoState createState() => _chattwoState();
}

class _chattwoState extends State<chattwo> {

   FirebaseFirestore _firestore = FirebaseFirestore.instance;
   TextEditingController message=TextEditingController();
  
    FirebaseAuth auth=FirebaseAuth.instance;
    Helper helper=Helper();
    ScrollController controller =ScrollController();

    void scroll(){
      final double end = controller.position.maxScrollExtent;
      controller.jumpTo(end);
    }
  @override
  Widget build(BuildContext context) {
   final size=MediaQuery.of(context).size;
    return 
    
    
    Scaffold(
     //resizeToAvoidBottomPadding:false,
    resizeToAvoidBottomInset: true,
    
      appBar: AppBar(
        title: Text(widget.name),
      ),

      body:SingleChildScrollView(
        
        child: Column(
          children: [
            Container(
              width: size.width,
              height: size.height/1.25,
              child: StreamBuilder<QuerySnapshot>(
        stream: _firestore
              .collection('chatting')
              .doc(widget.roomid)
              .collection('message')
              .orderBy('time',descending: false)
              .snapshots(),
      builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
        if (snapshot.hasData!=null) {
          return ListView.builder(
            controller: controller,
       // itemCount: 1,
         itemCount: snapshot.hasData?snapshot.data!.docs.length:0,
          reverse: false,
          shrinkWrap: true,
         // primary: true,
          physics: ScrollPhysics(

          ),
          itemBuilder: (context, i) {
            
            QueryDocumentSnapshot x = snapshot.data!.docs[i];
            return  Container(
             
              alignment: x['sendby']==helper.currentusername()?
              Alignment.centerRight:
              Alignment.centerLeft,
              child: Container(
                width:  x['message'].toString().length>31?
                size.width-100:
                null,
              
              // width: x['message'].,
              padding:EdgeInsets.symmetric(vertical: 10,horizontal: 14),
              
                margin: EdgeInsets.symmetric(vertical: 5,horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.blue,
                ),
                child:Text(x['message'],
                // style: TextStyle(
                //   fontSize: 16,
                //   fontWeight: FontWeight.w500,
                //   color:Colors.white
                // ),
                ) ,
              )
              ,
            );
          }
        );
        } else {
          return CircularProgressIndicator();
        }
        
          }
     
        
        ),
            ),
        //        Column(
        //          children: [
        //            Container(
        //              height: size.height/17,
        //              width: size.width/1.3,
        //                  child: Row(
        //   children: [
        //     TextField(
        //       controller: message,
        //     ),
        //     IconButton(onPressed: (){
        //       helper.sendmessage(widget.name,widget.roomid, message.text);
        //     }, icon: Icon(Icons.send))
        //   ],
        // ),
        //            ),
        //          ],
        //        ),

        //  TextField(
        //       controller: message,
        //     ),
        //      IconButton(onPressed: (){
        //       helper.sendmessage(widget.name,widget.roomid, message.text);
        //     }, icon: Icon(Icons.send))
        /*
        Flexible(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: size.width,
              maxWidth: size.height,
              minHeight: 25.0,
              maxHeight: 135.0,

            ),
            child: Scrollbar(
              child: TextField(
                cursorColor: Colors.red,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: message,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(
                    top: 2.0,
                    left: 13.0,
                    right: 13.0,
                    bottom: 2.0,

                  ),
                  hintText: "type your message",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  )
                ),
              ),
            ),
          ),
        ),*/
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: Scrollbar(

             child :TextFormField(
               
                cursorColor: Colors.red,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: message,
            
                decoration: InputDecoration(
                  
                  suffix: IconButton(onPressed: (){
                    helper.sendmessage(widget.name,widget.roomid,message.text);
                   
                    message.clear();
                     scroll();
                  }, icon:Icon(Icons.send)),
                  border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20)
            ),
                  contentPadding: EdgeInsets.only(
                    top: 2.0,
                    left: 13.0,
                    right: 13.0,
                    bottom: 2.0,
         
                  ),
                  hintText: "type your message",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                
              ),
           ),
         ),
          ],
        ),
      )
      
     
      
     
    );
  }
}