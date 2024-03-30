import 'package:flutter/material.dart';
import 'package:momento/constants.dart';
import 'package:momento/screens/HomeScreen.dart';
import 'package:momento/screens/StartScreen.dart';
import 'package:momento/widgets/buttons/loginButton.dart';
import 'package:sizer/sizer.dart';

class ResultsScreen extends StatelessWidget {
  dynamic data;
  ResultsScreen({required this.data});
  List pointsToShow = [];
  List<String> questions = [
    "months",
    "listenAndSpell",
    "4Objects",
    "maths",
    "Date"
  ];
  List<String> allPoints = [
    "Sequencing and Organizing Thoughts",
    "Working Memory and Complex Instructions",
    "Focus and Memory",
    "Mathematical Reasoning and Concentration",
    "Recalling Recent Events and Orientation"
  ];

  @override
  Widget build(BuildContext context) {
    for (dynamic i in questions) {
      if (data[i]["isCorrect"] == false) {
        pointsToShow.add(allPoints[questions.indexOf(i)]);
      }
    }
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Results",
                style: TextStyle(
                  fontSize: 40.sp,
                  color: Colors.black,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.bold,
                )),
            SizedBox(
              height: 5.h,
            ),
            SizedBox(
              width: 80.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...pointsToShow
                      .map((e) => Column(
                            children: [
                              Text("• " + e,
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    color: Colors.black,
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.bold,
                                  )),
                              SizedBox(
                                height: 1.h,
                              ),
                            ],
                          ))
                      .toList(),
                ],
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            SizedBox(
              width: 70.w,
              child: Text(
                "We suggest contacting your Momento Specialist for further information.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.black,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.bold,
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
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => StartScreen()));
                  },
                  text: "Continue",
                )),
            SizedBox(
              height: 2.h,
            ),
            SizedBox(
              width: 80.w,
              child: Text(
                "This tool does not provide medical advice It is intended for informational purposes only. It is not a substitute for professional medical advice, diagnosis or treatment.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 5.sp,
                  color: Colors.black,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
