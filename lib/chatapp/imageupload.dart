// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'firebase_storage/firebase_storage.dart';

// class uploadimage extends StatefulWidget {
//   final userid;
//   const uploadimage({Key? key, this.userid}) : super(key: key);

//   @override
//   _uploadimageState createState() => _uploadimageState();
// }

// class _uploadimageState extends State<uploadimage> {
//   File? _image;
//   String? downloadurl;
//   final imagepicker = ImagePicker();

//   Future imagePickerMethod() async {
//     final pick = await imagepicker.pickImage(source: ImageSource.camera);

//     setState(() {
//       if (pick != null) {
//         _image = File(pick.path);
//       } else {
//         showSnackbar('no file selected', Duration(milliseconds: 400));
//       }
//     });
//   }

//   Future uploadImage() async {
//     final postid = DateTime.now().millisecondsSinceEpoch.toString();
//     Reference ref = FirebaseStorage.instance
//         .ref()
//         .child("1/images")
//         .child("post_$postid");
//     await ref.putFile(_image!);
//     downloadurl = await ref.getDownloadURL();
//     print(downloadurl);
//   }

//   showSnackbar(String snacktext, Duration d) {
//     final snackBar = SnackBar(
//       content: Text(snacktext),
//       duration: d,
//     );
//     ScaffoldMessenger.of(context).showSnackBar(snackBar);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('image upload'),
//       ),
//       body: Center(
//         child: Padding(
//           padding: EdgeInsets.all(8),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(30),
//             child: SizedBox(
//               height: 500,
//               width: double.infinity,
//               child: Column(
//                 children: [
//                   Text("Upload mage"),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Expanded(
//                     flex: 4,
//                     child: Container(
//                       width: 350,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20),
//                           border: Border.all(
//                             color: Colors.red,
//                           )),
//                       child: Center(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Expanded(
//                                 child: _image == null
//                                     ? Center(
//                                         child: Text("No image is selected "),
//                                       )
//                                     : Image.file(_image!)),
//                             ElevatedButton(
//                               onPressed: () {
//                                 imagePickerMethod();
//                               },
//                               child: Text("select image"),
//                             ),
//                             ElevatedButton(
//                               onPressed: () {

//                                 if (_image!=null) {
//                                    uploadImage().whenComplete(() => showSnackbar(
//                                     "image uploaded successfully",
//                                     Duration(seconds: 2)));
//                                 } else {
//                                    showSnackbar(
//                                     "select image first",
//                                     Duration(seconds: 2));
//                                 }
                               
//                               },
//                               child: Text("upload image"),
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
