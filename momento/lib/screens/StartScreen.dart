import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:momento/screens/HomeScreen.dart';
import 'package:momento/screens/daily_trivia/DailytriviaIntro.dart';
import 'package:momento/widgets/buttons/loginButton.dart';
import 'package:momento/widgets/buttons/signUpButton.dart';
import 'package:momento/constants.dart';
import 'package:sizer/sizer.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  Future<bool> getUserLastDailyTrivia() async {
    User user = FirebaseAuth.instance.currentUser!;
    String lastDailyTrivia = await FirebaseFirestore.instance
        .collection('Users')
        .doc(user.uid)
        .get()
        .then((value) => value.get('lastDailyTriviaDone'));
        // print(lastDailyTrivia);
    DateTime parsedDate = DateTime.parse(lastDailyTrivia);

    String now =
        "${DateTime.now().year}${DateTime.now().month < 10 ? ('0' + DateTime.now().month.toString()) : DateTime.now().month}${DateTime.now().day < 10 ? ('0' + DateTime.now().day.toString()) : DateTime.now().day}";
    // print(now);
    DateTime nowDate = DateTime.parse(now);
    // print(parsedDate);
    // print(nowDate);
    if (parsedDate.isBefore(nowDate)) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            return Sizer(builder: (context, orientation, deviceType) {
              getUserLastDailyTrivia().then((value) {
                if (value) {
                  // print("Pushing to daily trivia");
                  // return DailyTriviaIntro();
                  Navigator.popUntil(context, (route) => route.isFirst);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DailyTriviaIntro()));
                }
              });
              return HomeScreen();
            });
          }
          return Sizer(builder: (context, orientation, deviceType) {
            return Scaffold(
              backgroundColor: brown2,
              body: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Center(
                      child: SizedBox(
                          width: 85.w,
                          child: Image.asset('assets/images/logo.jpeg'))),
                  Container(
                    margin: EdgeInsets.only(bottom: 3.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          child: LoginButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/login');
                            },
                          ),
                          width: 45.w,
                        ),
                        SizedBox(
                            width: 45.w,
                            child: SignUpButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/singup');
                              },
                            )),
                      ],
                    ),
                  )
                ],
              ),
            );
          });
        }
        return Scaffold(
            body: Center(
          child: CircularProgressIndicator(),
        ));
      },
    );
  }
}
