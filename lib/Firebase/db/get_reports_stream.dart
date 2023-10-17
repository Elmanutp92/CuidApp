import 'package:cloud_firestore/cloud_firestore.dart';


Stream<List<Map<String, dynamic>>> reportStream(String personId, String userEmail, String userId ) {
  final db = FirebaseFirestore.instance;
  final collectionReference = db
      .collection('users')
      .doc('$userEmail-$userId')
      .collection('personas')
      .doc(personId)
      .collection('reportes');

  return collectionReference.snapshots().map((querySnapshot) {
    return querySnapshot.docs.map((doc) => doc.data()).toList();
  });
}
