import 'package:flutter/material.dart';
import 'package:momento/constants.dart';
import 'package:momento/widgets/buttons/signUpButton.dart';
import 'package:sizer/sizer.dart';

class HelpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: brown2,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Need Help?",
                style: TextStyle(
                  fontSize: 30.sp,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 5.h),
              ...[
                "Profile",
                "Progression",
                "Resources"
              ]
                  .map((e) => Column(
                        children: [
                          SizedBox(
                            width: 80.w,
                            child: SignUpButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/$e');  
                              },
                              text: e,
                            ),
                          ),
                          SizedBox(height: 3.h),
                        ],
                      ))
                  .toList(),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.close,
                    size: 30.sp,
                    color: Colors.white,
                  )),
            ],
          ),
        ));
  }
}
