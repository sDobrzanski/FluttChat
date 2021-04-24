import 'package:flutt_chat/streams/messages_stream.dart';
import 'package:flutter/material.dart';
import 'package:flutt_chat/widgets/chat_window.dart';
import 'package:flutt_chat/widgets/messages_bar_label.dart';
import 'package:flutt_chat/widgets/custom_app_bar.dart';
import 'package:flutt_chat/services/firestore_service.dart';
import 'package:flutt_chat/services/auth_service.dart';
import 'package:flutt_chat/streams/chats_stream.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutt_chat/bloc/messages/messages_bloc.dart';
import 'package:flutt_chat/bloc/messages/messages_state.dart';
import 'package:flutt_chat/bloc/messages/messages_event.dart';

class ChatScreen extends StatefulWidget {
  final String userToId;
  final User user;
  ChatScreen({this.userToId, this.user});
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _firestoreService = FirestoreService();
  final _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        user: widget.user,
      ),
      body: SafeArea(child: BlocBuilder<MessagesBloc, MessagesState>(
        builder: (context, state) {
          if (state is MessagesLoaded) {
            return Messages(
              user: widget.user,
              stream: state.messagesStream,
              userToId: widget.userToId,
            );
          }

          if (state is MessagesError) {
            return Text('${state.error}');
          }

          if (state is MessagesLoading) {
            return Text('laduje');
          }

          return Center(child: CircularProgressIndicator());
        },
      )),
    );
  }
}

class Messages extends StatefulWidget {
  final User user;
  final Stream stream;
  final String userToId;
  Messages({this.user, this.stream, this.userToId});

  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  var msgController = TextEditingController();
  String message;

  @override
  Widget build(BuildContext context) {
    final firestoreService = RepositoryProvider.of<FirestoreService>(context);
    final _messagesBloc = BlocProvider.of<MessagesBloc>(context);
    return Container(
        child: BlocProvider<MessagesBloc>(
      create: (context) => MessagesBloc(firestoreService),
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
                      user: widget.user,
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
            child: ChatWindow(
              textEditingController: msgController,
              messagesList: MessageStream(
                stream: widget.stream,
                myName: widget.user.email,
              ),
              onChanged: (value) {
                message = value;
              },
              onButtonPressed: () {
                setState(() {
                  _messagesBloc.add(SendMessage(
                      user: widget.user,
                      message: message,
                      userToId: widget.userToId));
                });
                msgController.clear();
              },
            ),
          ),
        ],
      ),
    ));
  }
}
