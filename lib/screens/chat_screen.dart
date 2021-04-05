import 'package:flutt_chat/streams/messages_stream.dart';
import 'package:flutter/material.dart';
import 'package:flutt_chat/widgets/chat_window.dart';
import 'package:flutt_chat/widgets/messages_bar_label.dart';
import 'package:flutt_chat/widgets/custom_app_bar.dart';
import 'package:flutt_chat/services/firestore_service.dart';
import 'package:flutt_chat/services/auth_service.dart';
import 'package:flutt_chat/streams/chats_stream.dart';

class ChatScreen extends StatefulWidget {
  final String userToId;
  ChatScreen({this.userToId});
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _firestoreService = FirestoreService();
  final _authService = AuthService();
  var msgController = TextEditingController();
  String currentUserId;
  String currentUserEmail;
  String message;

  @override
  void initState() {
    super.initState();
    currentUserId = _authService.user.uid;
    currentUserEmail = _authService.user.email;
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
                      child: ChatsStream(myId: currentUserId),
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
                textEditingController: msgController,
                messagesList: MessageStream(
                  myId: currentUserId,
                  myName: currentUserEmail,
                  userId: widget.userToId,
                ),
                onChanged: (value) {
                  message = value;
                },
                onButtonPressed: () async {
                  await _firestoreService.addMessage(currentUserId,
                      widget.userToId, currentUserEmail, message);
                  msgController.clear();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
