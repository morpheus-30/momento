import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:momento/constants.dart';
import 'package:sizer/sizer.dart';
import 'package:spotify/spotify.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class MusicPlayingScreen extends StatefulWidget {
  const MusicPlayingScreen({super.key});

  @override
  State<MusicPlayingScreen> createState() => _MusicPlayingScreenState();
}

class _MusicPlayingScreenState extends State<MusicPlayingScreen> {

  String artistName = "Neffex";
  String songName = "Fight Back";
  String musicTrackId = "6KigD0mlF4VGDYiSEzAyYw?si=5c5d12d7ed424cdf";
  Duration? duration ;
  
  final player = AudioPlayer(); 

  @override
  void initState() {
    final credentials = SpotifyApiCredentials(
        CustomStrings.clientId, CustomStrings.clientSecret);
    final spotifyApi = SpotifyApi(credentials);
    spotifyApi.tracks.get(musicTrackId).then((track) async {
      String? songName = track.name;
      if (songName != null) {
        final yt = YoutubeExplode();
        final video = (await yt.search.search(songName)).first;
        final videoID = video.id.value;
        duration = video.duration;
        setState(() {});
        var manifest = await yt.videos.streamsClient.getManifest(videoID);
        var audioUrl = manifest.audioOnly.first.url;
        print(audioUrl);
        // player.play(UrlSource(audioUrl.toString()));
      }
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                  onPressed: () {
                    player.pause();
                    print("Play");
                  },
                ),
                Text(
                  "  Song Name",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: 55.h,
            margin: EdgeInsets.only(top: 5.h, left: 5.w, right: 5.w),
            child: Text(
              """
[Verse 2]
Love can touch us one time 

And last for a lifetime

And never let go 'til we're gone

-----------------""",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.sp,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
          ColouredBgIconButton(
            onPressed: () {
              player.resume();
            },
            icon: Icons.mic_none_outlined,
            boundaryColor: Colors.black,
            bgColor: Color(0xFFCCCCCC),
            iconSize: 60.sp,
            iconColor: Colors.black,
          )
        ],
      ),
    );
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
      required this.iconSize 
      });

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
