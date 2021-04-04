import 'package:flutter/material.dart';
import 'message_text_field.dart';

class ChatWindow extends StatelessWidget {
  final Function onChanged;
  final Function onButtonPressed;
  final Widget messagesList;
  final TextEditingController textEditingController;
  ChatWindow(
      {this.onChanged,
      this.onButtonPressed,
      this.messagesList,
      this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          messagesList,
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
                    textEditingController: textEditingController,
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
