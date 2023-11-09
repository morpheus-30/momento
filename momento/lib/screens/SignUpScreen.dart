import 'package:flutter/material.dart';
import 'package:momento/widgets/buttons/signUpButton.dart';
import 'package:momento/widgets/buttons/loginButton.dart';
import 'package:momento/constants.dart';
import 'package:momento/widgets/buttons/textField.dart';
import 'package:sizer/sizer.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
        appBar: AppBar(
          elevation: 2,
          centerTitle: true,
          title: Text(
            "Sign Up",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Montserrat",
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: brown2,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  margin: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Name",
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.black,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.bold,
                          )),
                      SizedBox(height: 1.h),
                      MomentotextField(
                        inputText: "Name",
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Username",
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.black,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.bold,
                          )),
                      SizedBox(height: 1.h),
                      MomentotextField(
                        inputText: "Username",
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Password",
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.black,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.bold,
                          )),
                      SizedBox(height: 1.h),
                      MomentotextField(
                        inputText: "Password",
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(bottom: 3.h),
                  child: SizedBox(
                    width: 85.w,
                    child: SignUpButton(
                      color: brown2,
                      textcolor: Colors.white,
                                onPressed: () {
                                  Navigator.pushReplacementNamed(context, '/preAssessment');
                                },
                              ),
                  ),
                )),
          ],
        ),
      );
    });
  }
}
