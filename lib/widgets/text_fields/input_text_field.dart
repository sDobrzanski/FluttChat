import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  InputTextField({this.hintText, this.isPassword, this.icon, this.onChanged});
  final String hintText;
  final bool isPassword;
  final IconData icon;
  final Function onChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.35,
      child: TextField(
        onChanged: (value) => onChanged(value),
        textAlign: TextAlign.center,
        keyboardType:
            isPassword ? TextInputType.text : TextInputType.emailAddress,
        obscureText: isPassword ? true : false,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 15,
            color: Colors.grey,
          ),
          prefixIcon: Icon(
            icon,
            color: Colors.black,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.deepPurpleAccent, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.deepPurpleAccent, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
        ),
      ),
    );
  }
}
