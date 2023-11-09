import 'package:flutter/material.dart';
import 'package:momento/constants.dart';
import 'package:momento/widgets/buttons/signUpButton.dart';
import 'package:sizer/sizer.dart';

class PreAssessmentScreen extends StatelessWidget {
  const PreAssessmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, devicetype, orientation) {
      return Scaffold(
          appBar: AppBar(
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
              "Welcome",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: brown2,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Container(
            margin: EdgeInsets.all(7.w),
            child: Column(
              children: [
                Text(
                  "Take quick assessment to determine your prognosis",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp,
                  ),
                ),
                Image.asset(
                  "assets/images/assessment_vector.jpg",
                  height: 50.h,
                  width: 100.w,
                  fit: BoxFit.fitWidth,
                ),
                SizedBox(
                  width: 85.w,
                  child: SignUpButton(
                    onPressed: () {},
                    text: "Start",
                    color: brown2,
                    textcolor: Colors.white,
                  ),
                )
              ],
            ),
          ));
    });
  }
}
