import 'package:flutter/material.dart';
import 'package:momento/constants.dart';
import 'package:momento/widgets/buttons/loginButton.dart';
import 'package:sizer/sizer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ChooseResourcesScreen extends StatefulWidget {
  const ChooseResourcesScreen({super.key});

  @override
  State<ChooseResourcesScreen> createState() => _ChooseResourcesScreenState();
}

class _ChooseResourcesScreenState extends State<ChooseResourcesScreen> {
  final YoutubePlayerController _controller1 = YoutubePlayerController(
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
  final YoutubePlayerController _controller2 = YoutubePlayerController(
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
        elevation: 0,
        leadingWidth: 30.w,
        centerTitle: true,
        title: Text(
          "Resources",
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
                Navigator.pushNamed(context, '/home');
              },
              icon: Icon(
                Icons.home,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Resources",
              style: TextStyle(
                fontSize: 22.sp,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.bold,
              ),
            ),
            VideoWidget(
              controller: _controller1,
            ),
            VideoWidget(
              controller: _controller2,
            ),
            SizedBox(height: 5.h,),
            SizedBox(
              width: 80.w,
                child: LoginButton(
              onPressed: () {},
              text: "Contact your Physician",
            ))
          ],
        ),
      ),
    );
  }
}

class VideoWidget extends StatelessWidget {
  const VideoWidget({
    super.key,
    required YoutubePlayerController controller,
  }) : _controller = controller;

  final YoutubePlayerController _controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(0.h),
      margin: EdgeInsets.only(right: 5.w, left: 5.w, top: 2.h, bottom: 2.h),
      height: 20.h,
      width: 80.w,
      decoration: BoxDecoration(
        border: Border.all(
          color: brown2,
          width: 3,
        ),
      ),
      child: YoutubePlayer(
        bottomActions: [
          PlayPauseButton(),
          CurrentPosition(),
          ProgressBar(isExpanded: true),
          RemainingDuration(),
        ],
        controller: _controller,
      ),
    );
  }
}
