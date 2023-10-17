import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuida_app/pages/profile_page/profile_page2.dart';

Stream<List<Map<String, dynamic>>> reportStream(String personId) {
  final db = FirebaseFirestore.instance;
  final collectionReference = db
      .collection('users')
      .doc('${user!.email}-${user!.uid}')
      .collection('personas')
      .doc(personId)
      .collection('reportes');

  return collectionReference.snapshots().map((querySnapshot) {
    return querySnapshot.docs.map((doc) => doc.data()).toList();
  });
}
