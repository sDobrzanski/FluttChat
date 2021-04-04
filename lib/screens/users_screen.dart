import 'package:flutt_chat/services/firestore_service.dart';
import 'package:flutt_chat/widgets/custom_search_field.dart';
import 'package:flutt_chat/widgets/users_stream.dart';
import 'package:flutter/material.dart';
import 'package:flutt_chat/widgets/messages_bar_label.dart';
import 'package:flutt_chat/widgets/custom_app_bar.dart';
import 'package:flutt_chat/widgets/searched_users_stream.dart';

class UsersScreen extends StatefulWidget {
  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final _firestoreService = FirestoreService();
  List searchedUsers;
  bool isSearched = false;
  Stream usersStream;
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
              child: Container(
                child: Column(
                  children: [
                    CustomSearchField(
                      icon: Icons.search,
                      onChanged: (value) {
                        setState(() {
                          if (value.isNotEmpty) isSearched = true;
                          usersStream =
                              _firestoreService.getSearchedUsers(value);
                        });
                      },
                    ),
                    Expanded(
                        child: !isSearched
                            ? UsersStream()
                            : SearchedUsersStream(
                                stream: usersStream,
                              ))
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
