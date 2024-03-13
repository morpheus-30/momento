import 'package:flutter/material.dart';
import 'package:momento/constants.dart';
import 'package:momento/screens/pre_assessment_questions/DateScreen.dart';
import 'package:momento/widgets/buttons/loginButton.dart';
import 'package:momento/widgets/buttons/textField.dart';
import 'package:sizer/sizer.dart';

class MathScreen extends StatelessWidget {
  Map<String, dynamic> data;
  MathScreen({required this.data});

  @override
  Widget build(BuildContext context) {
    String ans = "";
    return Sizer(builder: ((context, orientation, deviceType) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leadingWidth: 25.w,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/Help');
                },
                icon: Icon(
                  Icons.help_outline_outlined,
                  color: Colors.white,
                ))
          ],
          elevation: 2,
          centerTitle: true,
          title: Text(
            "Pre-Assessment Question",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.sp,
              fontFamily: "Montserrat",
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Color(0xFFC68642),
          leading: Row(
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
                  onPressed: () {},
                  icon: Icon(
                    Icons.home,
                    color: Colors.white,
                  ))
            ],
          ),
        ),
        body: Container(
          margin: EdgeInsets.only(top: 5.h, left: 5.w, right: 5.w),
          child: Column(
            children: [
              Text("Calculate the value",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.sp,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(
                height: 5.h,
              ),
              Container(
                height: 20.h,
                width: 100.w,
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ], borderRadius: BorderRadius.circular(10), color: brown2),
                margin: EdgeInsets.only(top: 2.h),
                child: Center(
                  child: Text("44+20",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 70.sp,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              MomentotextField(
                  inputText: "Type Response",
                  onSaved: (value) {
                    ans = value;
                  }),
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                width: 90.w,
                child: LoginButton(
                  onPressed: () {
                    if(ans==""){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Please enter a value"),
                      ));
                      return;
                    }
                    data["maths"] = {
                      "ans": int.parse(ans),
                      "isCorrect": int.parse(ans) == 64 ? "true" : "false"
                    } ;
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => DateScreen(
                          data: data,
                        )));
                  },
                  text: "Continue",
                ),
              ),
            ],
          ),
        ),
      );
    }));
  }
}
