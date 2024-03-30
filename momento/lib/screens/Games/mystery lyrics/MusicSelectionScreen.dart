// import 'package:audioplayers/audioplayers.dart
import 'package:flutter/material.dart';
import 'package:momento/constants.dart';
import 'package:momento/screens/Games/mystery%20lyrics/MusicPlayingScreenBlank.dart';
import 'package:momento/screens/Games/mystery%20lyrics/MusicPlayingScreenHard.dart';
import 'package:momento/widgets/buttons/loginButton.dart';
import 'package:sizer/sizer.dart';
import 'package:spotify/spotify.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class MusicSelectionScreen extends StatefulWidget {
  String level;
  MusicSelectionScreen({required this.level});

  @override
  State<MusicSelectionScreen> createState() => _MusicSelectionScreenState();
}

class _MusicSelectionScreenState extends State<MusicSelectionScreen> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/mysteryLyricsHelp');
            },
            icon: Icon(
              Icons.question_mark,
              color: Colors.white,
            ),
          ),
        ],
        elevation: 0,
        leadingWidth: 30.w,
        centerTitle: true,
        title: Text(
          "Mystery Lyrics",
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
        child: Column(
          children: [
            SizedBox(height: 5.h),
            Text("Level: Easy",
                style: TextStyle(
                  fontSize: 15.sp,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                )),
            SizedBox(height: 3.h),
            Text("My Heart Will Go On",
                style: TextStyle(
                  fontSize: 25.sp,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                )),
            SizedBox(height: 3.h),
            Text("By Celine Dion",
                style: TextStyle(
                  fontSize: 15.sp,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                )),
            SizedBox(height: 7.h),
            Container(
              padding: EdgeInsets.all(30.w),
              margin: EdgeInsets.only(right: 5.w, left: 5.w),
              height: 40.h,
              width: 100.w,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/Celine_dion.jpg'),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: brown2,
                  width: 2,
                ),
              ),
              child: LoginButton(
                onPressed: () {
                  Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => widget.level == "hard"
                                  ? MusicPlayingScreenHard()
                                  : MusicPlayingScreen(
                                      level: widget.level,
                                    )));
                },
                text: "Play",
              ),
            ),
            SizedBox(height: 6.h),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: brown2,
                borderRadius: BorderRadius.circular(100),
              ),
              child: IconButton(
                onPressed: () {},
                iconSize: 35.sp,
                icon: Icon(
                  Icons.shuffle,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
