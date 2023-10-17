import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final User? user = FirebaseAuth.instance.currentUser;

Stream<List<Map<String, dynamic>>> personListStream() {
  final db = FirebaseFirestore.instance;
  final documentReference = db
      .collection('users')
      .doc('${user!.email}-${user!.uid}')
      .collection('personas');

  return documentReference.snapshots().map((querySnapshot) {
    return querySnapshot.docs
        .map((doc) => doc.data())
        .toList();
  });
}
