import 'package:cloud_firestore/cloud_firestore.dart';



Stream<Map<String, dynamic>> personStream(String personId, String userEmail, String userId) {
  
  
  final db = FirebaseFirestore.instance;
  final documentReference = db
      .collection('users')
      .doc('$userEmail-$userId')
      .collection('personas')
      .doc(personId);

  return documentReference.snapshots().map((docSnapshot) {
    return docSnapshot.data() as Map<String, dynamic>;
  });
}
