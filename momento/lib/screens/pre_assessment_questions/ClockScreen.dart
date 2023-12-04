import 'package:flutter/material.dart';
import 'package:momento/constants.dart';
import 'package:momento/screens/pre_assessment_questions/ListenAndSpell.dart';
import 'package:momento/widgets/buttons/signUpButton.dart';
import 'package:sizer/sizer.dart';
import 'DrawingBoard.dart';

class ClockScreen extends StatefulWidget {
  const ClockScreen({super.key});

  @override
  State<ClockScreen> createState() => _ClockScreenState();
}

class _ClockScreenState extends State<ClockScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 10.w),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Draw A clock showing 'A quarter past 3'",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w900,
                    fontSize: 20.sp,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                    style: BorderStyle.solid,
                    color: brown2,
                    width: 8,
                  )),
                  height: 90.w,
                  width: 90.w,
                  child: DrawingBoard(),
                ),
                SizedBox(
                  width: 50.w,
                  child: SignUpButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ListenAndSpell(),
                        ),
                      );
                    },
                    text: "Continue",
                    color: brown2,
                    textcolor: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
