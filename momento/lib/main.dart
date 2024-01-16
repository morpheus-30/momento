import 'package:flutter/material.dart';
import 'package:momento/screens/Games/GamesRecommendations.dart';
import 'package:momento/screens/Games/pattern/PatternGame.dart';
import 'package:momento/screens/HelpScreen.dart';
import 'package:momento/screens/MusicPreferences/MusicPreferences.dart';
import 'package:momento/screens/Profile/EditProfile.dart';
import 'package:momento/screens/HomeScreen.dart';
import 'package:momento/screens/LoginScreen.dart';
import 'package:momento/screens/PreAssessmentScreen.dart';
import 'package:momento/screens/Profile/ProfileScreen.dart';
import 'package:momento/screens/SignUpScreen.dart';
import 'package:momento/screens/StartScreen.dart';
import 'package:momento/screens/pre_assessment_questions/DateScreen.dart';
import 'package:sizer/sizer.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override.
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: { 
        '/': (_) => StartScreen(),
        '/singup': (_) => SignUpScreen(),
        '/login': (_) => LoginScreen(),
        '/preAssessment': (_) => PreAssessmentScreen(),
        '/home': (_) => HomeScreen(),
        '/Profile': (_) => ProfileScreen(),
        '/Edit Profile': (_) => EditProfile(),
        '/Games' : (_) => GamesRecommendationScreen(),
        '/Help' : (_) => HelpScreen(),
        '/Music Preferences' : (_) => MusicPreferencesScreen(),
      },
    );
  }
}

