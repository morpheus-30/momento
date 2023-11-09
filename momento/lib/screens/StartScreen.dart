import 'package:flutter/material.dart';
import 'package:momento/widgets/buttons/loginButton.dart';
import 'package:momento/widgets/buttons/signUpButton.dart';
import 'package:momento/constants.dart';
import 'package:sizer/sizer.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
        backgroundColor: brown2,
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Center(child: SizedBox(width:85.w,child: Image.asset('assets/images/logo.jpeg'))),
            Container(
              margin: EdgeInsets.only(bottom: 3.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    child: LoginButton(
                      onPressed: (){
                        Navigator.pushNamed(context, '/login');
                      },
                    ),
                    width: 45.w,
                  ),
                  SizedBox(width: 45.w,child: SignUpButton(onPressed: (){
                    Navigator.pushNamed(context, '/singup');
                  },)),
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
