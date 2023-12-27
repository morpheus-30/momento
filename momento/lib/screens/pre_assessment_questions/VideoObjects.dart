import 'package:flutter/material.dart';
import 'package:momento/constants.dart';
import 'package:momento/screens/pre_assessment_questions/MathScreen.dart';
import 'package:momento/widgets/buttons/loginButton.dart';
import 'package:momento/widgets/buttons/textField.dart';
import 'package:sizer/sizer.dart';

class VideoScreen extends StatelessWidget {
  const VideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leadingWidth: 25.w,
          actions: [
            IconButton(
                onPressed: () {},
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
          backgroundColor: brown2,
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
          margin: EdgeInsets.only(top: 2.h),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                  right: 5.w,
                  left: 5.w,
                ),
                child: Text("List 4 Objects from the video",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17.sp,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.bold,
                    )),
              ),
              Container(
                margin: EdgeInsets.only(
                    right: 5.w, left: 5.w, top: 2.h, bottom: 2.h),
                height: 30.h,
                width: 100.w,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://static.vecteezy.com/system/resources/thumbnails/023/595/164/small/rabbit-in-the-forest-at-sunset-animal-in-nature-easter-bunny-wildlife-scene-generative-ai-photo.jpg"),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: brown2,
                    width: 2,
                  ),
                ),
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                  child: Container(
                    margin: EdgeInsets.all(10.h),
                    decoration: BoxDecoration(
                      color: brown2.withOpacity(0.5),
                      // borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        side: MaterialStateProperty.all<BorderSide>(
                          BorderSide(
                            color: brown2,
                            width: 2,
                          ),
                        ),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(brown2),
                        shadowColor: MaterialStateProperty.all<Color>(brown2),
                      ),
                      onPressed: () {
                        print("play video");
                      },
                      icon: Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 35.sp,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 80.w,
                child: Column(
                  children: [
                    MomentotextField(inputText: "Object #1"),
                    SizedBox(height: 2.h),
                    MomentotextField(inputText: "Object #2"),
                    SizedBox(height: 2.h),
                    MomentotextField(inputText: "Object #3"),
                    SizedBox(height: 2.h),
                    MomentotextField(inputText: "Object #4"),
                  ],
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              SizedBox(
                width: 80.w,
                child: LoginButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => MathScreen()));
                  },
                  text: "Continue",
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
