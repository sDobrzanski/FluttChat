import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'message_buble.dart';
import 'package:flutt_chat/services/firestore_service.dart';

class MessageStream extends StatelessWidget {
  final String myId;
  final String myName;
  final String userId;
  MessageStream({this.myId, this.myName, this.userId});
  final _firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestoreService.getMessages(myId, userId),
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
        final messages = snapshot.data.docs.reversed;
        List<MessageBubble> messageBubbles = [];
        for (var message in messages) {
          final messageText = message.data()['TEXT'];
          final messageSender = message.data()['SENDER'];

          String currentUser = myName;
          bool isMe;
          if (currentUser == messageSender) {
            isMe = true;
          } else {
            isMe = false;
          }
          final messageBubble = MessageBubble(
            sender: messageSender,
            text: messageText,
            isMe: isMe,
          );
          messageBubbles.add(messageBubble);
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.all(10),
            children: messageBubbles,
          ),
        );
      },
    );
  }
}
