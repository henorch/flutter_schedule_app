import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseStorageServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> registerUser(String uid, String username, String email) async {
    try {
      await _firestore
          .collection('users')
          .doc(uid)
          .set({'username': username, 'email': email});
    } catch (e) {
      // print(e);
    }
  }
}
