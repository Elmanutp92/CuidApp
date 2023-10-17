import 'package:cloud_firestore/cloud_firestore.dart';


final FirebaseFirestore _firestore = FirebaseFirestore.instance;

Future<void> deletePerson(String personId, Function setLoading, String userId) async {
 
    try {
      setLoading();
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('personas')
          .doc(personId)
          .delete();
    } catch (e) {
      // Puedes realizar acciones adicionales en caso de error
    } finally {
      setLoading();
    }
 
}
