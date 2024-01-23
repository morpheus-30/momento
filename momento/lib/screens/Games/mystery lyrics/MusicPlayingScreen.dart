import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:momento/constants.dart';
import 'package:momento/screens/Games/mystery%20lyrics/models/lyricModel.dart';
import 'package:momento/screens/Games/mystery%20lyrics/models/musicModel.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:sizer/sizer.dart';
import 'package:spotify/spotify.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class MusicPlayingScreen extends StatefulWidget {
  const MusicPlayingScreen({super.key});

  @override
  State<MusicPlayingScreen> createState() => _MusicPlayingScreenState();
}

class _MusicPlayingScreenState extends State<MusicPlayingScreen> {
  Duration? duration;
  Music music = Music(
    trackId: "0V02HHr8eM5O4yEx2ngYHI",
  );
  List<Lyric>? lyrics = [];
  final itemScrollController = ItemScrollController();
  final itemPositionsListener = ItemPositionsListener.create();
  final scrollOffsetController = ScrollOffsetController();
  final scrollOffsetListener = ScrollOffsetListener.create();
  final recorder = AudioRecorder();
  final player = AudioPlayer();
  Uri? audioUrl;
  bool loading = false;

  void checkPermission() async {
    bool? hasPermission = await recorder.hasPermission();
    if (hasPermission == false) {
      await Permission.microphone.request();
    }
  }

  void startRecording() async {
    if (await recorder.hasPermission()) {
      await recorder.start(const RecordConfig(),path: "/tmp/recorded.mp3");
    }else{
      openAppSettings();
    }
  }

  @override
  void initState() {
    setState(() {
      loading = true;
    });
    checkPermission();
    final credentials = SpotifyApiCredentials(
        CustomStrings.clientId, CustomStrings.clientSecret);
    final spotifyApi = SpotifyApi(credentials);
    spotifyApi.tracks.get(music.trackId).then((track) async {
      music.songName = track.name;
      music.artistName = track.artists?.first.name;
      if (music.songName != null) {
        final yt = YoutubeExplode();
        final video =
            (await yt.search.search(music.songName! + " " + music.artistName!))
                .first;
        final videoID = video.id.value;
        music.duration = video.duration;
        setState(() {});
        var manifest = await yt.videos.streamsClient.getManifest(videoID);
        audioUrl = manifest.audioOnly.first.url;
        // print(audioUrl);
        await player.setSource(UrlSource(audioUrl.toString()));

        get(Uri.parse(
                "https://paxsenixofc.my.id/server/getLyricsMusix.php?q=${music.songName} ${music.artistName}&type=default"))
            .then((response) {
          String data = response.body;
          print(data);
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
    player.onPositionChanged.listen((duration) {
      // print(event);
      // print(lyrics!.length);
      DateTime dt = DateTime(1970, 1, 1).copyWith(
          hour: duration.inHours,
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
      // print(dt.second);
      for (int i = 0; i < lyrics!.length; i++) {
        if (lyrics![i].time.second == dt.second &&
            lyrics![i].time.minute == dt.minute &&
            lyrics![i].time.hour == dt.hour &&
            currentSecond !=
                dt.second.toString() +
                    dt.minute.toString() +
                    dt.hour.toString()) {
          player.pause();
          // print("start recording");
          
          currentSecond =
              dt.second.toString() + dt.minute.toString() + dt.hour.toString();
          break;
        }
      }
    });
    player.onPlayerStateChanged.listen((event) {
      if (event == PlayerState.completed) {
        player.stop();
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          body: !loading
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 6.h),
                      height: 20.h,
                      width: 100.w,
                      color: brown2,
                      child: Row(
                        children: [
                          ColouredBgIconButton(
                            iconSize: 20.sp,
                            onPressed: () async {
                              setState(() {
                                loading = true;
                              });
                              player.resume();
                              setState(() {
                                loading = false;
                              });
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
                                stream: player.onPositionChanged,
                                builder: (context, snapshot) {
                                  print(snapshot.data);
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
                                            fontSize: 26,
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
                    ColouredBgIconButton(
                      onPressed: ()async {
                        if(await recorder.isRecording()){
                          recorder.pause();
                          print("pause recording");
                        }else if(await recorder.isPaused()){
                          recorder.resume();
                          print("resume recording");
                        }else{
                          print("start recording");
                          startRecording();
                        }
                      },
                      icon: Icons.mic_none_outlined,
                      boundaryColor: Colors.black,
                      bgColor: Color(0xFFCCCCCC),
                      iconSize: 30.sp,
                      iconColor: Colors.black,
                    )
                  ],
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ),
        onWillPop: () {
          player.stop();
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
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
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
