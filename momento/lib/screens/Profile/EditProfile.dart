import 'package:flutter/material.dart';
import 'package:momento/constants.dart';
import 'package:momento/widgets/buttons/loginButton.dart';
import 'package:sizer/sizer.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications,
                color: Colors.white,
              )),
          IconButton(
            onPressed: () {
              
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
                padding: const EdgeInsets.all(10.0),
                child: CircleAvatar(
                  child: CircleAvatar(
                    backgroundColor: Colors.white.withOpacity(0.5),
                    radius: 30.w,
                    
                    child: Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 20.w,
                    ),
                  ),
                  backgroundImage: AssetImage("assets/images/profile.png"),
                  radius: 30.w,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 40.h),
            child: Center(
              child: Theme(
                data: ThemeData(
                  primaryColor: brown2,
                  primaryColorDark: brown2,
                ),
                child: SizedBox(
                  width: 80.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Username',
                        ),
                      ),
                      SizedBox(height: 3.h),
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                        ),
                      ),
                      SizedBox(height: 3.h),
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Container(
                        width: 80.w,
                        child: LoginButton(
                          onPressed: () {
                            Navigator.popUntil(context, ModalRoute.withName('/home'));
                          },
                          text: "Update Profile",
                        ),
                      ),
                    ]
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
