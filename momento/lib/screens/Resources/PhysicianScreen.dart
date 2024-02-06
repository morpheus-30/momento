import 'package:flutter/material.dart';
import 'package:momento/constants.dart';
import 'package:sizer/sizer.dart';

class PhysicianScreen extends StatelessWidget {
  const PhysicianScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 5.w),
        child: Column(
          children: [
            SizedBox(
              height: 6.h,
            ),
            Text(
              "Here's a list of physicians you can contact:",
              style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Montserrat"),
            ),
            ListView(
              shrinkWrap: true,
              children: [
                PhysicianListTile(
                  name: "Dr. John Doe",
                  email: "johndope@gmail.com",
                  phone: "123-456-7890",
                  imagePath: "assets/images/doctor1.jpg",
                )
              ],
            ),
            ListView(
              shrinkWrap: true,
              children: [
                PhysicianListTile(
                  name: "Dr. James T. Kirk",
                  email: "jamestkirk@gmail.com",
                  phone: "123-456-7890",
                  imagePath: "assets/images/doctor2.jpeg",
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class PhysicianListTile extends StatelessWidget {
  String name;
  String email;
  String phone;
  String imagePath;
  PhysicianListTile({super.key, required this.name, required this.email, required this.phone, required this.imagePath});


  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.sp),
      ),
      contentPadding:
          EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
      tileColor: brown2,
      leading: CircleAvatar(
        backgroundImage: AssetImage(imagePath),
        // maxRadius: 20.sp,
        // minRadius: 20.sp,
        radius: 30.sp,
      ),
      title: Text(
        name,
        style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            fontFamily: "Montserrat"),
      ),
      subtitle: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.phone,
                color: Colors.white,
              ),
              SizedBox(
                width: 1.w,
              ),
              Text(
                phone,
                style: TextStyle(
                  fontSize: 10.sp,
                  color: Colors.white,
                  fontFamily: "Montserrat",
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.email,
                color: Colors.white,
              ),
              SizedBox(
                width: 1.w,
              ),
              Text(
                email,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10.sp,
                  fontFamily: "Montserrat",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
