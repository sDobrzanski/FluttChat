import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutt_chat/services/firestore_service.dart';
import 'package:flutt_chat/widgets/user_chat_card.dart';
import 'package:flutt_chat/screens/chat_screen.dart';

class ChatsStream extends StatelessWidget {
  final _firestoreService = FirestoreService();
  final String myId;
  ChatsStream({this.myId});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestoreService.getChats(myId),
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
          return ListView(
            children: snapshot.data.docs.map((DocumentSnapshot document) {
              return UserChatCard(
                email: document.data()['EMAIL'],
                userPic: NetworkImage(document.data()['PHOTOURL']),
                message: 'Last message',
                onPressed: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChatScreen(
                                userToId: document.id,
                              )));
                },
              );
            }).toList(),
          );
        });
  }
}
