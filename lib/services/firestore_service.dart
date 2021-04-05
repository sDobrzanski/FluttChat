import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase/firebase.dart' as fb;
import 'image_helper.dart';
import 'package:flutt_chat/constants.dart';

class FirestoreService {
  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;
  final _imageHelper = ImageHelper();

  Future<void> saveUser(String uid, String email) async {
    //String name = email.substring(0, email.indexOf('@')); jakbym chcial obciac mail do @
    try {
      await _firestore
          .collection('Users')
          .doc('$uid')
          .set({'EMAIL': email, 'PHOTOURL': kEmptyUserPhoto});
    } catch (e) {
      print(e);
    }
  }

  Future<void> saveChatUser(String myId, String myEmail, String myPhotoUrl,
      String userId, String email, String photoUrl) async {
    //TODO zmienic te zmienne w jednego usera
    try {
      await _firestore
          .collection(myId)
          .doc(userId)
          .set({'EMAIL': email, 'PHOTOURL': photoUrl});
      await _firestore.collection(userId).doc(myId).set({
        'EMAIL': myEmail,
        'PHOTOURL': myPhotoUrl != null ? myPhotoUrl : kEmptyUserPhoto
      });
    } catch (e) {
      throw (e);
    }
  }

  Stream getUsers() {
    return _firestore.collection('Users').limit(10).snapshots();
  }

  Stream getSearchedUsers(String searchKey) {
    return _firestore
        .collection('Users')
        .where('EMAIL', isGreaterThanOrEqualTo: searchKey)
        .where('EMAIL', isLessThan: searchKey + 'z')
        .snapshots();
  }

  Stream getMessages(String myId, String userId) {
    try {
      return _firestore
          .collection('Messages')
          .doc(myId)
          .collection(userId)
          .orderBy('TIMESTAMP')
          .snapshots();
    } catch (e) {
      throw (e);
    }
  }

  Stream getChats(String myId) {
    try {
      return _firestore.collection(myId).snapshots();
    } catch (e) {
      throw (e);
    }
  }

  Future<void> uploadToStorage(String uid) async {
    String photoUrl;
    final path = 'Users/$uid/mainPhoto';
    try {
      await _storage.ref('Users/$uid').child('mainPhoto').delete();
      photoUrl = kEmptyUserPhoto;
    } catch (e) {
      if (e.code == 'storage/object-not-found') {}
    }
    _imageHelper.uploadImage(
      onSelected: (file) {
        fb
            .storage()
            .refFromURL('gs://fluttchat-cd439.appspot.com/')
            .child(path)
            .put(file)
            .future
            .then((value) async {
          await _storage
              .ref('Users/$uid')
              .child('mainPhoto')
              .getDownloadURL()
              .then((value) async {
            photoUrl = value;
            await _firestore.collection('Users').doc(uid).update({
              'PHOTOURL': photoUrl,
            });
          });
        });
      },
    );
  }

  Future<String> getPhotoUrl(String uid) async {
    String photoUrl;
    try {
      await _storage
          .ref('Users/$uid')
          .child('mainPhoto')
          .getDownloadURL()
          .then((value) {
        photoUrl = value;
      });
    } catch (e) {
      if (e.code == 'storage/object-not-found') {
        photoUrl = kEmptyUserPhoto;
      }
    }
    return photoUrl;
  }

  Future<void> addMessage(String loggedInUserId, String toUserId,
      String currentEmail, String message) async {
    await _firestore
        .collection('Messages')
        .doc(loggedInUserId)
        .collection(toUserId)
        .add({
      'SENDER': currentEmail,
      'TEXT': message,
      'TIMESTAMP': new DateTime.now(),
    });

    await _firestore
        .collection('Messages')
        .doc(toUserId)
        .collection(loggedInUserId)
        .add({
      'SENDER': currentEmail,
      'TEXT': message,
      'TIMESTAMP': new DateTime.now(),
    });
  }
}
