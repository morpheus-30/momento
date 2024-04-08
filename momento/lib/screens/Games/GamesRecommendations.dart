import 'package:flutter/material.dart';
import 'package:momento/constants.dart';
import 'package:momento/screens/Games/mystery%20lyrics/DifficultyScreen.dart';
import 'package:momento/screens/Games/mystery%20lyrics/MusicSelectionScreen.dart';
import 'package:momento/screens/Games/pattern/PatternLevel.dart';
import 'package:momento/widgets/buttons/loginButton.dart';
import 'package:sizer/sizer.dart';

class GamesRecommendationScreen extends StatelessWidget {
  const GamesRecommendationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/Help');
            },
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
          "Select Game",
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
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                SizedBox(
                  width: 90.w,
                  child: Text("Game\nRecommendations",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25  .sp,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.bold,
                      )),
                ),
                SizedBox(height: 20.h),
                SizedBox(
                  width: 80.w,
                  child: LoginButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MysteryDifficultyScreen()));
                      },
                      text: "Mystery Lyrics"),
                ),
                SizedBox(
                  height: 3.h,
                ),
                SizedBox(
                  width: 80.w,
                  child: LoginButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PatternLevelScreen()));
                      },
                      text: "Pattern Matching"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
