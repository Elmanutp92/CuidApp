import 'package:cloud_firestore/cloud_firestore.dart';




Future<Map<String, dynamic>> getPerson(String personId, String userEmail, String userId) async {
  final db = FirebaseFirestore.instance;
  final documentReference = db
      .collection('users')
      .doc(
          '$userEmail-$userId')
      .collection('personas')
      .doc(personId);

  try {
    final DocumentSnapshot<Map<String, dynamic>> snapshot =
        await documentReference.get();

    if (snapshot.exists) {
      final Map<String, dynamic> data = snapshot.data()!;
      return data;
    } else {
      return {}; // Retorna un mapa vacío en lugar de 'Error'
    }
  } catch (e) {

    return {}; // Retorna un mapa vacío en lugar de 'Error'
  }
}
