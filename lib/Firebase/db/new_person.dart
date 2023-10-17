import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

Future<void> newPerson(String name, String lastName, String age, String gender,
    Function newPersonOk, Function newPersonFail, Function setLoading) async {
  final Map<String, dynamic> person = {
    'name': name,
    'lastName': lastName,
    'age': age,
    'gender': gender,
  };

  try {
    setLoading();
    if (FirebaseAuth.instance.currentUser != null) {
      final DocumentReference docRef = await _firestore
          .collection('users')
          .doc(
              '${FirebaseAuth.instance.currentUser!.email}-${FirebaseAuth.instance.currentUser!.uid}')
          .collection('personas')
          .add(person);

      if (docRef.id.isNotEmpty) {
        String personId = docRef.id;

        docRef.update({'id': personId});
        newPersonOk();
      } else {
        newPersonFail();
      }
    } else {
      // Manejar el caso en que el usuario no está autenticado.

      newPersonFail();
    }
  } catch (error) {
    // Puedes manejar el error aquí, por ejemplo, mostrando un mensaje al usuario.
  } finally {
    setLoading();
  }
}
