import 'package:flutter/material.dart';
// import 'package:momento/constants.dart';

class SignUpButton extends StatelessWidget {
  Function onPressed;
  Color color;
  Color textcolor;
  String text;
  SignUpButton({required this.onPressed, this.color = Colors.white, this.textcolor = Colors.black, this.text = "Sign Up"});
  

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: const RoundedRectangleBorder(
          side: BorderSide(color: Colors.transparent, width: 2),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
      ),
      onPressed: (){
        onPressed();
      
      },
      child: Text(
        text,
        style: TextStyle(
          color: textcolor,
          fontSize: 15,
          fontFamily: "Montserrat",
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}