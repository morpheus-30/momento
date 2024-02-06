import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:momento/constants.dart';
import 'package:momento/screens/pre_assessment_questions/ListenAndSpell.dart';
import 'package:momento/widgets/buttons/signUpButton.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:sizer/sizer.dart';
import 'DrawingBoard.dart';

class ClockScreen extends StatefulWidget {
  @override
  State<ClockScreen> createState() => _ClockScreenState();
}

class _ClockScreenState extends State<ClockScreen> {
  Uint8List? image;
  String imageurl = "";
  ScreenshotController screenshotController = ScreenshotController();
  uploadImage() async {
    image = await screenshotController.capture();
    final tempDir = await getTemporaryDirectory();
    File imageFile = await File('${tempDir.path}/image.png').create();
    imageFile.writeAsBytesSync(image!);
    // print(imageFile);
    if (image == null) {
      print("image is null");
      return;
    }
    final user = FirebaseAuth.instance.currentUser;
    final ref = FirebaseStorage.instance
        .ref()
        .child('clock_images')
        .child(user!.uid + '.jpg');
    await ref.putFile(imageFile);
    imageurl = await ref.getDownloadURL();
    print(imageurl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leadingWidth: 25.w,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/Help');
                },
                icon: Icon(
                  Icons.help_outline_outlined,
                  color: Colors.white,
                ))
          ],
          elevation: 2,
          centerTitle: true,
          title: Text(
            "Pre-Assessment Question",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.sp,
              fontFamily: "Montserrat",
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: brown2,
          leading: Row(
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
            ],
          ),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 10.w),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Draw A clock showing 'A quarter past 3'",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w900,
                    fontSize: 20.sp,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                    style: BorderStyle.solid,
                    color: brown2,
                    width: 8,
                  )),
                  height: 90.w,
                  width: 90.w,
                  child: Screenshot(
                    child: DrawingBoard(),
                    controller: screenshotController,
                  ),
                ),
                SizedBox(
                  width: 80.w,
                  child: SignUpButton(
                    onPressed: () async {
                      await uploadImage();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ListenAndSpell(
                            data: {"clockDraw": imageurl},
                          ),
                        ),
                      );
                    },
                    text: "Continue",
                    color: brown2,
                    textcolor: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
