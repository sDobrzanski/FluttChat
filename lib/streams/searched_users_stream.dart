import 'package:flutter/material.dart';
import 'package:flutt_chat/widgets/user_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutt_chat/screens/chat_screen.dart';
import 'package:flutt_chat/services/firestore_service.dart';

class SearchedUsersStream extends StatelessWidget {
  final _firestoreService = FirestoreService();
  final Stream stream;
  final String myId;
  final String myEmail;
  final String myPhotoUrl;
  SearchedUsersStream({this.stream, this.myId, this.myPhotoUrl, this.myEmail});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: stream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: CircularProgressIndicator(
            backgroundColor: Colors.purple,
          ));
        }

        return ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            return UserCard(
              email: document.data()['EMAIL'],
              userPic: NetworkImage(document.data()['PHOTOURL']),
              onPressed: () async {
                await _firestoreService.saveChatUser(
                    myId,
                    myEmail,
                    myPhotoUrl,
                    document.id,
                    document.data()['EMAIL'],
                    document.data()['PHOTOURL']);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ChatScreen(userToId: document.id)));
              },
            );
          }).toList(),
        );
      },
    );
  }
}
