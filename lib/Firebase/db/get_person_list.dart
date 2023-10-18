import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<Map<String, dynamic>>> personListFuture(
    String userEmail, String userId) async {
  final db = FirebaseFirestore.instance;
  final documentReference =
      db.collection('users').doc('$userEmail-$userId').collection('personas');

  final querySnapshot = await documentReference.get();
  return querySnapshot.docs.map((doc) => doc.data()).toList();
}
