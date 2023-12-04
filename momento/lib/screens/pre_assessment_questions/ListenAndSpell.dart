import 'package:flutter/material.dart';
import 'package:momento/constants.dart';
import 'package:momento/screens/pre_assessment_questions/VideoObjects.dart';
import 'package:momento/widgets/buttons/loginButton.dart';
import 'package:momento/widgets/buttons/signUpButton.dart';
import 'package:momento/widgets/buttons/textField.dart';
import 'package:sizer/sizer.dart';
import 'DrawingBoard.dart';

class ListenAndSpell extends StatelessWidget {
  const ListenAndSpell({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leadingWidth: 25.w,
        actions: [
          IconButton(
              onPressed: () {},
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
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.home,
                  color: Colors.white,
                ))
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            margin:
                EdgeInsets.only(top: 5.h, left: 10.w, right: 10.w, bottom: 2.h),
            child: Text(
              "Listen & Spell the Word Backwards",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.sp,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            decoration: BoxDecoration(
              color: lightBrown,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3))
              ],
            ),
            child: Container(
              margin: EdgeInsets.all(10.w),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Opacity(
                    opacity: 0.5,
                    child: Icon(
                      Icons.graphic_eq,
                      color: lightBrownButtonOutline,
                      size: 30.h,
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: IconButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(EdgeInsets.zero),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.transparent),
                          shape: MaterialStateProperty.all(
                            CircleBorder(),
                          ),
                          side: MaterialStateProperty.all(
                            BorderSide(
                              color: Colors.white,
                              width: 3,
                            ),
                          ),
                        ),
                        onPressed: () {
                          print("play");
                        },
                        icon: Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 20.h,
                        )),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 10.w),
              child: MomentotextField(
                inputText: "Enter the word",
              )),
          SizedBox(
            height: 2.h,
          ),
          LoginButton(onPressed: (){
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => VideoScreen()),
            );
          },text: "Continue",),
        ],
      ),
    );
  }
}
