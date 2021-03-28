import 'package:flutter/material.dart';
import 'package:flutt_chat/widgets/chat_window.dart';
import 'package:flutt_chat/widgets/messages_bar_label.dart';
import 'package:flutt_chat/widgets/custom_app_bar.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Container(
                child: Column(
                  children: <Widget>[
                    MessageBarLabel(),
                    Divider(
                      height: 1,
                      thickness: 1,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
            VerticalDivider(
              width: 1,
              thickness: 1,
              color: Colors.black,
            ),
            Expanded(
              flex: 3,
              child: ChatWindow(
                onChanged: (value) {},
                onButtonPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
