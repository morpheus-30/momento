import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:momento/constants.dart';
import 'package:sizer/sizer.dart';

class DailyTriviaCompleted extends StatelessWidget {

  List<Map<String, dynamic>> data;
  DailyTriviaCompleted({required this.data});

  FirebaseAuth auth = FirebaseAuth.instance;
  User user = FirebaseAuth.instance.currentUser!;

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          elevation: 0,
          leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.transparent,
              ),
              onPressed: () {
                FirebaseFirestore.instance
                    .collection('Users')
                    .doc(user.uid)
                    .update({
                  'lastDailyTriviaDone':
                      "${DateTime.now().year}${DateTime.now().month < 10 ? ('0' + DateTime.now().month.toString()) : DateTime.now().month}${DateTime.now().day < 10 ? ('0' + DateTime.now().day.toString()) : DateTime.now().day}"
                });
                Navigator.popUntil(context, (route) => route.isFirst);
                Navigator.pushReplacementNamed(context, '/home');
              }),
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
              icon: const Icon(
                Icons.close,
                color: Colors.white,
              ),
              onPressed: ()async {
                await FirebaseFirestore.instance
                    .collection('Users')
                    .doc(user.uid)
                    .update({
                  'lastDailyTriviaDone':
                      "${DateTime.now().year}${DateTime.now().month < 10 ? ('0' + DateTime.now().month.toString()) : DateTime.now().month}${DateTime.now().day < 10 ? ('0' + DateTime.now().day.toString()) : DateTime.now().day}"  
                });
                await FirebaseFirestore.instance
                        .collection('Users')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection('DailyTrivia')
                        .doc(DateTime.now().toString())
                        .set({
                          "result": data,
                        });
                Navigator.popUntil(context, (route) => route.isFirst);
                Navigator.pushReplacementNamed(context, '/home');
              },
            ),
          ]),
      backgroundColor: brown2,
      body: Center(
        child: Text("Your daily trivia is completed!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30.sp,
              color: Colors.white,
              fontFamily: "Montserrat",
              fontWeight: FontWeight.bold,
            )),
      ),
    );
  }
}
