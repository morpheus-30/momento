import 'package:flutter/material.dart';
import 'package:momento/constants.dart';
import 'package:momento/screens/Games/mystery%20lyrics/MusicSelectionScreen.dart';
import 'package:momento/screens/Games/pattern/PatternGame.dart';
import 'package:sizer/sizer.dart';

class MysteryDifficultyScreen extends StatelessWidget {
  const MysteryDifficultyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/Help');
            },
            icon: const Icon(
              Icons.question_mark,
              color: Colors.white,
            ),
          ),
        ],
        elevation: 0,
        // leadingWidth: 30.w,
        centerTitle: true,
        title: const Text(
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
            // IconButton(
            //   onPressed: () {
            //     Navigator.popUntil(context, ModalRoute.withName('/home'));
            //   },
            //   icon: const Icon(
            //     Icons.home,
            //     color: Colors.white,
            //   ),
            // ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Difficulty Level",
                style: TextStyle(
                  fontSize: 30.sp,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                )),
            SizedBox(height: 5.h),
            Container(
              width: 100.w,
              height: 30.h,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/difficulty.jpg"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(height: 5.h),
            ...["Easy", "Medium", "Hard"].map((level) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 1.h),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              MusicSelectionScreen(level: level.toLowerCase())),
                    );
                  },
                  child: Text(
                    level,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: brown2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: Size(80.w, 8.h),
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
