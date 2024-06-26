import 'package:flutter/material.dart';
import 'package:momento/constants.dart';

class MomentotextField extends StatelessWidget {

  String inputText;
  var onSaved;
  bool obscureText = false;
  MomentotextField({required this.inputText, this.onSaved = null, this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(primaryColor: brown2),
      child: TextField(
        obscureText: obscureText,
        onChanged: onSaved,
        decoration: InputDecoration(
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
          hintText: inputText,
          hintStyle: TextStyle(
            fontSize: 12,
            color: Colors.grey[400],
            fontFamily: "Montserrat",
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
