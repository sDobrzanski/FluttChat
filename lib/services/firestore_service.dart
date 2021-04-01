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
      await _firestore.collection('Users').doc('$uid').set({
        'EMAIL': email,
        'SEARCHKEY': email[0].toUpperCase(),
        'PHOTOURL': kEmptyUserPhoto
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> getUsers() async {
    return _firestore.collection('Users');
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
}
