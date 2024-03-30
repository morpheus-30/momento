import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:momento/constants.dart';
import 'package:momento/screens/pre_assessment_questions/MathScreen.dart';
import 'package:momento/widgets/buttons/loginButton.dart';
import 'package:momento/widgets/buttons/textField.dart';
import 'package:sizer/sizer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoScreen extends StatelessWidget {
  Map<String, dynamic> data;
  VideoScreen({required this.data});

  @override
  Widget build(BuildContext context) {
    List<String> validObjects = [
    ];
    List<String> objects = [];
    String word1 = "";
    String word2 = "";
    String word3 = "";
    String word4 = "";
    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
        // resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
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
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(top: 1.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      right: 5.w,
                      left: 5.w,
                    ),
                    child: Text("List 4 Objects from the image",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17.sp,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  Container(
                    padding: EdgeInsets.all(0.h),
                    margin: EdgeInsets.only(
                        right: 5.w, left: 5.w, top: 2.h, bottom: 2.h),
                    height: 20.h,
                    width: 80.w,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: brown2,
                        width: 3,
                      ),
                    ),
                    child: Image.asset('assets/images/objects.jpeg'),
                  ),
                  SizedBox(
                    width: 80.w,
                    child: Column(
                      children: [
                        MomentotextField(
                            inputText: "Object #1",
                            onSaved: (value) {
                              word1 = value;
                            }),
                        SizedBox(height: 1.h),
                        MomentotextField(
                            inputText: "Object #2",
                            onSaved: (value) {
                              word2 = value;
                            }),
                        SizedBox(height: 1.h),
                        MomentotextField(
                          inputText: "Object #3",
                          onSaved: (value) {
                            word3 = value;
                          },
                        ),
                        SizedBox(height: 1.h),
                        MomentotextField(
                          inputText: "Object #4",
                          onSaved: (value) {
                            word4 = value;
                          },
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  SizedBox(
                    width: 80.w,
                    child: LoginButton(
                      onPressed: () {
                        List<String> objects = [word1, word2, word3, word4];
                        List<String> validObjects = [
                          "apple",
                          "ball",
                          "pencil",
                          "book",
                        ];
                        bool valid = true;
                        for (int i = 0; i < objects.length; i++) {
                          if (!validObjects.contains(objects[i])) {
                            valid = false;
                            break;
                          }
                        }
                        

                        data["4Objects"] = {
                          "objects": objects,
                          "isCorrect": valid
                        };
                        // print(data);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MathScreen(
                                  data: data,
                                )));
                      },
                      text: "Continue",
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
