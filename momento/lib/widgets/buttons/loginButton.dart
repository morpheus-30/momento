import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:momento/constants.dart';

class LoginButton extends StatelessWidget {
  Function onPressed;
  String text;
  Color color;
  LoginButton({required this.onPressed, this.text = "Log In", this.color = brown2});
  

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: const RoundedRectangleBorder(
          side: BorderSide(
            width: 2,
            color: Colors.white,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
      ),
      onPressed: () {
        onPressed();
      },
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 15,
          color: Colors.white,
          fontFamily: "Montserrat",
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
