import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final _firestore = FirebaseFirestore.instance;

  Future<void> saveUser(String uid, String email) async {
    //String name = email.substring(0, email.indexOf('@')); jakbym chcial obciac mail do @
    try {
      await _firestore
          .collection('Users')
          .doc('$uid')
          .set({'EMAIL': email, 'SEARCHKEY': email[0].toUpperCase()});
    } catch (e) {
      print(e);
    }
  }

  Future<void> getUsers() async {
    return _firestore.collection('Users');
  }
}
