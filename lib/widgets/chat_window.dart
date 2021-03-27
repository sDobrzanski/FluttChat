import 'package:flutter/material.dart';
import 'message_text_field.dart';

class ChatWindow extends StatelessWidget {
  final Function onChanged;
  final Function onButtonPressed;
  ChatWindow({
    this.onChanged,
    this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Divider(
              height: 2,
              color: Colors.white,
            ),
          ),
          Container(
            color: Colors.purple[100],
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: MessageTextField(
                    onChanged: (value) => onChanged(value),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: FloatingActionButton(
                    onPressed: onButtonPressed,
                    child: Icon(Icons.arrow_circle_up),
                    backgroundColor: Colors.purple,
                    elevation: 8,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
