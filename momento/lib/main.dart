import 'package:flutter/material.dart';
import 'package:momento/screens/Games/GamesRecommendations.dart';
import 'package:momento/screens/Games/mystery%20lyrics/MysteryLyricHelpScreen.dart';
import 'package:momento/screens/Games/pattern/PatternHelpScreen.dart';
import 'package:momento/screens/HelpScreen.dart';
import 'package:momento/screens/Games/HighScoreScreen.dart';
import 'package:momento/screens/MusicPreferences/MusicPreferences.dart';
import 'package:momento/screens/Profile/EditProfile.dart';
import 'package:momento/screens/HomeScreen.dart';
import 'package:momento/screens/LoginScreen.dart';
import 'package:momento/screens/PreAssessmentScreen.dart';
import 'package:momento/screens/Profile/ProfileScreen.dart';
import 'package:momento/screens/Resources/LinkResourcesScreen.dart';
import 'package:momento/screens/SignUpScreen.dart';
import 'package:momento/screens/StartScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
  
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  void initState() async {
    print('initializing firebase');
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  // This widget is the root of your application.
  @override
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
        '/Games': (_) => GamesRecommendationScreen(),
        '/Help': (_) => HelpScreen(),
        '/Music Preferences': (_) => MusicPreferencesScreen(),
        '/Resources': (_) => ResourcesLinksScreen(),
        '/Progression': (_) => HighScoreScreen(),
        '/mysteryLyricsHelp': (_) => MysteryLyricHelpScreen(),
        '/patternHelp': (_) => PatternHelp(),
      },
    );
  }
}
