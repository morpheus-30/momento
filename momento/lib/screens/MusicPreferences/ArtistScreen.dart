import 'package:flutter/material.dart';
import 'package:momento/constants.dart';
import 'package:momento/widgets/buttons/loginButton.dart';
import 'package:sizer/sizer.dart';

class ArtistScreen extends StatelessWidget {
  const ArtistScreen({super.key});

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
        leadingWidth: 30.w,
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 2.h,
            ),
            SizedBox(
              width: 90.w,
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.search),
                  ),
                  border: OutlineInputBorder(),
                  labelText: 'Search for a Artist',
                ),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Image(
              image: AssetImage('assets/images/artist.jpg'),
            ),
            SizedBox(
              height: 1.h,
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                children: [
                    ...["Elvis Presly", "The Beatles", "Dolly Parton","Neffex", "Taylor Swift", "Beyonce", "Ed Sheeran", "Adele", "Justin Bieber", "Rihanna", "Kanye West", "Bruno Mars", "Lady Gaga", "Drake", "Eminem", "Katy Perry", "Coldplay", "Maroon 5", "Ariana Grande", "Post Malone"]
                      .map((e) => Container(
                        margin: EdgeInsets.symmetric(vertical: 1.h),
                        child: LoginButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, '/Music Preferences');
                          },
                          text: e,
                        ),
                      ))
                      .toList(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
