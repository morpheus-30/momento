import 'package:flutter/material.dart';
import 'package:momento/constants.dart';
import 'package:sizer/sizer.dart';

class DailyTriviaCompleted extends StatelessWidget {
  const DailyTriviaCompleted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
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
        ]
      ),
      backgroundColor: brown2,
      body: Center(
        child: Text("Your daily trivia is completed!",
        textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30.sp,
              color: Colors.white,
              fontFamily: "Montserrat",
              fontWeight: FontWeight.bold,
            )),
      ),
    );
  }
}