import 'package:flutter/material.dart';

class CustomSearchField extends StatelessWidget {
  final IconData icon;
  final Function onChanged;
  CustomSearchField({this.icon, this.onChanged});
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) => onChanged(value),
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintText: 'Search for user',
        hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.deepPurpleAccent, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.deepPurpleAccent, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
        ),
      ),
    );
  }
}
