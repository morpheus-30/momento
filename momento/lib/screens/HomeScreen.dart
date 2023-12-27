import 'package:flutter/material.dart';
import 'package:momento/constants.dart';
import 'package:momento/widgets/buttons/loginButton.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
        elevation: 2,
        leadingWidth: 30.w,
        centerTitle: true,
        title: Text(
          "Home",
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
            
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Welcome!",
                style: TextStyle(
                  fontSize: 30.sp,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                )),
            SizedBox(height: 8.h),
            Column(
              children: [ 
                ...["Games", "Resources", "High Score", "Profile", "My Coupons"]
                    .map((e) => Column(
                          children: [
                            SizedBox(
                              width: 80.w,
                              child: LoginButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/$e');
                                },
                                text: e,
                              ),
                            ),
                            SizedBox(height: 3.h),
                          ],
                        ))
                    .toList()

              ],
            )
          ],
        ),
      ),
    );
  }
}
