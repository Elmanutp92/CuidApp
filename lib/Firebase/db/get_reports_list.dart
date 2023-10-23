import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<Map<String, dynamic>>> reportFuture(
    String personId, String userEmail, String userId) async {
  final db = FirebaseFirestore.instance;
  final collectionReference = db
      .collection('users')
      .doc('$userEmail-$userId')
      .collection('personas')
      .doc(personId)
      .collection('reportes');

  final querySnapshot = await collectionReference.get();

  return querySnapshot.docs.map((doc) => doc.data()).toList();
}
