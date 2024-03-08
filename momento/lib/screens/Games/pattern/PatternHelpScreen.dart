import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

class PatternHelp extends StatelessWidget {
  const PatternHelp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5.h),
              Text(
                "How to play Pattern Matching?",
                style: TextStyle(
                  fontSize: 25.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                "Welcome to the Pattern Matching Game! Here's how to play:",
                style: TextStyle(
                  fontSize: 15.sp,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                "The Pattern Matching Game welcomes you! How to play is as follows:",
                style: TextStyle(
                  fontSize: 15.sp,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                "Easy Mode:",
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                ),
              ),
              SizedBox(height: 1.h),
              Text(
                "Three tiles will light up in a certain order when in this mode. After you have the pattern memorized, tap the tiles in the same order. Reach higher levels and unlock additional challenges.",
                style: TextStyle(
                  fontSize: 15.sp,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                "Medium Mode:",
                style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                ),
              ),
              SizedBox(height: 1.h),
              Text(
                "This adds a little more intricacy by illuminating four squares.Replicate the sequence precisely and with keen observation.Ascend the levels and put your developing memory abilities to the test.",
                style: TextStyle(
                  fontSize: 15.sp,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                "Hard Mode:",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                ),
              ),
              SizedBox(height: 1.h),
              Text(
                "Five tiles will light in complex patterns, providing the ultimate challenge.To beat the most difficult stages, keep the order in mind and tap each tile accurately.",
                style: TextStyle(
                  fontSize: 15.sp,
                ),
              ),
              SizedBox(height: 2.h),
              Container(
                height: 1,
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                "Display your mastery of memory as you progress through the game. Recall that your score increases with more accuracy of your taps. Are you prepared to learn patterns with varying degrees of difficulty? Let your path to success be illuminated by the tiles!",
                style: TextStyle(
                  fontSize: 15.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
