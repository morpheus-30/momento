//make a screen named datescreen for date question today date

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:momento/screens/pre_assessment_questions/ResultsScreen.dart';
import 'package:momento/screens/pre_assessment_questions/dateDropDownData.dart';
import 'package:momento/widgets/buttons/loginButton.dart';
import 'package:momento/widgets/buttons/textField.dart';
import 'package:sizer/sizer.dart';

class DateScreen extends StatefulWidget {
  Map<String, dynamic> data;
  DateScreen({required this.data});

  @override
  State<DateScreen> createState() => _DateScreenState();
}

class _DateScreenState extends State<DateScreen> {
  String Date = "";
  String Month = "";
  String Year = "";
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: ((context, orientation, devicetype) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
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
          backgroundColor: Color(0xFFC68642),
        ),
        body: Stack(
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 30.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("What is today's date?",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.sp,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.bold,
                        )),
                    SizedBox(
                      height: 5.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: 20.w,
                            child: MomentotextField(
                                inputText: "DD",
                                onSaved: (value) {
                                  Date = value;
                                })),
                        SizedBox(
                          width: 5.w,
                        ),
                        DropdownMenu(
                          onSelected: (value) {
                            Month = value;
                          },
                          hintText: "MM",
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 10.sp,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.bold,
                          ),
                          menuStyle: MenuStyle(
                            backgroundColor: MaterialStateProperty.all(
                              Colors.grey[200],
                            ),
                            side: MaterialStateProperty.all(
                              BorderSide(
                                color: Colors.black,
                                width: 0.5,
                              ),
                            ),
                          ),
                          width: 30.w,
                          dropdownMenuEntries:
                              MonthDropDownData.map((e) => DropdownMenuEntry(
                                    value: e,
                                    label: e,
                                  )).toList(),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        DropdownMenu(
                          onSelected: (value) {
                            Year = value;
                          },
                          hintText: "YYYY",
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 10.sp,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.bold,
                          ),
                          menuStyle: MenuStyle(
                            backgroundColor: MaterialStateProperty.all(
                              Colors.grey[200],
                            ),
                            side: MaterialStateProperty.all(
                              BorderSide(
                                color: Colors.black,
                                width: 0.5,
                              ),
                            ),
                          ),
                          width: 30.w,
                          dropdownMenuEntries: YearDropDownData.map(
                                  (e) => DropdownMenuEntry(value: e, label: e))
                              .toList(),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: 5.h),
                width: 90.w,
                child: LoginButton(
                  onPressed: () async {
                    String date = Date + "/" + Month + "/" + Year;
                    widget.data["Date"] = {
                      "Date": date,
                      "isCorrect": date == DateTime.now().toString().substring(0, 10)
                    };

                    print(widget.data);
                    await FirebaseFirestore.instance
                        .collection('Users')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .set({
                      'email': FirebaseAuth.instance.currentUser!.email,
                      'Image': "",
                      'preques': widget.data,
                      'lastDailyTriviaDone': "00000000",
                    });
                    await FirebaseFirestore.instance
                        .collection('Pattern')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .set({
                      'HighScore': 0,
                    }, SetOptions(merge: true));
                    await FirebaseFirestore.instance
                        .collection('MysteryLyrics')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .set({
                      'HighScore': 0,
                    }, SetOptions(merge: true));
                    Navigator.popUntil(context, (route) => route.isFirst);
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return ResultsScreen();
                      },
                    ));
                  },
                  text: "Continue",
                ),
              ),
            )
          ],
        ),
      );
    }));
  }
}
