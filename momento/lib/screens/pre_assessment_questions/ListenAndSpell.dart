// import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:momento/constants.dart';
import 'package:momento/screens/pre_assessment_questions/VideoObjects.dart';
import 'package:momento/widgets/buttons/loginButton.dart';
import 'package:momento/widgets/buttons/textField.dart';
import 'package:sizer/sizer.dart';

class ListenAndSpell extends StatelessWidget {
  AudioPlayer audioPlayer = AudioPlayer();
  Map<String, dynamic> data;
  String word = "";
  ListenAndSpell({required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leadingWidth: 25.w,
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
      ),
      body: Column(
        children: [
          Container(
            margin:
                EdgeInsets.only(top: 5.h, left: 10.w, right: 10.w, bottom: 2.h),
            child: Text(
              "Listen & Spell the Word Backwards",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.sp,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            decoration: BoxDecoration(
              color: lightBrown,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3))
              ],
            ),
            child: Container(
              margin: EdgeInsets.all(10.w),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Opacity(
                    opacity: 0.5,
                    child: Icon(
                      Icons.graphic_eq,
                      color: lightBrownButtonOutline,
                      size: 30.h,
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: IconButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(EdgeInsets.zero),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.transparent),
                          shape: MaterialStateProperty.all(
                            const CircleBorder(),
                          ),
                          side: MaterialStateProperty.all(
                            const BorderSide(
                              color: Colors.white,
                              width: 3,
                            ),
                          ),
                        ),
                        onPressed: () async {
                          // await audioPlayer.play(AssetSource("audio/momento.mp3"));
                          await audioPlayer
                              .setAsset("assets/audio/momento.mp3");
                          await audioPlayer.play();
                        },
                        icon: Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 20.h,
                        )),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 10.w),
              child: MomentotextField(
                onSaved: (value) {
                  word = value;
                },
                inputText: "Enter the word",
              )),
          SizedBox(
            height: 2.h,
          ),
          SizedBox(
            width: 80.w,
            child: LoginButton(
              onPressed: () {
                data["listenAndSpell"] = {
                  "word": word,
                  "isCorrect": word.toLowerCase() == "momento"
                };
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => VideoScreen(
                            data: data,
                          )),
                );
              },
              text: "Continue",
            ),
          ),
        ],
      ),
    );
  }
}
