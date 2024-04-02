// import 'package:audioplayers/audioplayers.dart
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:momento/constants.dart';
import 'package:momento/screens/Games/mystery%20lyrics/MusicPlayingScreenBlank.dart';
import 'package:momento/screens/Games/mystery%20lyrics/MusicPlayingScreenHard.dart';
import 'package:momento/screens/Games/mystery%20lyrics/songData.dart';
import 'package:momento/widgets/buttons/loginButton.dart';
import 'package:sizer/sizer.dart';
import 'package:spotify/spotify.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}

class MusicSelectionScreen extends StatefulWidget {
  String level;
  MusicSelectionScreen({required this.level});

  @override
  State<MusicSelectionScreen> createState() => _MusicSelectionScreenState();
}

class _MusicSelectionScreenState extends State<MusicSelectionScreen> {
  String? songName = "Fetching..";
  String? artist = "Fetching..";
  String? imageUrl = "";
  late String trackid;

  @override
  void initState() {
    final credentials = SpotifyApiCredentials(
        CustomStrings.clientId, CustomStrings.clientSecret);
    final spotifyApi = SpotifyApi(credentials);
    String randomGenre = genreData[Random().nextInt(genreData.length)];
    String? randomTrackId = songData[randomGenre]![Random().nextInt(songData[randomGenre]!.length)][
        "trackid"];
    trackid = randomTrackId?.toString() ?? "";
    spotifyApi.tracks.get(trackid).then((value) {
      songName = value.name;
      artist = value.artists![0].name;
      imageUrl = value.album!.images![0].url;
      print(value.album!.images![0].url);
      setState(() {});
    });
  }

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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 5.h),
              Text("Level: ${widget.level.capitalize()}",
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  )),
              SizedBox(height: 3.h),
              Text(songName!.capitalize(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  )),
              SizedBox(height: 3.h),
              Text("By ${artist!.capitalize()}",
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
                      image: imageUrl == ""
                          ? AssetImage("assets/images/blank.jpg")
                              as ImageProvider
                          : NetworkImage(imageUrl!),
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
                                ? MusicPlayingScreenHard(
                                    trackid: trackid,
                                  )
                                : MusicPlayingScreen(
                                    trackid: trackid,
                                    level: widget.level,
                                  )));
                  },
                  text: "Play",
                ),
              ),
              SizedBox(height: 6.h),
              Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: brown2,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MusicSelectionScreen(
                                  level: widget.level,
                                )));
                  },
                  iconSize: 15.sp,
                  icon: Icon(
                    Icons.shuffle,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
