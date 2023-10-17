import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final User? user = FirebaseAuth.instance.currentUser;

Future<Map<String, dynamic>> getPerson(String personId) async {
  final db = FirebaseFirestore.instance;
  final documentReference = db
      .collection('users')
      .doc(
          '${user!.email}-${user!.uid}')
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
    print('Error al obtener el documento de la persona: $e');
    return {}; // Retorna un mapa vacío en lugar de 'Error'
  }
}
