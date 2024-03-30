import 'package:flutter/material.dart';
import 'package:momento/constants.dart';
import 'package:momento/widgets/buttons/loginButton.dart';
import 'package:sizer/sizer.dart';

class DecadeScreen extends StatefulWidget {
  @override
  State<DecadeScreen> createState() => _DecadeScreenState();
}

class _DecadeScreenState extends State<DecadeScreen> {
  List<String> selectedDecades = [];

  List<String> decades = [
    "1920s",
    "1930s",
    "1940s",
    "1950s",
    "1960s",
    "1970s",
    "1980s",
    "1990s",
    "2000s",
    "2010s",
    "2020s",
  ];

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
              height: 3.h,
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
                  labelText: 'Search for a decade',
                ),
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            Image(
              image: AssetImage('assets/images/decade.jpg'),
            ),
            SizedBox(
              height: 3.h,
            ),
            Expanded(
              child: SizedBox(
                width: 90.w,
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    ListView.builder(
                      padding: EdgeInsets.only(bottom: 5.h),

                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: decades.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            SizedBox(
                              height: 2.h,
                            ),
                            SizedBox(
                              width: 100.w,
                              child: LoginButton(
                                onPressed: () {
                                  if (selectedDecades.contains(decades[index])) {
                                    setState(() {
                                      selectedDecades.remove(decades[index]);
                                    });
                                  } else {
                                    setState(() {
                                      selectedDecades.add(decades[index]);
                                    });
                                  }
                                },
                                text: decades[index],
                                color: selectedDecades.contains(decades[index])
                                    ? brown2
                                    : Colors.grey,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
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
