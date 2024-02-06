import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:momento/constants.dart';
import 'package:momento/screens/pre_assessment_questions/MathScreen.dart';
import 'package:momento/widgets/buttons/loginButton.dart';
import 'package:momento/widgets/buttons/textField.dart';
import 'package:sizer/sizer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoScreen extends StatelessWidget {
  Map<String, dynamic> data;
  VideoScreen({required this.data});
  final YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: 'WlHYWYBbJ0U',
    flags: const YoutubePlayerFlags(
      hideControls: false,
      disableDragSeek: true,
      autoPlay: false,
      loop: true,
      showLiveFullscreenButton: false,
      mute: false,
    ),
  );

  @override
  Widget build(BuildContext context) {
    List<String> objects;
    String word1 = "";
    String word2 = "";
    String word3 = "";
    String word4 = "";
    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leadingWidth: 25.w,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/Help');
                },
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
        ),
        body: Center(
          child: Container(
            margin: EdgeInsets.only(top: 1.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(
                    right: 5.w,
                    left: 5.w,
                  ),
                  child: Text("List 4 Objects from the video",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17.sp,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.bold,
                      )),
                ),
                Container(
                  padding: EdgeInsets.all(0.h),
                  margin: EdgeInsets.only(
                      right: 5.w, left: 5.w, top: 2.h, bottom: 2.h),
                  height: 20.h,
                  width: 80.w,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: brown2,
                      width: 3,
                    ),
                  ),
                  // child: Container(
                  //   color: Colors.black.withOpacity(0.5),
                  //   child: Container(
                  //     margin: EdgeInsets.all(6.h),
                  //     decoration: BoxDecoration(
                  //       color: brown2.withOpacity(0.5),
                  //       // borderRadius: BorderRadius.circular(10),
                  //       border: Border.all(
                  //         color: Colors.white,
                  //         width: 2,
                  //       ),
                  //       shape: BoxShape.circle,
                  //     ),
                  //     child: IconButton(
                  //       iconSize: 5.h,
                  //       style: ButtonStyle(
                  //         shape:
                  //             MaterialStateProperty.all<RoundedRectangleBorder>(
                  //           RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(10.0),
                  //           ),
                  //         ),
                  //         side: MaterialStateProperty.all<BorderSide>(
                  //           BorderSide(
                  //             color: brown2,
                  //             width: 2,
                  //           ),
                  //         ),
                  //         backgroundColor:
                  //             MaterialStateProperty.all<Color>(brown2),
                  //         shadowColor: MaterialStateProperty.all<Color>(brown2),
                  //       ),
                  //       onPressed: () {
                  //         print("play video");
                  //       },
                  //       icon: Icon(
                  //         Icons.play_arrow,
                  //         color: Colors.white,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  child: YoutubePlayer(
                    bottomActions: [
                      PlayPauseButton(),
                      CurrentPosition(),
                      ProgressBar(isExpanded: true),
                      RemainingDuration(),
                    ],
                    controller: _controller,
                  ),
                ),
                SizedBox(
                  width: 80.w,
                  child: Column(
                    children: [
                      MomentotextField(
                          inputText: "Object #1",
                          onSaved: (value) {
                            word1 = value;
                          }),
                      SizedBox(height: 1.h),
                      MomentotextField(
                          inputText: "Object #2",
                          onSaved: (value) {
                            word2 = value;
                          }),
                      SizedBox(height: 1.h),
                      MomentotextField(
                        inputText: "Object #3",
                        onSaved: (value) {
                          word3 = value;
                        },
                      ),
                      SizedBox(height: 1.h),
                      MomentotextField(
                        inputText: "Object #4",
                        onSaved: (value) {
                          word4 = value;
                        },
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                SizedBox(
                  width: 80.w,
                  child: LoginButton(
                    onPressed: () {
                      objects = [word1, word2, word3, word4];
                      data["4Objects"] = objects;
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MathScreen(
                                data: data,
                              )));
                    },
                    text: "Continue",
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
