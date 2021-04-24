import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutt_chat/services/firestore_service.dart';
import 'package:flutt_chat/widgets/user_chat_card.dart';
import 'package:flutt_chat/screens/chat_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutt_chat/bloc/messages/messages_bloc.dart';
import 'package:flutt_chat/bloc/messages/messages_event.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatsStream extends StatelessWidget {
  final _firestoreService = FirestoreService();
  final User user;
  ChatsStream({this.user});
  @override
  Widget build(BuildContext context) {
    final firestoreService = RepositoryProvider.of<FirestoreService>(context);
    final _messagesBloc = BlocProvider.of<MessagesBloc>(context);
    return StreamBuilder<QuerySnapshot>(
        stream: _firestoreService.getChats(user.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
              backgroundColor: Colors.purple,
            ));
          }
          if (!snapshot.hasData) {
            CircularProgressIndicator(
              backgroundColor: Colors.purpleAccent,
            );
          }
          return BlocProvider<MessagesBloc>(
              create: (context) => MessagesBloc(firestoreService),
              child: ListView(
                children: snapshot.data.docs.map((DocumentSnapshot document) {
                  return UserChatCard(
                    email: document.data()['EMAIL'],
                    userPic: NetworkImage(document.data()['PHOTOURL']),
                    onPressed: () async {
                      _messagesBloc.add(LoadMessages(
                        myId: user.uid,
                        userId: document.id,
                      ));
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChatScreen(
                                    user: user,
                                    userToId: document.id,
                                  )));
                    },
                  );
                }).toList(),
              ));
        });
  }
}
