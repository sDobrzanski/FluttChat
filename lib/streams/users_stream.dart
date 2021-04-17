import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutt_chat/services/firestore_service.dart';
import 'package:flutt_chat/widgets/user_card.dart';
import 'package:flutt_chat/screens/chat_screen.dart';

class UsersStream extends StatelessWidget {
  final _firestoreService = FirestoreService();
  final String myId;
  final String myEmail;
  final String myPhotoUrl;
  final Stream stream;
  UsersStream({this.myId, this.myEmail, this.myPhotoUrl, this.stream});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: stream, //_firestoreService.getUsers()
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
