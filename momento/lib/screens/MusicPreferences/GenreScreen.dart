import 'package:flutter/material.dart';
import 'package:momento/constants.dart';
import 'package:momento/widgets/buttons/loginButton.dart';
import 'package:sizer/sizer.dart';

class GenreScreen extends StatefulWidget {
  const GenreScreen({super.key});

  @override
  State<GenreScreen> createState() => _GenreScreenState();
}

class _GenreScreenState extends State<GenreScreen> {

  List<String> selectedGenres = [];

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
        // leadingWidth: 30.w,
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
                  labelText: 'Search for a Genre',
                ),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Image(
              image: AssetImage('assets/images/decade.jpg'),
            ),
            SizedBox(
              height: 1.h,
            ),
            Expanded(
              child: SizedBox(
                width: 90.w,
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    ...["Rock", "Pop", "Hip Hop", "Jazz", "Classical", "Country", "R&B", "Electronic", "Folk", "Reggae", "Blues", "Metal", "Punk", "Soul", "Funk", "Disco", "Techno", "House", "Dance", "Indie", "Alternative", "Gospel", "Latin", "K-Pop", "Instrumental", "Ambient", "New Age", "Soundtrack", "World", "Experimental", "Comedy", "Children's", "Audiobook", "Holiday", "Other"].map((e) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 1.h),
                        child: LoginButton(
                          onPressed: () {
                            if (selectedGenres.contains(e)) {
                             setState(() {
                               selectedGenres.remove(e);
                             });
                            } else {
                              setState(() {
                                selectedGenres.add(e);
                              });
                            }
                          },
                          color: selectedGenres.contains(e) ? brown2 : Colors.grey,
                          text: e,
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
