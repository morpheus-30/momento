import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:momento/widgets/buttons/signUpButton.dart';
import 'package:momento/constants.dart';
import 'package:momento/widgets/buttons/textField.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  String email = "";

  String password = "";

  bool obscureText = true;

  Future<int> signUp() async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 1;
      } else if (e.code == 'email-already-in-use') {
        return 2;
      }
    } catch (e) {
      return 3;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
        // resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 2,
          centerTitle: true,
          title: Text(
            "Sign Up",
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
                  margin: EdgeInsets.all(15),
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
                        inputText: "Ema il",
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(15),
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
                      Theme(
                        data: ThemeData(primaryColor: brown2),
                        child: TextField(
                          obscureText: obscureText,
                          onChanged: (value) {
                            password = value;
                          },
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(
                                obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: brown2,
                              ),
                              onPressed: () {
                                setState(() {
                                  obscureText = !obscureText;
                                });
                              },
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                width: 2,
                                color: brown2,
                                style: BorderStyle.solid,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                width: 2,
                                color: brown2,
                                style: BorderStyle.solid,
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.grey[200],
                            contentPadding: EdgeInsets.all(20),
                            hintText: "Password",
                            hintStyle: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[400],
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
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
                      color: brown2,
                      textcolor: Colors.white,
                      onPressed: ()async {
                        if (email == "" || password == "") {
                          SnackBar snackbar = SnackBar(
                            content: Text('Please fill in all the fields.'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackbar);
                          return;
                        }
                        if (email != "" && password != ""&& email.contains('@')&&email.contains('.')&&email.contains('com')) {
                          int signUpResult = await signUp();
                          if (signUpResult == 1) {
                            SnackBar snackbar = SnackBar(
                              content: Text('The password provided is too weak.'),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackbar);
                            return;
                          } else if (signUpResult == 2) {
                            SnackBar snackbar = SnackBar(
                              content: Text('The account already exists for that email.'),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackbar);
                            return;
                          } else if (signUpResult == 3) {
                            SnackBar snackbar = SnackBar(
                              content: Text('An error occurred while signing up.'),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackbar);
                            return;
                          }
                          // await firestore.collection('Users').doc(auth.currentUser!.uid).set({
                          //   'email': auth.currentUser!.email,
                          //   'Image':"toBeAdded"
                          // });
                          Navigator.pushReplacementNamed(
                              context, '/preAssessment');
                          return;
                        }else{
                          SnackBar snackbar = SnackBar(
                            content: Text('Please enter a valid email.'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackbar);
                          return;
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
