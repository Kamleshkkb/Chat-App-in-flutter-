


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:one_chat_app/chatapp/chatone.dart';
import 'package:one_chat_app/chatapp/forgetpassword.dart';
import 'package:one_chat_app/chatapp/login.dart';
import 'package:one_chat_app/chatapp/methods.dart';



class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
   FirebaseFirestore _firestore = FirebaseFirestore.instance;
   final  formGlobalkey = GlobalKey<FormState>();
  bool isLoading = false;
  bool isexits=false;
  Service service=Service();
  
already(String enteredname)async{
  var usermap;
  await _firestore
  .collection('user')
  .where('name',isEqualTo: enteredname)
  .get()
  .then((value) {
    print("value==="+"$value");
    setState(() {
      try {
         usermap=value.docs[0].data();
      if (usermap['name']==enteredname) {
        showDialog(context: context, builder: (BuildContext context){
                            return AlertDialog(
                              title: Text("This name is already exists"),
                            );
                          });
        print("this name is exits");
      }
      else
      {
        print("this name is not exits");
      }
      } catch (e) {
          service.createAccount(_name.text, _email.text, _password.text,context);
           Navigator.push(context, MaterialPageRoute(builder: (_)=>LoginScreen()));
        print("eeeeeee="+"$e");
      }
     
    });

    
  });
}


  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body:  SingleChildScrollView(
              child: Form(
                key: formGlobalkey,
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height / 20,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      width: size.width / 0.5,
                      child: IconButton(
                          icon: Icon(Icons.arrow_back_ios), onPressed: () {
                            
                          }),
                    ),
                    SizedBox(
                      height: size.height / 50,
                    ),
                    Container(
                      width: size.width / 1.1,
                      child: Text(
                        "Welcome",
                        style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      width: size.width / 1.1,
                      child: Text(
                        "Create Account to Contiue!",
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height / 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18.0),
                      child: Container(
                        width: size.width,
                        alignment: Alignment.center,
                        child: field(size, "name", Icons.account_box, _name),
                      ),
                    ),
                    Container(
                      width: size.width,
                      alignment: Alignment.center,
                      child: field(size, "email", Icons.account_box, _email),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18.0),
                      child: Container(
                        width: size.width,
                        alignment: Alignment.center,
                        child: field(size, "password", Icons.lock, _password),
                      ),
                    ),
                    SizedBox(
                      height: size.height / 20,
                    ),

                   
                    FlatButton(
                     
                      onPressed: (){
                      // if (_name.text=='kamlesh') {
                      //   print('inside kamlesh');
                      //   showDialog(context: context, builder: (BuildContext context){
                      //       return AlertDialog(
                      //         title: Text("This name is already exists"),

                      //       );
                      //     });
                      // }

                       if(_name.text.isNotEmpty&&_email.text.isNotEmpty&&_password.text.isNotEmpty){
                         already(_name.text);
                         
                       }
                       else
                       {
                         showDialog(context: context, builder: (BuildContext context){
                            return AlertDialog(
                              title: Text("Please fill all field"),
                            );
                          });
                       }
                        
                      //   if (isexits==true) {
                      //     print('inside kamlesh');
                      //     showDialog(context: context, builder: (BuildContext context){
                      //       return AlertDialog(
                      //         title: Text("This name is already exists"),
                      //       );
                      //     });
                      //   setState(() {
                      //     isexits=false;
                      //   });
                      //   } else {
                      //     // service.createAccount(_name.text, _email.text, _password.text,context);
                      
                      //
                      //   }
                        

                      
                     
                    }, child: Text("Register",
                    style: TextStyle(
                       color: Colors.blue,
                    ),
                    )),
                  //  customButton(size),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        
                        onTap: () => Navigator.pop(context),
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }

     

  Widget field(
      Size size, String hintText, IconData icon, TextEditingController cont) {

    return Container(
      height: size.height / 14,
      width: size.width / 1.1,
      child: TextField(
        controller: cont,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        
          // if (hintText!='password') {
          //    valid(hintText, value!);
          // }
          // if(isexits==true&&hintText!='password'){
           
          //   return 'This $hintText is already existing';
          // }
        
      ),
    );
  }
}