import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:draw_graph/draw_graph.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:momento/constants.dart';
import 'package:momento/widgets/buttons/loginButton.dart';
import 'package:sizer/sizer.dart';
import 'package:draw_graph/models/feature.dart';

class ProgressionScreen extends StatefulWidget {
  const ProgressionScreen({super.key});

  @override
  State<ProgressionScreen> createState() => _ProgressionScreenState();
}

class _ProgressionScreenState extends State<ProgressionScreen> {

  dynamic scores;

  Future<void> getScores() async {
    await FirebaseFirestore.instance
        .collection("MysteryLyrics")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("Scores")
        .get();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map<int, int> dateToScore = {
      1: 169,
      2: 278,
      3: 878,
      4: 981,
      5: 651,
      6: 789,
      7: 123,
      8: 456,
      9: 231,
      10: 789,
      13: 169,
      17: 278,
      19: 878,
      23: 981,
      28: 651,
      31: 789,
    };
    List<int> dates = [
      1,
      2,
      3,
      4,
      5,
      6,
      7,
      8,
      9,
      10,
      11,
      12,
      13,
      14,
      15,
      16,
      17,
      18,
      19,
      20,
      21,
      22,
      23,
      24,
      25,
      26,
      27,
      28,
      29,
      30,
      31
    ];
    List<double> scores = [];
    for (int i = 0; i < dates.length; i++) {
      if (dateToScore.containsKey(dates[i])) {
        scores.add(dateToScore[dates[i]]!.toDouble() / 1000);
      } else {
        scores.add(0);
      }
    }
    print(scores);

    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 10.h),
        child: Center(
          child: Column(
            children: [
              Text(
                "Progression",
                style: TextStyle(
                  fontSize: 30.sp,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 5.h),
              LineGraph(
                features: [
                  Feature(
                    data: scores,
                    color: brown2,
                    title: "Scores",
                  )
                ],
                size: Size(320, 350),
                showDescription: true,
                graphColor: Colors.black,
                verticalFeatureDirection: true,
                labelX: [
                  "1",
                  "5",
                  "10",
                  "15",
                  "20",
                  "25",
                  "30",
                  "31",
                ],
                labelY: [
                  "0",
                  "200",
                  "400",
                  "600",
                  "800",
                  "1000",
                ],
              ),
              SizedBox(height: 5.h),
              Text(
                "Result of the last 31 days",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10.sp,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 1.h),
              Text(
                "Result shows a decrease in activity",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.bold,
                  color: Colors.red[900]!,
                ),
              ),
              SizedBox(height: 2.h),
              SizedBox(
                width: 80.w,
                child: LoginButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  text: "Back",
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                "This tool does not provide medical advice It is intended for informational purposes only. It is not a substitute for professional medical advice, diagnosis or treatment.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 8.sp,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
