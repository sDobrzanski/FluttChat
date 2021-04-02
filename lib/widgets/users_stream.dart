import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutt_chat/services/firestore_service.dart';
import 'package:flutt_chat/widgets/user_card.dart';

class UsersStream extends StatelessWidget {
  final _firestoreService = FirestoreService();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestoreService.getUsers(),
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
              onPressed: () {},
            );
          }).toList(),
        );
      },
    );
  }
}
