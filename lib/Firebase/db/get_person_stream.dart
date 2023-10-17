import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuida_app/pages/profile_page/profile_page2.dart';

Stream<Map<String, dynamic>> personStream(String personId) {
  final db = FirebaseFirestore.instance;
  final documentReference = db
      .collection('users')
      .doc('${user!.email}-${user!.uid}')
      .collection('personas')
      .doc(personId);

  return documentReference.snapshots().map((docSnapshot) {
    return docSnapshot.data() as Map<String, dynamic>;
  });
}
