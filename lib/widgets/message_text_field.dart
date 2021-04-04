import 'package:flutter/material.dart';

class MessageTextField extends StatelessWidget {
  final Function onChanged;
  final TextEditingController textEditingController;
  MessageTextField({this.onChanged, this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
          controller: textEditingController,
          textAlign: TextAlign.center,
          cursorColor: Colors.purple,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          style: TextStyle(fontSize: 18),
          decoration: InputDecoration(
            hintText: 'Type a message',
            hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(horizontal: 20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Colors.deepPurpleAccent, width: 1.0),
              borderRadius: BorderRadius.all(Radius.circular(32.0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Colors.deepPurpleAccent, width: 2.0),
              borderRadius: BorderRadius.all(Radius.circular(32.0)),
            ),
          ),
          onChanged: (value) => onChanged(value)),
    );
  }
}
