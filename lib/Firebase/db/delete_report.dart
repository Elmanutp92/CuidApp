import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final String? uId = FirebaseAuth.instance.currentUser?.uid;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

Future<void> deleteReport(String docId, Function setLoading, String reportId) async {

  
  if (uId != null) {
    try {
      setLoading();
      await _firestore
          .collection('users')
          .doc(uId)
          .collection('personas')
          .doc(docId).collection('reportes').doc(reportId).delete();
          
      
    } catch (e) {
     
      // Puedes realizar acciones adicionales en caso de error
    }finally{
      setLoading();
    }
  } else {
    
    // Puedes manejar el caso en que uId es nulo
  } 
}
