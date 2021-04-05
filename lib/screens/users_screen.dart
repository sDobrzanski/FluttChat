import 'package:flutt_chat/constants.dart';
import 'package:flutt_chat/services/firestore_service.dart';
import 'package:flutt_chat/streams/chats_stream.dart';
import 'package:flutt_chat/widgets/text_fields/custom_search_field.dart';
import 'package:flutt_chat/streams/users_stream.dart';
import 'package:flutter/material.dart';
import 'package:flutt_chat/widgets/messages_bar_label.dart';
import 'package:flutt_chat/widgets/custom_app_bar.dart';
import 'package:flutt_chat/streams/searched_users_stream.dart';
import 'package:flutt_chat/services/auth_service.dart';

class UsersScreen extends StatefulWidget {
  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final _firestoreService = FirestoreService();
  final _authService = AuthService();
  List searchedUsers;
  bool isSearched = false;
  Stream usersStream;
  String myId;
  String myEmail;
  String myPhotoUrl;
  void getPhotoUrl() async {
    await _firestoreService
        .getPhotoUrl(_authService.user.uid)
        .then((value) => myPhotoUrl = value);
  }

  void initState() {
    super.initState();
    myId = _authService.user.uid;
    myEmail = _authService.user.email;
    getPhotoUrl();
  }

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
                    Expanded(
                      child: ChatsStream(
                        myId: myId,
                      ),
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
                            ? UsersStream(
                                myId: myId,
                                myEmail: myEmail,
                                myPhotoUrl: myPhotoUrl,
                              )
                            : SearchedUsersStream(
                                stream: usersStream,
                                myId: myId,
                                myEmail: myEmail,
                                myPhotoUrl: myPhotoUrl,
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
