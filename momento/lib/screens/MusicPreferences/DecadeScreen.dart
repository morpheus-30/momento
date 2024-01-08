import 'package:flutter/material.dart';
import 'package:momento/constants.dart';
import 'package:momento/widgets/buttons/loginButton.dart';
import 'package:sizer/sizer.dart';

class DecadeScreen extends StatelessWidget {
  const DecadeScreen({super.key});

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
                    SizedBox(
                      width: 80.w,
                      child: LoginButton(
                        onPressed: () {},
                        text: "1960s",
                      ),
                    ),
                    SizedBox(height: 2.h),
                    SizedBox(
                      width: 80.w,
                      child: LoginButton(
                        onPressed: () {},
                        text: "1970s",
                      ),
                    ),
                    SizedBox(height: 2.h),
                    SizedBox(
                      width: 80.w,
                      child: LoginButton(
                        onPressed: () {},
                        text: "1980s",
                      ),
                    ),
                    SizedBox(height: 2.h),
                    SizedBox(
                      width: 80.w,
                      child: LoginButton(
                        onPressed: () {},
                        text: "1990s",
                      ),
                    ),
                    SizedBox(height: 2.h),
                    SizedBox(
                      width: 80.w,
                      child: LoginButton(
                        onPressed: () {},
                        text: "2000s",
                      ),
                    ),
                    SizedBox(height: 2.h),
                    SizedBox(
                      width: 80.w,
                      child: LoginButton(
                        onPressed: () {},
                        text: "2010s",
                      ),
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
