import 'package:flutter/material.dart';
import 'package:momento/constants.dart';

class LoginButton extends StatelessWidget {
  Function onPressed;
  LoginButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: brown2,
        shape: const RoundedRectangleBorder(
          side: BorderSide(color: Colors.white, width: 2),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
      ),
      onPressed: () {
        onPressed();
      },
      child: const Text(
        'Log In',
        style: TextStyle(
          fontSize: 15,
          color: Colors.white,
          fontFamily: "Montserrat",
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
