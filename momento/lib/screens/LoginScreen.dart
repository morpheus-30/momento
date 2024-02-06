import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:momento/screens/daily_trivia/DailytriviaIntro.dart';
import 'package:momento/widgets/buttons/signUpButton.dart';
import 'package:momento/constants.dart';
import 'package:momento/widgets/buttons/textField.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;

  String email = '';
  bool obscureText = true;

  String password = '';

  Future<int> signIn() async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return 0;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'invalid-credential') {
        print('Either the user does not exist or the password is wrong.');
        return 1;
      } 
    } catch (e) {
      print('An error occurred.');
      return 2;
    }
    return 2;
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 2,
          leadingWidth: 20.w,
          centerTitle: true,
          title: Text(
            "Log In",
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
                  margin: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Email",
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.black,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.bold,
                          )),
                      SizedBox(height: 1.h),
                      MomentotextField(
                        onSaved: (value) {
                          email = value;
                        },
                        inputText: "Email",
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20),
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
                      Row(
                        children: [
                          SizedBox(
                            width: 70.w,
                            child: MomentotextField(
                              obscureText: obscureText,
                              onSaved: (value) {
                                password = value;
                              },
                              inputText: "Password",
                            ),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          IconButton(
                            icon: Icon(
                              obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: brown2,
                            ),
                            onPressed: () {
                              obscureText = !obscureText;
                              setState(() {});
                            },
                          ),
                        ],
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
                      text: "Login",
                      color: brown2,
                      textcolor: Colors.white,
                      onPressed: () async {
                        if (email == '' || password == '') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Please fill in all fields.'),
                            ),
                          );
                          return;
                        }
                        int result = await signIn();
                        print(result);
                        if (result == 0) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DailyTriviaIntro(),
                            ),
                          );
                        } else if (result == 1) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Either the user does not exist or the password is wrong.'),
                            ),
                          );
                        }else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text('An error occurred. Please try again.'),
                            ),
                          );
                        }
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
