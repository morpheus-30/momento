import 'package:flutter/material.dart';
import 'package:momento/constants.dart';
import 'package:momento/screens/HomeScreen.dart';
import 'package:momento/widgets/buttons/loginButton.dart';
import 'package:sizer/sizer.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: Text(
          "Results",
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
              onPressed: () {},
              icon: Icon(
                Icons.home,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
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
                  Text("-> Trouble remembering recent events",
                      style: TextStyle(
                        fontSize: 20.sp,
                        color: Colors.black,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.bold,
                      )),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text("-> Organizing and planning",
                      style: TextStyle(
                        fontSize: 20.sp,
                        color: Colors.black,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.bold,
                      )),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text("-> Having trouble finding the right words",
                      style: TextStyle(
                        fontSize: 20.sp,
                        color: Colors.black,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            SizedBox(
              width: 70.w,
              child: Text(
                "We suggest contacting your Momento Specialist for further information.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15.sp,
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
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                  text: "Continue",
                )),
            SizedBox(
              height: 3.h,
            ),
            SizedBox(
              width: 80.w,
              child: Text(
                  "This tool does not provide medical advice It is intended for informational purposes only. It is not a substitute for professional medical advice, diagnosis or treatment.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10.sp,
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
