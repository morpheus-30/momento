import 'package:flutter/material.dart';
import 'package:momento/constants.dart';
import 'package:momento/screens/MusicPreferences/ArtistScreen.dart';
import 'package:momento/screens/MusicPreferences/DecadeScreen.dart';
import 'package:momento/screens/MusicPreferences/GenreScreen.dart';
import 'package:momento/widgets/buttons/loginButton.dart';
import 'package:sizer/sizer.dart';

class MusicPreferencesScreen extends StatelessWidget {
  const MusicPreferencesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
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
          leadingWidth: 25.w,
          centerTitle: true,
          title: Text(
            "Music Preferences",
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
        body: Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Music Preferences",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.bold,
                  fontSize: 40.sp,
                )),
            SizedBox(height: 5.h),
            Image(
              width: 100.w,
              image: AssetImage('assets/images/musicPref.png'),
            ),
            SizedBox(height: 5.h),
            SizedBox(
              width: 80.w,
              child: LoginButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => GenreScreen()));
                },
                text: "Genre",
              ),
            ),
            SizedBox(height: 2.h),
            SizedBox(
              width: 80.w,
              child: LoginButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ArtistScreen()));
                },
                text: "Artist",
              ),
            ),
            SizedBox(height: 2.h),
            SizedBox(
              width: 80.w,
              child: LoginButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DecadeScreen()));
                },
                text: "Decade",
              ),
            ),
          ],
        )));
  }
}
