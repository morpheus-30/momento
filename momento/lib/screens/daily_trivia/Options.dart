import 'package:flutter/material.dart';
import 'package:momento/constants.dart';
import 'package:momento/screens/daily_trivia/NameOfStreet.dart';
import 'package:momento/widgets/buttons/loginButton.dart';
import 'package:sizer/sizer.dart';

class OptionsScreenDailyTrivia extends StatelessWidget {
  const OptionsScreenDailyTrivia({super.key});

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
          children: [
            Text(
              "What is the current season?",
              style: TextStyle(
                fontSize: 20.sp,
                color: Colors.black,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Image(
              image: AssetImage("assets/images/season.jpg"),
            ),
            SizedBox(
              height: 5.h,
            ),
            ...["Spring", "Summer", "Autumn", "Winter"]
                .map((e) => SizedBox(
                      width: 80.w,  
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 1.h), 
                        child: LoginButton(
                          text: e,
                          onPressed: () {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NameOfStreet() ));
                          },
                        ),
                      ),
                    ))
                .toList(),
          ],
        ),
      ),
    );
  }
}
