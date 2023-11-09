import 'package:flutter/material.dart';
import 'package:momento/screens/LoginScreen.dart';
import 'package:momento/screens/PreAssessmentScreen.dart';
import 'package:momento/screens/SignUpScreen.dart';
import 'package:momento/screens/StartScreen.dart';
import 'package:sizer/sizer.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (_) => StartScreen(),
        '/singup': (_) => SignUpScreen(),
        '/login': (_) => LoginScreen(),
        '/preAssessment': (_) => PreAssessmentScreen(),
      },
      title: 'Flutter Demo',
    );
  }
}

