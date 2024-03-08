import 'dart:math';

import 'package:flutter/material.dart';
import 'package:momento/constants.dart';
import 'package:momento/screens/daily_trivia/DailytriviaCompleted.dart';
import 'package:momento/widgets/buttons/loginButton.dart';
import 'package:sizer/sizer.dart';

class NameOfAnimal extends StatelessWidget {
  
  String animal ;
  NameOfAnimal({required this.animal});

  dynamic data = {
    "answer":"",
    "iscorrect":false
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications,
                color: Colors.white,
              )),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.question_mark,
              color: Colors.white,
            ),
          ),
        ],
        elevation: 2,
        leadingWidth: 30.w,
        centerTitle: true,
        title: const Text(
          "Daily Trivia",
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
              onPressed: () {},
              icon: const Icon(
                Icons.home,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 80.w,
              child: Text("Which animal is this?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: Colors.black,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.bold,
                  )),
            ),
            SizedBox(
              height: 5.h,
            ),
            Image(
              width: 80.w,
              height: 40.h,
              image: AssetImage("assets/images/animal_images/$animal.jpg"),
            ),
            SizedBox(
              height: 5.h,
            ),
            SizedBox(
              width: 80.w,
              child: TextField(
                onChanged: (value) {
                  data["answer"] = value;
                },
                decoration: InputDecoration(
                  hintText: "Enter your answer here",
                  hintStyle: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.black,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.bold,
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            SizedBox(
              width: 80.w,
              child: LoginButton(
                  onPressed: () {
                    if (data["answer"].toLowerCase() == animal.toLowerCase()) {
                      data["iscorrect"] = true;
                    }
                    Navigator.pop(context,data);
                  },
                  text: "Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
