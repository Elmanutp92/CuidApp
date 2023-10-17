import 'package:cloud_firestore/cloud_firestore.dart';

Stream<List<Map<String, dynamic>>> personListStream(
    String userEmail, String userId) {
  final db = FirebaseFirestore.instance;
  final documentReference =
      db.collection('users').doc('$userEmail-$userId').collection('personas');

  return documentReference.snapshots().map((querySnapshot) {
    return querySnapshot.docs.map((doc) => doc.data()).toList();
  });
}
