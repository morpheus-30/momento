import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:momento/constants.dart';
import 'package:momento/widgets/buttons/loginButton.dart';
import 'package:sizer/sizer.dart';

class EditProfile extends StatefulWidget {
  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  ImagePicker picker = ImagePicker();

  File? image;
  bool loading = false;
  String imageUrl = "";
  @override
  void initState() {
    // TODO: implement initState
    getProfileImage();
  }

  void getProfileImage() async {
    imageUrl = await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) => value['Image']);
    setState(() {});
  }

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
    }
  }

  uploadImage() async {
    if (image == null) {
      return;
    }
   
    final user = FirebaseAuth.instance.currentUser;
    final ref = FirebaseStorage.instance
        .ref()
        .child('profile_images')
        .child(user!.uid + '.jpg');
    await ref.putFile(image!);
    imageUrl = await ref.getDownloadURL();
    await user.updatePhotoURL(imageUrl);
   
    print(imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    dynamic imageWidget = imageUrl == ""
        ? AssetImage("assets/images/profile.png")
        : NetworkImage(imageUrl);
    String password = "";
    
    return loading==true?Scaffold(body: Center(child: CircularProgressIndicator()),):Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        leadingWidth: 30.w,
        centerTitle: true,
        title: Text(
          "Profile",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Montserrat",
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: brown2,
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            IconButton(
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/home'));
                Navigator.pushNamed(context, '/home');
              },
              icon: Icon(
                Icons.home,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: 15.h,
            color: brown2,
          ),
          Container(
            margin: EdgeInsets.only(left: 20.w, right: 20.w),
            child: CircleAvatar(
              radius: 40.w,
              backgroundColor: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: CircleAvatar(
                  child: CircleAvatar(
                      backgroundColor: Colors.white.withOpacity(0.5),
                      radius: 30.w,
                      child: IconButton(
                        onPressed: () async {
                          await getImage();
                          setState(() {
                            loading = true;
                          });
                          await uploadImage();
                          await FirebaseFirestore.instance
                              .collection('Users')
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .update({
                            'Image': imageUrl,
                          });
                          setState(() {
                            loading = false;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Profile Picture Updated"),
                          ));
                          Navigator.popUntil(
                                  context, ModalRoute.withName('/home'));
                          Navigator.pushNamed(context, '/home');
                        },
                        icon: Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 20.w,
                        ),
                      )),
                  backgroundImage: imageWidget,
                  radius: 30.w,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 40.h),
            child: Center(
              child: Theme(
                data: ThemeData(
                  primaryColor: brown2,
                  primaryColorDark: brown2,
                ),
                child: SizedBox(
                  width: 80.w,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Welcome "+FirebaseAuth.instance.currentUser!.email.toString(),
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            color: brown2,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 5.h),
                        TextField(
                          onChanged: (value) {
                            password = value;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Container(
                          width: 80.w,
                          child: LoginButton(
                            onPressed: () async {
                              if (password == "") {
                                return;
                              }
                              await FirebaseAuth.instance.currentUser!
                                  .updatePassword(password);
                              Navigator.popUntil(
                                  context, ModalRoute.withName('/home'));
                                  Navigator.pushNamed(context, '/home');
                            },
                            text: "Update Password",
                          ),
                        ),
                      ]),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
