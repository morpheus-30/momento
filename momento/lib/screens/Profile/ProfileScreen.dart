import 'package:flutter/material.dart';
import 'package:momento/constants.dart';
import 'package:momento/widgets/buttons/loginButton.dart';
import 'package:sizer/sizer.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
            onPressed: () {},
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
          "Profile",
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
      body: Stack(
        children: [
          Container(
            height: 15.h,
            color: brown2,
          ),
          Container(
            margin: EdgeInsets.only(left: 20.w, right: 20.w),
            child: CircleAvatar(
              radius: 40.w,
              backgroundColor: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/images/profile.png"),
                  radius: 30.w,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 40.h),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  "Edit Profile",
                  "Profile Overview",
                  "Music Preferences",
                  "Appointments"
                ].map((e) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 3.h),
                    width: 80.w,
                    child: LoginButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/$e');
                      },
                      text: e,
                    ),
                  );
                }).toList(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
