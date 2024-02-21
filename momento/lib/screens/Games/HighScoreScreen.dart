import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:momento/constants.dart';
import 'package:momento/widgets/buttons/loginButton.dart';
import 'package:sizer/sizer.dart';

class HighScoreScreen extends StatefulWidget {
  @override
  State<HighScoreScreen> createState() => _HighScoreScreenState();
}

class _HighScoreScreenState extends State<HighScoreScreen> {
  int patternGameScore = -1;

  int mysteryLyricsScore = -1;

  Future<void> getHighScores() async {
    patternGameScore = await FirebaseFirestore.instance
        .collection("Pattern")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) => value['HighScore']);
    mysteryLyricsScore = await FirebaseFirestore.instance
        .collection("MysteryLyrics")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) => value['HighScore']);
    setState(() {});
  }

  @override
  void initState() {
    getHighScores();
  }

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
          "High Scores",
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
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/home'));
              },
              icon: Icon(
                Icons.home,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 2.h),
                  Text(
                    "High Scores",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Montserrat",
                    ),
                  ),
                  SizedBox(height: 4.h),
                  ScoreWidget(
                    gameName: "Pattern Game",
                    score: patternGameScore,
                    color: Colors.red[900]!,
                  ),
                  SizedBox(height: 2.h),
                  ScoreWidget(
                    gameName: "Mystery Lyrics",
                    score: mysteryLyricsScore,
                    color: Colors.green[900]!,
                  ),
                  SizedBox(height: 2.h),
                ],
              ),
              SizedBox(
                width: 90.w,
                child: LoginButton(
                  onPressed: () {
                    dynamic alert = AlertDialog(
                      title: Text(
                        "Choose a game to view your progression",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Montserrat",
                        ),
                      ),
                      content: SizedBox(
                        width: 80.w,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            LoginButton(
                              color: Colors.red[900]!,
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pushNamed(context, '/Progression');
                              },
                              text: "Pattern Game",
                            ),
                            SizedBox(height: 2.h),
                            LoginButton(
                              color: Colors.green[900]!,
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pushNamed(context, '/Progression');
                              },
                              text: "Mystery Lyrics",
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontFamily: "Montserrat",
                            ),
                          ),
                        ),
                      ],
                    );
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return alert;
                      },
                    );
                  },
                  text: "Progression",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ScoreWidget extends StatelessWidget {
  String gameName;
  int score;
  Color color = Colors.red[900]!;
  ScoreWidget(
      {required this.gameName, required this.score, required this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            gameName,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
              fontFamily: "Montserrat",
            ),
          ),
          SizedBox(height: 1.h),
          Container(
            padding: EdgeInsets.all(10),
            width: 90.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: color,
              border: Border.all(
                color: Colors.black,
                width: 1,
                style: BorderStyle.solid,
              ),
            ),
            child: Text(
              "Score: ${score.toString()}",
              style: TextStyle(
                fontSize: 15.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: "Montserrat",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
