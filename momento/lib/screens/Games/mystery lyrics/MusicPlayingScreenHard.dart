import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:string_similarity/string_similarity.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';
import 'package:momento/constants.dart';
import 'package:momento/screens/Games/mystery%20lyrics/models/lyricModel.dart';
import 'package:momento/screens/Games/mystery%20lyrics/models/musicModel.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:sizer/sizer.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:spotify/spotify.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class MusicPlayingScreenHard extends StatefulWidget {

  // String level;
  // MusicPlayingScreenHard({required this.level});

  // const MusicPlayingScreenHard({super.key});

  @override
  State<MusicPlayingScreenHard> createState() => _MusicPlayingScreenHardState();
}

class _MusicPlayingScreenHardState extends State<MusicPlayingScreenHard> {
  Duration? duration;
  Music music = Music(
    trackId: "7F1yVPuJ4xRdrDvf8OL0HF",
  );
  bool hasBeenStarted = false;
  List<Lyric>? lyrics = [];
  double Score = 0;
  final itemScrollController = ItemScrollController();
  final itemPositionsListener = ItemPositionsListener.create();
  final scrollOffsetController = ScrollOffsetController();
  final scrollOffsetListener = ScrollOffsetListener.create();
  final player = AudioPlayer();
  Uri? audioUrl;
  bool loading = false;
  bool isRecording = false;

  final SpeechToText _speechToText = SpeechToText();
  bool _speechEabled = false;
  String _wordsSpoken = "";

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  void initSpeech() async {
    _speechEabled = await _speechToText.initialize();
    setState(() {});
  }

  @override
  void initState() {
    setState(() {
      loading = true;
    });
    initSpeech();

    final credentials = SpotifyApiCredentials(
        CustomStrings.clientId, CustomStrings.clientSecret);
    final spotifyApi = SpotifyApi(credentials);
    spotifyApi.tracks.get(music.trackId).then((track) async {
      music.songName = track.name;
      music.artistName = track.artists?.first.name;
      if (music.songName != null) {
        final yt = YoutubeExplode();
        final video = (await yt.search
                .search(music.songName! + " " + music.artistName! + " lyrics"))
            .first;
        final videoID = video.id.value;
        music.duration = video.duration;
        setState(() {});
        var manifest = await yt.videos.streamsClient.getManifest(videoID);
        audioUrl = manifest.audioOnly.first.url;
        // print(audioUrl);
        // await player.setSource(UrlSource(audioUrl.toString()));
        await player.setUrl(audioUrl.toString());
        // print(music.songName!+" "+music.artistName!);
        String manipulatedName = music.songName! + music.artistName!;
        manipulatedName = manipulatedName.replaceAll(" ", "");
        // print(manipulatedName);
        get(Uri.parse(
                "https://paxsenixofc.my.id/server/getLyricsMusix.php?q=${manipulatedName}&type=default"))
            .then((response) {
          String data = response.body;
          // print(data);
          if (data == "") {
            lyrics = [Lyric(words: "No lyrics found", time: DateTime.now())];
            // print("No lyrics found");
            setState(() {});
          } else {
            lyrics = data
                .split('\n')
                .map((e) => Lyric(
                    words: e.split(']').sublist(1).join(' '),
                    time: DateFormat("[mm:ss.SS]").parse(e.split(' ')[0])))
                .toList();
            setState(() {});
          }
        });
        setState(() {
          loading = false;
        });
      }
    });
    String currentSecond = "";
    player.positionStream.listen((duration) {
      if (duration.inSeconds > 45) {
        player.stop();
       int tempScore = ((Score / (500)) * 100).round();
        int finalScore = Score.toInt();
        int numberOfStars = tempScore > 80
            ? 3
            : tempScore > 60
                ? 2
                : tempScore > 40
                    ? 1
                    : 0;

        dynamic alert2 = AlertDialog(
          title: const Text(
            "Score",
            textAlign: TextAlign.center,
          ),
          titleTextStyle: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            fontFamily: "Montserrat",
            color: Colors.black,
          ),
          contentTextStyle: TextStyle(
            fontSize: 70.sp,
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: "Montserrat",
          ),
          content: SizedBox(
            height: 30.h,
            child: Column(
              children: [
                Text(
                  finalScore.toString(),
                  textAlign: TextAlign.center,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.star,
                      size: 40.sp,
                      color: numberOfStars > 0 ? Colors.yellow : Colors.grey,
                    ),
                    Icon(
                      Icons.star,
                      size: 40.sp,
                      color: numberOfStars > 1 ? Colors.yellow : Colors.grey,
                    ),
                    Icon(
                      Icons.star,
                      size: 40.sp,
                      color: numberOfStars > 2 ? Colors.yellow : Colors.grey,
                    ),
                  ],
                ),
                SizedBox(
                  height: 3.h,
                ),
                SizedBox(
                  height: 5.h,
                  width: 80.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        alignment: Alignment.center,
                        onPressed: () async {
                          setState(() {
                            hasBeenStarted = false;
                            Score = 0;
                          });
                          player.stop();
                          player.seek(Duration.zero);
                          Navigator.pop(context);
                        },
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          Icons.loop,
                          size: 40.sp,
                        ),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      IconButton(
                        alignment: Alignment.center,
                        padding: EdgeInsets.zero,
                        onPressed: () async {
                          player.dispose();
                          await FirebaseFirestore.instance
                              .collection('MysteryLyrics')
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .collection('Scores')
                              .doc(DateTime.now().toString())
                              .set({
                            'score': finalScore,
                          });
                          // dynamic oldScores = await FirebaseFirestore
                          //     .instance
                          //     .collection('MysteryLyrics')
                          //     .doc(FirebaseAuth
                          //         .instance.currentUser!.uid)
                          //     .collection('Scores')
                          //     .get();
                          dynamic highScore;
                          await FirebaseFirestore.instance
                              .collection('MysteryLyrics')
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .get()
                              .then((value) {
                            highScore = value.data()!['HighScore'];
                          });
                          if (Score.toInt() > highScore) {
                            await FirebaseFirestore.instance
                                .collection('MysteryLyrics')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .update({
                              'HighScore': Score.toInt(),
                            });
                          }
                          // print("HighScore updated");
                          // oldScores.docs.forEach((element) {
                          //   print(element.data());
                          // });
                          Navigator.popUntil(context, (route) => route.isFirst);
                          Navigator.pushReplacementNamed(context, '/home');
                          Navigator.popUntil(context, (route) => route.isFirst);
                          Navigator.pushReplacementNamed(context, '/home');
                        },
                        icon: Icon(
                          Icons.exit_to_app,
                          size: 40.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert2;
          },
        );
      }
      // print(event);
      // print(lyrics!.length);
      // print(duration.inSeconds.remainder(60));
      DateTime dt = DateTime(1970, 1, 1).copyWith(
          hour: duration.inHours.remainder(60),
          minute: duration.inMinutes.remainder(60),
          second: duration.inSeconds.remainder(60),
          millisecond: duration.inMilliseconds.remainder(100));
      for (int i = 2; i < lyrics!.length; i++) {
        if (lyrics![i].time.isAfter(dt)) {
          itemScrollController.scrollTo(
              index: i - 2, duration: const Duration(milliseconds: 600));
          break;
        }
      }
      // print(lyrics![i].time);
      print(dt);
      for (int i = 0; i < lyrics!.length; i++) {
        if (lyrics![i].time.second == dt.second &&
            lyrics![i].time.minute == dt.minute &&
            lyrics![i].time.hour == dt.hour &&
            currentSecond !=
                dt.second.toString() +
                    dt.minute.toString() +
                    dt.hour.toString()) {
          player.pause();
          print("start recording");

          _startListening();
          Future.delayed(const Duration(seconds: 10), () async {
            if (i - 1 >= 0) {
              //  print("Score ${ lyrics![i - 1].words.similarityTo(_wordsSpoken) }");
              setState(() {
                Score += (lyrics![i - 1]
                        .words
                        .toLowerCase()
                        .similarityTo(_wordsSpoken.toLowerCase())) *
                    100;
                Score = Score.roundToDouble();
              });
            } else {
              setState(() {
                Score += 100;
              });
            }
            await player.seek(Duration(
                milliseconds: lyrics![i].time.millisecond +
                    lyrics![i].time.second * 1000 +
                    lyrics![i].time.minute * 60 * 1000 +
                    lyrics![i].time.hour * 60 * 60 * 1000));
            await player.play();
            // print("stop playing");
          });

          currentSecond =
              dt.second.toString() + dt.minute.toString() + dt.hour.toString();
          break;
        }
      }
    });

    super.initState();
  }

  void _onSpeechResult(result) {
    print(_speechToText.isListening);
    setState(() {
      _wordsSpoken = result.recognizedWords;
    });
  }

  void _startListening() async {
    setState(() {
      isRecording = true;
    });
    print(_speechToText.isListening);
    await _speechToText.listen(
      onResult: _onSpeechResult,
      listenFor: const Duration(seconds: 10),
      pauseFor: const Duration(seconds: 10),
    );
    setState(() {
      isRecording = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          body: !loading
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 6.h),
                      height: 20.h,
                      width: 100.w,
                      color: brown2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ColouredBgIconButton(
                            iconSize: 20.sp,
                            onPressed: () async {
                              if (_speechEabled && !hasBeenStarted) {
                                player.play();
                                hasBeenStarted = true;
                              } else if (!_speechEabled) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text("Speech to text not available"),
                                  ),
                                );
                              }
                              // if (player.playing) {
                              //   player.pause();
                              // } else {
                              //   player.play();
                              // }
                              // Duration lastDuration = Duration(seconds: 0);
                              // for (int i = 0; i < lyrics!.length; i++) {
                              //   // print(lyrics![i].time);
                              //   // print(lastDuration);
                              //   // await player.resume();
                              //   // await player.seek(lastDuration);
                              //   // await Future.delayed(Duration(
                              //   //   minutes: lyrics![i].time.minute-lastDuration.inMinutes.remainder(60),
                              //   //   seconds: lyrics![i].time.second-lastDuration.inSeconds.remainder(60),
                              //   //   milliseconds: lyrics![i].time.millisecond-lastDuration.inMilliseconds.remainder(1000),
                              //   // ), () async{
                              //   //   await player.pause();
                              //   //   print("start recording");
                              //   //   await Future.delayed(Duration(seconds: 2), () async{
                              //   //     lastDuration = await player.getCurrentPosition()??Duration(seconds: 0);
                              //   //   });
                              //   // });
                              //   await player.setClip(
                              //       start: lastDuration,
                              //       end: Duration(
                              //           minutes: lyrics![i].time.minute.remainder(60),
                              //           seconds: lyrics![i].time.second.remainder(60),
                              //           milliseconds:
                              //               lyrics![i].time.millisecond.remainder(1000)));
                              //   await player.play();
                              //   player.setClip();
                              //   // Future.delayed(Duration(
                              //   //   minutes: lyrics![i].time.minute-lastDuration.inMinutes.remainder(60),
                              //   //   seconds: lyrics![i].time.second-lastDuration.inSeconds.remainder(60),
                              //   //   milliseconds: lyrics![i].time.millisecond-lastDuration.inMilliseconds.remainder(1000),
                              //   // ), () async {
                              //   player.pause();
                              //   print("start recording");
                              //   lastDuration = Duration(
                              //       milliseconds: lyrics![i].time.millisecond +
                              //           lyrics![i].time.second * 1000 +
                              //           lyrics![i].time.minute * 60 * 1000 +
                              //           lyrics![i].time.hour * 60 * 60 * 1000);
                              //   // });
                              // }
                              // Duration lastDuration = Duration(
                              //     milliseconds: lyrics![0].time.millisecond +
                              //         lyrics![0].time.second * 1000 +
                              //         lyrics![0].time.minute * 60 * 1000 +
                              //         lyrics![0].time.hour * 60 * 60 * 1000);
                              // await player.setClip(
                              //     start: lastDuration,
                              //     end: Duration(
                              //         milliseconds: lyrics![0]
                              //                 .time
                              //                 .millisecond +
                              //             lyrics![1].time.second * 1000 +
                              //             lyrics![1].time.minute * 60 * 1000 +
                              //             lyrics![1].time.hour *
                              //                 60 *
                              //                 60 *
                              //                 1000));
                              // await player.play();
                              // Future.delayed(
                              //     Duration(
                              //       minutes: lyrics![1].time.minute -
                              //           lastDuration.inMinutes.remainder(60),
                              //       seconds: lyrics![1].time.second -
                              //           lastDuration.inSeconds.remainder(60),
                              //       milliseconds: lyrics![1].time.millisecond -
                              //           lastDuration
                              //               .inMilliseconds
                              //               .remainder(1000),
                              //     ), () async {
                              //   await player.pause();
                              //   // print("start recording");
                              //   // await Future.delayed(Duration(seconds: 2),
                              //   //     () async {
                              //   //   await player.setClip(
                              //   //       start: Duration(seconds: 40),
                              //   //       end: Duration(seconds: 50));
                              //   //   await player.play();
                              //   // });
                              // });
                            },
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          SizedBox(
                            width: 70.w,
                            child: Text(
                              (music.songName ?? "") +
                                  "\n" +
                                  (music.artistName ?? ""),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.sp,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    lyrics != null
                        ? Container(
                            margin: EdgeInsets.only(top: 3.h, bottom: 1.h),
                            width: 85.w,
                            height: 25.h,
                            child: StreamBuilder<Duration>(
                                stream: player.positionStream,
                                builder: (context, snapshot) {
                                  return ScrollablePositionedList.builder(
                                    itemCount: lyrics!.length,
                                    itemBuilder: (context, index) {
                                      Duration duration = snapshot.data ??
                                          const Duration(seconds: 0);
                                      DateTime dt = DateTime(1970, 1, 1)
                                          .copyWith(
                                              hour: duration.inHours,
                                              minute: duration.inMinutes
                                                  .remainder(60),
                                              second: duration.inSeconds
                                                  .remainder(60));
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 16.0),
                                        child: Text(
                                          lyrics![index].words,
                                          style: TextStyle(
                                            color:
                                                lyrics![index].time.isAfter(dt)
                                                    ? Colors.black
                                                    : brown2,
                                            fontSize:
                                                lyrics![index].time.isAfter(dt)
                                                    ? 20
                                                    : 26,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      );
                                    },
                                    itemScrollController: itemScrollController,
                                    scrollOffsetController:
                                        scrollOffsetController,
                                    itemPositionsListener:
                                        itemPositionsListener,
                                    scrollOffsetListener: scrollOffsetListener,
                                  );
                                }),
                          )
                        : const SizedBox(),
                    // SizedBox(height: 2.h,),
                    // ColouredBgIconButton(
                    //   onPressed: () {
                    //     // isRecording = !isRecording;
                    //     // _startListening();
                    //     // setState(() {});
                    //     // isRecording = !isRecording;
                    //   },
                    //   icon:
                    //       isRecording ? Icons.mic_none_outlined : Icons.mic_off,
                    //   boundaryColor: Colors.black,
                    //   bgColor: Color(0xFFCCCCCC),
                    //   iconSize: 60.sp,
                    //   iconColor: Colors.black,
                    // ),
                    Container(
                      width: 90.w,
                      margin:
                          EdgeInsets.only(bottom: 5.h, left: 5.w, right: 5.w),
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      decoration: BoxDecoration(
                        color: brown2,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        _speechToText.isListening
                            ? "Listening..."
                            : _speechEabled
                                ? "Please wait for your turn"
                                : "Speech not available",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                    Container(
                      width: 90.w,
                      margin:
                          EdgeInsets.only(bottom: 5.h, left: 5.w, right: 5.w),
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      decoration: BoxDecoration(
                        color: brown2,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Text("Score:",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.sp,
                                fontFamily: 'Montserrat',
                              )),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(Score.round().toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.sp,
                                fontFamily: 'Montserrat',
                              )),
                        ],
                      ),
                    ),
                    // Container(
                    //   margin:
                    //       EdgeInsets.only(bottom: 5.h, left: 5.w, right: 5.w),
                    //   child: Text(
                    //     _wordsSpoken,
                    //     style: TextStyle(
                    //       color: Colors.black,
                    //       fontSize: 20.sp,
                    //       fontFamily: 'Montserrat',
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      width: 3.w,
                      height: 3.h,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        int tempScore = ((Score / (500)) * 100).round();
                        int finalScore = Score.toInt();
                        int numberOfStars = tempScore > 80
                            ? 3
                            : tempScore > 60
                                ? 2
                                : tempScore > 40
                                    ? 1
                                    : 0;
                        dynamic alert = AlertDialog(
                          title: Text("Are you sure you want to exit?"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("No"),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                dynamic alert2 = AlertDialog(
                                  title: const Text(
                                    "Score",
                                    textAlign: TextAlign.center,
                                  ),
                                  titleTextStyle: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Montserrat",
                                    color: Colors.black,
                                  ),
                                  contentTextStyle: TextStyle(
                                    fontSize: 70.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Montserrat",
                                  ),
                                  content: SizedBox(
                                    height: 30.h,
                                    child: Column(
                                      children: [
                                        Text(
                                          finalScore.toString(),
                                          textAlign: TextAlign.center,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.star,
                                              size: 40.sp,
                                              color: numberOfStars > 0
                                                  ? Colors.yellow
                                                  : Colors.grey,
                                            ),
                                            Icon(
                                              Icons.star,
                                              size: 40.sp,
                                              color: numberOfStars > 1
                                                  ? Colors.yellow
                                                  : Colors.grey,
                                            ),
                                            Icon(
                                              Icons.star,
                                              size: 40.sp,
                                              color: numberOfStars > 2
                                                  ? Colors.yellow
                                                  : Colors.grey,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 3.h,
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                          width: 80.w,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              IconButton(
                                                alignment: Alignment.center,
                                                onPressed: () async {
                                                  setState(() {
                                                    hasBeenStarted = false;
                                                    Score = 0;
                                                  });
                                                  player.stop();
                                                  player.seek(Duration.zero);
                                                  Navigator.pop(context);
                                                },
                                                padding: EdgeInsets.zero,
                                                icon: Icon(
                                                  Icons.loop,
                                                  size: 40.sp,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5.w,
                                              ),
                                              IconButton(
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.zero,
                                                onPressed: () async {
                                                  player.dispose();
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection(
                                                          'MysteryLyrics')
                                                      .doc(FirebaseAuth.instance
                                                          .currentUser!.uid)
                                                      .collection('Scores')
                                                      .doc(DateTime.now()
                                                          .toString())
                                                      .set({
                                                    'score': finalScore,
                                                  });
                                                  // dynamic oldScores = await FirebaseFirestore
                                                  //     .instance
                                                  //     .collection('MysteryLyrics')
                                                  //     .doc(FirebaseAuth
                                                  //         .instance.currentUser!.uid)
                                                  //     .collection('Scores')
                                                  //     .get();
                                                  dynamic highScore;
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection(
                                                          'MysteryLyrics')
                                                      .doc(FirebaseAuth.instance
                                                          .currentUser!.uid)
                                                      .get()
                                                      .then((value) {
                                                    highScore = value
                                                        .data()!['HighScore'];
                                                  });
                                                  if (Score.toInt() >
                                                      highScore) {
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection(
                                                            'MysteryLyrics')
                                                        .doc(FirebaseAuth
                                                            .instance
                                                            .currentUser!
                                                            .uid)
                                                        .update({
                                                      'HighScore':
                                                          Score.toInt(),
                                                    });
                                                  }
                                                  // print("HighScore updated");
                                                  // oldScores.docs.forEach((element) {
                                                  //   print(element.data());
                                                  // });
                                                  Navigator.popUntil(context,
                                                      (route) => route.isFirst);
                                                  Navigator
                                                      .pushReplacementNamed(
                                                          context, '/home');
                                                  Navigator.popUntil(context,
                                                      (route) => route.isFirst);
                                                  Navigator
                                                      .pushReplacementNamed(
                                                          context, '/home');
                                                },
                                                icon: Icon(
                                                  Icons.exit_to_app,
                                                  size: 40.sp,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return alert2;
                                  },
                                );
                              },
                              child: Text("Yes"),
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
                      style: ElevatedButton.styleFrom(
                        backgroundColor: brown2,
                        minimumSize: Size(80.w, 8.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        "Exit",
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                     StreamBuilder<Duration>(
                        stream: player.positionStream,
                        builder: (context, snapshot) {
                          return CircularProgressIndicator(
                            
                            value: snapshot.data != null
                                ? snapshot.data!.inSeconds /
                                    45
                                : 0,
                            backgroundColor: Colors.white,
                            valueColor: AlwaysStoppedAnimation<Color>(brown2),
                          
                          );
                        }),
                        SizedBox(
                          height: 5.h,
                        ),
                  ],
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ),
        onWillPop: () {
        int tempScore = ((Score / (500)) * 100).round();
          int finalScore = Score.toInt();
          int numberOfStars = tempScore > 80
              ? 3
              : tempScore > 60
                  ? 2
                  : tempScore > 40
                      ? 1
                      : 0;
          dynamic alert = AlertDialog(
            title: Text("Are you sure you want to exit?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("No"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  dynamic alert2 = AlertDialog(
                    title: const Text(
                      "Score",
                      textAlign: TextAlign.center,
                    ),
                    titleTextStyle: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Montserrat",
                      color: Colors.black,
                    ),
                    contentTextStyle: TextStyle(
                      fontSize: 70.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Montserrat",
                    ),
                    content: SizedBox(
                      height: 30.h,
                      child: Column(
                        children: [
                          Text(
                            finalScore.toString(),
                            textAlign: TextAlign.center,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.star,
                                size: 40.sp,
                                color: numberOfStars > 0
                                    ? Colors.yellow
                                    : Colors.grey,
                              ),
                              Icon(
                                Icons.star,
                                size: 40.sp,
                                color: numberOfStars > 1
                                    ? Colors.yellow
                                    : Colors.grey,
                              ),
                              Icon(
                                Icons.star,
                                size: 40.sp,
                                color: numberOfStars > 2
                                    ? Colors.yellow
                                    : Colors.grey,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          SizedBox(
                            height: 5.h,
                            width: 80.w,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  alignment: Alignment.center,
                                  onPressed: () async {
                                    setState(() {
                                      hasBeenStarted = false;
                                      Score = 0;
                                    });
                                    player.stop();
                                    player.seek(Duration.zero);
                                    Navigator.pop(context);
                                  },
                                  padding: EdgeInsets.zero,
                                  icon: Icon(
                                    Icons.loop,
                                    size: 40.sp,
                                  ),
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                IconButton(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.zero,
                                  onPressed: () async {
                                    player.dispose();
                                    await FirebaseFirestore.instance
                                        .collection('MysteryLyrics')
                                        .doc(FirebaseAuth
                                            .instance.currentUser!.uid)
                                        .collection('Scores')
                                        .doc(DateTime.now().toString())
                                        .set({
                                      'score': finalScore,
                                    });
                                    // dynamic oldScores = await FirebaseFirestore
                                    //     .instance
                                    //     .collection('MysteryLyrics')
                                    //     .doc(FirebaseAuth
                                    //         .instance.currentUser!.uid)
                                    //     .collection('Scores')
                                    //     .get();
                                    dynamic highScore;
                                    await FirebaseFirestore.instance
                                        .collection('MysteryLyrics')
                                        .doc(FirebaseAuth
                                            .instance.currentUser!.uid)
                                        .get()
                                        .then((value) {
                                      highScore = value.data()!['HighScore'];
                                    });
                                    if (Score.toInt() > highScore) {
                                      await FirebaseFirestore.instance
                                          .collection('MysteryLyrics')
                                          .doc(FirebaseAuth
                                              .instance.currentUser!.uid)
                                          .update({
                                        'HighScore': Score.toInt(),
                                      });
                                    }
                                    // print("HighScore updated");
                                    // oldScores.docs.forEach((element) {
                                    //   print(element.data());
                                    // });
                                    Navigator.popUntil(
                                        context, (route) => route.isFirst);
                                    Navigator.pushReplacementNamed(
                                        context, '/home');
                                    Navigator.popUntil(
                                        context, (route) => route.isFirst);
                                    Navigator.pushReplacementNamed(
                                        context, '/home');
                                  },
                                  icon: Icon(
                                    Icons.exit_to_app,
                                    size: 40.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return alert2;
                    },
                  );
                },
                child: Text("Yes"),
              ),
            ],
          );
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return alert;
            },
          );
          return Future.value(true);
        });
  }
}

class ColouredBgIconButton extends StatelessWidget {
  Function onPressed;
  Color boundaryColor;
  Color bgColor;
  IconData icon;
  Color iconColor;
  double iconSize;
  ColouredBgIconButton(
      {required this.onPressed,
      this.boundaryColor = Colors.white,
      this.bgColor = brown2,
      this.iconColor = Colors.white,
      this.icon = Icons.play_arrow,
      required this.iconSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 5.w),
      decoration: BoxDecoration(
        color: bgColor.withOpacity(0.5),
        // borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: boundaryColor,
          width: 2,
        ),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<CircleBorder>(CircleBorder()),
          side: MaterialStateProperty.all<BorderSide>(
            BorderSide(
              color: boundaryColor,
              width: 3,
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(bgColor),
          shadowColor: MaterialStateProperty.all<Color>(bgColor),
        ),
        onPressed: () {
          onPressed();
        },
        iconSize: iconSize,
        icon: Icon(
          icon,
          color: iconColor,
        ),
      ),
    );
  }
}
