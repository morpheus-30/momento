import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:momento/constants.dart';
import 'package:momento/screens/pre_assessment_questions/ResultsScreen.dart';
import 'package:momento/screens/pre_assessment_questions/SelectMonths.dart';
import 'package:momento/screens/daily_trivia/HourOfDay.dart';
import 'package:momento/screens/daily_trivia/NameOfAnimal.dart';
import 'package:momento/screens/pre_assessment_questions/DateScreen.dart';
import 'package:momento/screens/pre_assessment_questions/VideoObjects.dart';
import 'package:momento/widgets/buttons/loginButton.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.popUntil(context, (route) => route.isFirst);
                Navigator.pushNamed(context, '/');
              },
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              )),
          IconButton(
            onPressed: () async {
              // Navigator.pushNamed(context, '/Help');
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => ResultsScreen(
              //               data: const {
              //                 "months": {
              //                   "selectedMonths": [
              //                     "January",
              //                     "February",
              //                     "March"
              //                   ],
              //                   "isCorrect": false
              //                 },
              //                 "listenAndSpell": {
              //                   "word": "momen",
              //                   "isCorrect": false
              //                 },
              //                 "4Objects": {
              //                   "objects": ["apple", "ball", "pencil", "book"],
              //                   "isCorrect": false
              //                 },
              //                 "maths": {"ans": 64, "isCorrect": false},
              //                 "Date": {
              //                   "Date": "2/March/2024",
              //                   "isCorrect": false
              //                 }
              //               },
              //             )));
            },
            icon: Icon(
              Icons.question_mark,
              color: Colors.white,
            ),
          ),
        ],
        elevation: 2,
        leadingWidth: 30.w,
        centerTitle: true,
        title: Text(
          "Home",
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
          children: [],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Welcome!",
                style: TextStyle(
                  fontSize: 30.sp,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                )),
            SizedBox(height: 8.h),
            Column(
              children: [
                ...["Games", "Resources", "Progression", "Profile"]
                    .map((e) => Column(
                          children: [
                            SizedBox(
                              width: 80.w,
                              child: LoginButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/$e');
                                },
                                text: e,
                              ),
                            ),
                            SizedBox(height: 3.h),
                          ],
                        ))
                    .toList()
              ],
            )
          ],
        ),
      ),
    );
  }
}
