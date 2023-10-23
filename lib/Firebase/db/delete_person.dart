import 'package:cloud_firestore/cloud_firestore.dart';



final FirebaseFirestore _firestore = FirebaseFirestore.instance;

Future<void> deletePerson(String personId, Function setLoading, String userId, String userEmail, context, Function deletePersonOk, Function deletePersonNotOk) async {
 
    try {
      setLoading();
      await _firestore
          .collection('users')
          .doc('$userEmail-$userId')
          .collection('personas')
          .doc(personId)
          .delete();
          deletePersonOk();
           
    } catch (e) {
      deletePersonNotOk();
      // Puedes realizar acciones adicionales en caso de error
    } finally {
      setLoading();
     
    }
 
}
