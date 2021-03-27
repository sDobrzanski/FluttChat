import 'package:flutt_chat/widgets/custom_search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutt_chat/widgets/messages_bar_label.dart';

class UsersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              child: Container(
                child: Column(
                  children: [
                    CustomSearchField(
                      icon: Icons.search,
                      onPressed: () {},
                      onChanged: () {},
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
