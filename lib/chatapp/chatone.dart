import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:one_chat_app/chatapp/chatthree.dart';
import 'package:one_chat_app/chatapp/chattwo.dart';
import 'package:one_chat_app/chatapp/helper.dart';
import 'package:one_chat_app/chatapp/login.dart';
import 'package:one_chat_app/chatapp/resetpassword.dart';




class Chatone extends StatefulWidget {

  final name;
  const Chatone({ Key? key, this.name,  }) : super(key: key);

  @override
  _ChatoneState createState() => _ChatoneState();
}

class _ChatoneState extends State<Chatone> {
   FirebaseFirestore _firestore = FirebaseFirestore.instance;
    FirebaseAuth auth=FirebaseAuth.instance;
    TextEditingController name=TextEditingController();
    Helper helper=Helper();
   bool istrue=false;

   usercollection(String username)async{
     Map<String,dynamic> usermap;
                   _firestore
                  .collection('chat')
                  .doc(helper.currentusername())
                  .collection('name')
                  .where('name', isEqualTo:username)
                  .get()
                  .then((value) {
                    try {
                       setState(() {
                       usermap=value.docs[0].data();
                       if (usermap['name']==username) {

                          showDialog(context: context, builder: (BuildContext context){
                            return AlertDialog(
                              title: Text(""),
                            );
                          });
                       }
                        });
                    } catch (e) {
                      send();
                    }
                   
                      
                   
                  });

   }
    send()async{
         Map<String,dynamic> usermap;
       _firestore
                  .collection('user')
                  .where('name',isEqualTo: name.text)
                  .get()
                  .then((value) {
                    setState(() {
                      istrue=true;
                    });
                  });
    }



  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    
      return Scaffold(


      // appBar: AppBar(
      //   //title: Text(widget.username),
      //   actions: [
      //     IconButton(onPressed: (){
      //       auth.signOut();
      //        showDialog(context: context, builder: (BuildContext context){
      //                       return AlertDialog(
      //                         title: Text("logout Successfully"),
      //                       );
      //                     });
      //       Navigator.push(context, MaterialPageRoute(builder: (_)=>LoginScreen()));
      //     }, icon: Icon(Icons.logout)),
      //      IconButton(onPressed: (){
      //       auth.signOut();
      //       Navigator.push(context, MaterialPageRoute(builder: (_)=>chatthree(
             
      //       )));
      //     }, icon: Icon(Icons.person))

      //   ],
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
             SizedBox(
              height: 20,),

            Container(
              height: size.height/12,
              color: Colors.blue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
               
                SizedBox(
                  width: size.width/2,
                ),
                 SizedBox(
                ),
                 IconButton(onPressed: (){
              auth.signOut();
                
              Navigator.push(context, MaterialPageRoute(builder: (_)=>LoginScreen()));
              ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              'Account Logout Successfully',
              style: TextStyle(fontSize: 18.0),
            ),
          ),
              );
          }, icon: Icon(Icons.logout)),
           IconButton(onPressed: (){
              //  auth.signOut();
              Navigator.push(context, MaterialPageRoute(builder: (_)=>chatthree(
               
              )));
          }, icon: Icon(Icons.person)),
 
              ],),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(

                  borderRadius: BorderRadius.circular(20)
                ),
                hintText: 'enter Your Friend user name'
              ),
              controller: name,
            ),
            FlatButton(
                          
              onPressed: ()
              {
              if (!name.text.isEmpty) {
                  usercollection(name.text);
      
              if (istrue) {
                var currentuser=helper.currentusername();
                var otheruser=name.text;
                String roomid="$currentuser$otheruser";
                 helper.nameadd(name.text);
                 helper.nameadd2(name.text);
                 helper.sendmessage(name.text, roomid, 'hi');

                 setState(() {
                   istrue=false;
                 });
              }
              else{
                showDialog(context: context, builder: (BuildContext context){
                              return AlertDialog(
                                title: Text("This user name is invalid"),
                              );
                            });
               }
              }
            },
            child: Text('Add Your Friend'),
            ),
            StreamBuilder<QuerySnapshot>(
            stream: _firestore
                    .collection('chat')
                    .doc(helper.currentusername())
                    .collection('name')
                    .orderBy('time',descending: false)
                    .snapshots(),
            builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
              if (snapshot.hasData!=null) {

                return ListView.builder(
             // itemCount: 1,
                itemCount: snapshot.hasData?
                snapshot.data!.docs.length:0,
                reverse: false,
                shrinkWrap: true,
                primary: true,
                physics: ScrollPhysics(),
                itemBuilder: (context, i) {
                  
                  QueryDocumentSnapshot x = snapshot.data!.docs[i];
                  return  ListTile(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>chattwo(
                        name: x['name'],
                        roomid: x['roomid'],
                      )));
                    },
                    leading: Icon(Icons.account_box),
                    title: Text(x['name']),
                    trailing: Icon(Icons.send),
      
                  );
                }
              );
              } else {
                return CircularProgressIndicator();
              }
                }

            //       ListTile(
            //         title: Column(
            //         //  crossAxisAlignment:loginUser!.email==x['User']? CrossAxisAlignment.end:CrossAxisAlignment.start,
            //           children:[
      
            //             Container(
            //               padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10,),
            //               decoration: BoxDecoration(
            //               //     color:loginUser!.email==x['User']? Colors.blue.withOpacity(0.2):Colors.amber.withOpacity(0.2),
                   //              borderRadius: BorderRadius.circular(15)
                  //               ),
                 //             child:Column(
                //               crossAxisAlignment: CrossAxisAlignment.start,
               //                 children: [
              //                    Text(x['email']),
             //                    SizedBox(height: 5,),
            //                     Text("User : "+x['name'],style: TextStyle(fontSize: 13,color: Colors.green),),
                      
                       
                    //                 ],
                   //               )
                  //               )
                 //           ]
                //         )
               //       );
              //   })
                
              //    else ListView.builder(
              //   itemCount: snapshot.data!.docs.length,
              //   shrinkWrap: true,
              //   primary: true,
              //   physics: ScrollPhysics(),
              //   itemBuilder: (context, i) {
              //     QueryDocumentSnapshot x = snapshot.data!.docs[i];
              //     return  Text(x['sendby']);
              //   })
      
              //   ],
              // );
              
              ),
      
          ],
        ),
      ),
    );
    
  }
}