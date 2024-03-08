import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:momento/constants.dart';
import 'package:momento/screens/daily_trivia/DailytriviaCompleted.dart';
import 'package:momento/screens/daily_trivia/HourOfDay.dart';
import 'package:momento/screens/daily_trivia/NameOfAnimal.dart';
import 'package:momento/screens/daily_trivia/Options.dart';
import 'package:momento/widgets/buttons/signUpButton.dart';
import 'package:sizer/sizer.dart';

class DailyTriviaIntro extends StatelessWidget {
  User? user = FirebaseAuth.instance.currentUser;

  List<Widget> questions = [
    HourOfDay(),
    NameOfAnimal(
      animal: "cat",
    ),
    NameOfAnimal(
      animal: "dog",
    ),
    OptionsScreenDailyTrivia()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.transparent,
              ),
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
                Navigator.pushReplacementNamed(context, '/home');
              }),
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
              icon: const Icon(
                Icons.close,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
                Navigator.pushReplacementNamed(context, '/home');
              },
            ),
          ],
        ),
        backgroundColor: brown2,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Hello ${user!.email},",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30.sp,
                    color: Colors.white,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(
                height: 5.h,
              ),
              SizedBox(
                width: 70.w,
                child: Text(
                  "It's time for your daily trivia!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: Colors.white,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Image(image: AssetImage("assets/images/trivia.png")),
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                width: 60.w,
                child: SignUpButton(
                  onPressed: () async {
                    questions.shuffle();
                    List<Widget> randomList = questions.sublist(0, 2);
                    dynamic result1 = await Navigator.push(context,
                        MaterialPageRoute(builder: (context) => randomList[0]));
                    dynamic result2 = await Navigator.push(context,
                        MaterialPageRoute(builder: (context) => randomList[1]));
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DailyTriviaCompleted(
                          data: [result1, result2],
                        ),
                      ),
                    );},
                  text: "Let's Start",
                ),
              ),
            ],
          ),
        ));
  }
}
